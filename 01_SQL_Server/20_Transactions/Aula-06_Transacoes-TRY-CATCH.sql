-- MODULO 20 - SQL SERVER - TRANSACTIONS


/* AULA 06 - Transações com tratamento de erros (TRY e CATCH)
No início deste módulo, para criarmos nossa tabela cliente_aux, utilizamos as informações da tabela dCliente. Porém, se repararmos, agora, no código que foi utilizado para criar a tabela dCliente, veremos que a coluna data_de_nascimento foi definida como o tipo DATE. Isso significa que a coluna data_de_nascimento da nossa tabela cliente_aux também é do tipo DATE, já que ela foi criada com base em toda a estrutura e registros da tabela dCliente.
Vamos imaginar que descobrimos que a daa de nascimento do cliente de ID 4 estava incorreta e, portanto, precisamos corrigir essa informação 

Sabendo que a data de nascimento correta deste cliente é 15 de março de 1992, tentamos efeturar a seguinte alteração: */
BEGIN TRANSACTION T1

	UPDATE cliente_aux
	SET data_de_nascimento = '15 de março de 1992'
	WHERE id_cliente = 4

COMMIT TRANSACTION T1

-- Porém, conforme vimos, a coluna data_de_nascimento é do tipo DATE. Portanto, ela não aceitou a nova data de nascimento informada no código acima, pois, da forma como ela foi passada, o sistema entendeu que se trata de uma string (texto), e não uma data. O correto seria ter informado 15/03/1992. 

-- Todo sistema é passível de apresentar erros, por isso, é muito importante que sejamos capazes de prever esses erros, para que possamos criar mecanismos para trata-los caso aconteçam. Assim, o sistema não será abortado, pois saberá exatamente como proceder. Portanto, vamos pensar em como poderíamos ter tratado o erro apresentado, utilizando os comando TRY e CATCH.

-- Uma forma de ter resolvido esse problema, poderia ter sido por meio de um ROLLBACK: informaríamos ao sistema que ele deveria tentar efetuar o UPDATE desejado (dentro de um bloco TRY) e, caso não fosse possível, deveria ser efetuado um ROLLBACK (informado dentro de um bloco CATCH)

--  Vamos percorrer agora o passo a passo:
-- 1. Iniciamos o bloco TRY com o comando BEGIN TRY;
-- 2. Iniciamos a transação com o comando BEGIN TRANSACTION, nomeando-a T1;
-- 3. Inserimos dentro da transação o UPDATE que queremos efetuar;
-- 4. Finalizamos a transação com um COMMIT, imprimindo na tela, em seguida, a informação “Data atualizada com sucesso”;
-- 5. Finalizamos o bloco TRY com o comando END TRY;
-- Para o caso do comando inserido dentro do bloco TRY apresentar algume rro, criamos agora um bloco com o comando CATCH, que tratará o erro eventualmente retornado pelo código contido no bloco TRY.
-- 6. Para isso, iniciamos o bloco CATCH com o comando BEGIN CATCH;
-- 7.  Inserimos dentro deste bloco o comando ROLLBACK para desfazer a transação T1 criada dentro do bloco TRY, imprimindo na tela, em seguida, a informação “Data cadastrada inválida”;
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
	PRINT 'Data cadastrada inválida'
END CATCH

-- Note que, agora, se tentarmos executar este código que criamos, tentando inserir a data com a string ‘15 de março de 1992’, o sistema retornará a mensagem: (0 linhas afetadas) Data cadastrada inválida

-- Se alterarmos a data informada no nosso código para o formato correto, para que o sistema a reconheça como  sendo do tipo DATE, a alteração será devidamente efetuada e salva com um COMMIT, conforme determinado pela transação contida dentro do bloco TRY:


SELECT * FROM cliente_aux