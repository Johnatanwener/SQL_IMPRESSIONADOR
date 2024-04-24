-- MODULO 20 - SQL SERVER - TRANSACTIONS


/* AULA 05 - Commit e Rolback condicionais
Vamos agora, a um exemplo um pouquinho mais complexo que os anteriores, em que estabeleceremos, dentro de uma transação, uma condição para que uma inserção de dados seja salva de forma definitiva com um COMMIT, ou desfeita com um ROLLBACK.
Suponhamos que queiramos inserir no banco de dados uma cliente chamada Ruth Campos. Só que, antes de executar um COMMIT, primeiro queremos saber se o cadastro dessa cliente já existe. Para isso, podemos estabelecer uma condição: se o cadastro dessa cliente já existir, desfaça a transação, se não existir, salve a transação.

Você deve inserir a cliente Ruth Campos no banco de dados. Se esse nome já existir, desfaça a transação. Se não existir, salve a transação. */

SELECT * FROM cliente_aux

-- 1. Antes de tudo, declaramos uma variávvel chamada @contador que mais a frente receberá a contagem de quantas clientes chamadas 'Ruth Campos' existem na tabela cliente_aux;
-- 2. Iniciamos a transação com um BEGIN TRANSACTION, dando a ela o nome de T1.
-- 3. Efetuamos um INSERT INTO com os dados da cliente Ruth Campos;

DECLARE @contador INT

BEGIN TRANSACTION T1
INSERT INTO cliente_aux(nome_cliente, genero, data_de_nascimento, cpf) VALUES
	('Ruth Campos', 'F', '23/03/1992', '324.731.903-89')

-- 4. Fazemos uma contagem na tabela cliente_aux de todas as clientes que se chamam 'Ruth Campos', e armazenamos essa contagem na variável @contador que criamos anteriormente. Repare que, conforme vimos anteriormente, até agora, não tínhamos nenhuma cliente chamada Ruth Campos cadastrada na tabela cliente_aux. 
	-- Quando iniciamos a transação T1, inserimos um registo com os dados de uma cliente chamada 'Ruth Campos'. Portanto, agora, a nossa contagem (COUNT) verificará que existe o registro de uma cliente chamada 'Ruth Campos' na tabela cliente_aux, por isso armazenará na variável @contador o valor 1.

SELECT @contador = COUNT(*) FROM cliente_aux WHERE nome_cliente = 'Ruth Campos'

-- 5. Continuamos agora estabelecendo a condição: se a variável @contador for igual a 1, devemos salvar definitivamente esse novo registro executando um COMMIT na transação T1. Além disso, imprimiremos na tela a mensagem 'Ruth Campos cadastrada com sucesso'.

-- 6. Caso contrário, ou seja, se a variável @contador tiver recebido um maior maior que 1, significa que esse registro já existia na tabela, portanto, devemos desfazer essa inserção executando um ROLLBACK na transação T1. Além disso, imprimiremos na tela uma mensagem 'Ruth Campos já foi cadastrada na tabela. Insert abortado'.


IF @contador = 1
	BEGIN
		COMMIT TRANSACTION T1
		PRINT 'Ruth Campos cadastrada com sucesso.'
	END
ELSE
	BEGIN
		ROLLBACK TRANSACTION T1
		PRINT 'Ruth Campos já foi cadastrada na tabela. Insert abortado.'
	END