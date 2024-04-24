-- MODULO 20 - SQL SERVER - TRANSACTIONS


/* AULA 07 - TRANCOUNT e Transa��es Aninhadas
Conforme visto, quando iniciamos uma transa��o expl�cita, como temos feito neste m�dulo, ela fica em aberto aguardando que executamos um COMMIT para salv�-la definitivamente no banco de dados, ou um ROLLBACK para desfaz�-la.

A vari�vel @@TRANCOUNT pode ser muito �til quando queremos saber quantas transa��es temos em aberto aguardando que executemos um COMMIT ou um ROLLBACK

Para verificarmos se existe alguma transa��o em aberto, vamos printar a vari�vel @@TRANCOUNT */

PRINT @@TRANCOUNT
-- Repare que o print acima retornou o n�mero 0, indicando que realmente n�o temos transa��es em aberto.

-- Agora vamos iniciar duas transa��es, imprimi-las e depois finaliz�-las com um COMMIT e um ROLLBACK
BEGIN TRANSACTION T1

	PRINT @@TRANCOUNT

	BEGIN TRANSACTION T2
		
		PRINT @@TRANCOUNT

	COMMIT TRANSACTION T2

	PRINT @@TRANCOUNT

COMMIT TRANSACTION T1

PRINT @@TRANCOUNT

ROLLBACK

/* Transa��es Aninhadas (ROLLBACK e COMMIT)
TRANSACTIONS, al�m de diversos tipos de comandos capazes de inserir, alterar ou excluir informa��es em um banco de dados, tamb�m podem conter outras transa��es dentro de seu bloco de comandos. A essas transa��es 'uma dentro da outra', chamamos de 'transa��es aninhadas'.

A grande diferan�a das transa��es aninhadas para as transa��es feitas separadamente (que temos visto at� aqui) � que, com as transa��es aninhadas, as transa��es mais internas, mesmo que contenham COMMITs OU ROLLBACKs, s� ser�o de fato salvas ou defeitas quando a transa��o principal (mais externa) for salva com um COMMIT.

Caso a transa��o externa venha a ser desfeita com um ROLLBACK, tudo que tiver sido efetuado pelas transa��es internas n�o ser� salvo, mesmo que estas transa��es internas contenham seus pr�prios COMMITs.

Em resumo, as transa��es internas s�o dependentes da transa��o externa. Vejamos um exemplo:	*/

DROP TABLE cliente_aux
SELECT *
INTO cliente_aux
FROM dCliente
SELECT * FROM cliente_aux

-- Repare que no c�digo abaixo temos uma transa��o externa (T1) e dentro dela, temos outra transa��o (T2).
-- 1. Com a T1, efetuamos um UPDATE alterando o CPF do cliente de ID n�mero 1 da tabela cliente_aux para �999.999.999-99�.
-- 2. J� com a T2, efetuamos um UPDATE alterando o CPF do cliente de ID n�mero 2 da tabela cliente_aux para �111.111.111-11�.
-- 3. Para finalizar a T2 (interna), efetuamos um COMMIT.
-- 4. Por�m, para finalizar a T1 (externa) executamos um ROLLBACK.

BEGIN TRAN T1                            -- In�cio transa��o 1
	UPDATE cliente_aux
	SET cpf = '999.999.999-99'
	WHERE id_cliente = 1
	SELECT * FROM cliente_aux

	BEGIN TRAN T2                        -- In�cio transa��o 2
		UPDATE cliente_aux
		SET cpf = '111.111.111-11'
		WHERE id_cliente = 2
		SELECT * FROM cliente_aux

	COMMIT TRAN T2                       -- Commit transa��o 2
	SELECT * FROM cliente_aux

ROLLBACK TRAN T1                           -- Rollback transa��o 1
SELECT * FROM cliente_aux


PRINT @@TRANCOUNT