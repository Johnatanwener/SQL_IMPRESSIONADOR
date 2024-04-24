-- MODULO 20 - SQL SERVER - TRANSACTIONS


/* AULA 06 - Transa��es com tratamento de erros (TRY e CATCH)
No in�cio deste m�dulo, para criarmos nossa tabela cliente_aux, utilizamos as informa��es da tabela dCliente. Por�m, se repararmos, agora, no c�digo que foi utilizado para criar a tabela dCliente, veremos que a coluna data_de_nascimento foi definida como o tipo DATE. Isso significa que a coluna data_de_nascimento da nossa tabela cliente_aux tamb�m � do tipo DATE, j� que ela foi criada com base em toda a estrutura e registros da tabela dCliente.
Vamos imaginar que descobrimos que a daa de nascimento do cliente de ID 4 estava incorreta e, portanto, precisamos corrigir essa informa��o 

Sabendo que a data de nascimento correta deste cliente � 15 de mar�o de 1992, tentamos efeturar a seguinte altera��o: */
BEGIN TRANSACTION T1

	UPDATE cliente_aux
	SET data_de_nascimento = '15 de mar�o de 1992'
	WHERE id_cliente = 4

COMMIT TRANSACTION T1

-- Por�m, conforme vimos, a coluna data_de_nascimento � do tipo DATE. Portanto, ela n�o aceitou a nova data de nascimento informada no c�digo acima, pois, da forma como ela foi passada, o sistema entendeu que se trata de uma string (texto), e n�o uma data. O correto seria ter informado 15/03/1992. 

-- Todo sistema � pass�vel de apresentar erros, por isso, � muito importante que sejamos capazes de prever esses erros, para que possamos criar mecanismos para trata-los caso aconte�am. Assim, o sistema n�o ser� abortado, pois saber� exatamente como proceder. Portanto, vamos pensar em como poder�amos ter tratado o erro apresentado, utilizando os comando TRY e CATCH.

-- Uma forma de ter resolvido esse problema, poderia ter sido por meio de um ROLLBACK: informar�amos ao sistema que ele deveria tentar efetuar o UPDATE desejado (dentro de um bloco TRY) e, caso n�o fosse poss�vel, deveria ser efetuado um ROLLBACK (informado dentro de um bloco CATCH)

--  Vamos percorrer agora o passo a passo:
-- 1. Iniciamos o bloco TRY com o comando BEGIN TRY;
-- 2. Iniciamos a transa��o com o comando BEGIN TRANSACTION, nomeando-a T1;
-- 3. Inserimos dentro da transa��o o UPDATE que queremos efetuar;
-- 4. Finalizamos a transa��o com um COMMIT, imprimindo na tela, em seguida, a informa��o �Data atualizada com sucesso�;
-- 5. Finalizamos o bloco TRY com o comando END TRY;
-- Para o caso do comando inserido dentro do bloco TRY apresentar algume rro, criamos agora um bloco com o comando CATCH, que tratar� o erro eventualmente retornado pelo c�digo contido no bloco TRY.
-- 6. Para isso, iniciamos o bloco CATCH com o comando BEGIN CATCH;
-- 7.  Inserimos dentro deste bloco o comando ROLLBACK para desfazer a transa��o T1 criada dentro do bloco TRY, imprimindo na tela, em seguida, a informa��o �Data cadastrada inv�lida�;
-- 8. Finalizamos o bloco CATCH com o comando END CATCH;

BEGIN TRY
	BEGIN TRANSACTION T1

		UPDATE cliente_aux
		SET data_de_nascimento = '15/03/1992'
		WHERE id_cliente = 4

	COMMIT TRANSACTION T1
 	PRINT 'Data atualizada com sucesso'
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION T1
	PRINT 'Data cadastrada inv�lida'
END CATCH

-- Note que, agora, se tentarmos executar este c�digo que criamos, tentando inserir a data com a string �15 de mar�o de 1992�, o sistema retornar� a mensagem: (0 linhas afetadas) Data cadastrada inv�lida

-- Se alterarmos a data informada no nosso c�digo para o formato correto, para que o sistema a reconhe�a como  sendo do tipo DATE, a altera��o ser� devidamente efetuada e salva com um COMMIT, conforme determinado pela transa��o contida dentro do bloco TRY:


SELECT * FROM cliente_aux