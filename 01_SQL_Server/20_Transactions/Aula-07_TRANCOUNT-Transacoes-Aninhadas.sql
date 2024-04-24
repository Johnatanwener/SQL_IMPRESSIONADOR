-- MODULO 20 - SQL SERVER - TRANSACTIONS


/* AULA 07 - TRANCOUNT e Transações Aninhadas
Conforme visto, quando iniciamos uma transação explícita, como temos feito neste módulo, ela fica em aberto aguardando que executamos um COMMIT para salvá-la definitivamente no banco de dados, ou um ROLLBACK para desfazê-la.

A variável @@TRANCOUNT pode ser muito útil quando queremos saber quantas transações temos em aberto aguardando que executemos um COMMIT ou um ROLLBACK

Para verificarmos se existe alguma transação em aberto, vamos printar a variável @@TRANCOUNT */

PRINT @@TRANCOUNT
-- Repare que o print acima retornou o número 0, indicando que realmente não temos transações em aberto.

-- Agora vamos iniciar duas transações, imprimi-las e depois finalizá-las com um COMMIT e um ROLLBACK
BEGIN TRANSACTION T1

	PRINT @@TRANCOUNT

	BEGIN TRANSACTION T2
		
		PRINT @@TRANCOUNT

	COMMIT TRANSACTION T2

	PRINT @@TRANCOUNT

COMMIT TRANSACTION T1

PRINT @@TRANCOUNT

ROLLBACK

/* Transações Aninhadas (ROLLBACK e COMMIT)
TRANSACTIONS, além de diversos tipos de comandos capazes de inserir, alterar ou excluir informações em um banco de dados, também podem conter outras transações dentro de seu bloco de comandos. A essas transações 'uma dentro da outra', chamamos de 'transações aninhadas'.

A grande diferança das transações aninhadas para as transações feitas separadamente (que temos visto até aqui) é que, com as transações aninhadas, as transações mais internas, mesmo que contenham COMMITs OU ROLLBACKs, só serão de fato salvas ou defeitas quando a transação principal (mais externa) for salva com um COMMIT.

Caso a transação externa venha a ser desfeita com um ROLLBACK, tudo que tiver sido efetuado pelas transações internas não será salvo, mesmo que estas transações internas contenham seus próprios COMMITs.

Em resumo, as transações internas são dependentes da transação externa. Vejamos um exemplo:	*/

DROP TABLE cliente_aux
SELECT *
INTO cliente_aux
FROM dCliente
SELECT * FROM cliente_aux

-- Repare que no código abaixo temos uma transação externa (T1) e dentro dela, temos outra transação (T2).
-- 1. Com a T1, efetuamos um UPDATE alterando o CPF do cliente de ID número 1 da tabela cliente_aux para “999.999.999-99”.
-- 2. Já com a T2, efetuamos um UPDATE alterando o CPF do cliente de ID número 2 da tabela cliente_aux para “111.111.111-11”.
-- 3. Para finalizar a T2 (interna), efetuamos um COMMIT.
-- 4. Porém, para finalizar a T1 (externa) executamos um ROLLBACK.

BEGIN TRAN T1                            -- Início transação 1
	UPDATE cliente_aux
	SET cpf = '999.999.999-99'
	WHERE id_cliente = 1
	SELECT * FROM cliente_aux

	BEGIN TRAN T2                        -- Início transação 2
		UPDATE cliente_aux
		SET cpf = '111.111.111-11'
		WHERE id_cliente = 2
		SELECT * FROM cliente_aux

	COMMIT TRAN T2                       -- Commit transação 2
	SELECT * FROM cliente_aux

ROLLBACK TRAN T1                           -- Rollback transação 1
SELECT * FROM cliente_aux


PRINT @@TRANCOUNT