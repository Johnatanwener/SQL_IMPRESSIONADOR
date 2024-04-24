-- MODULO 20 - SQL SERVER - TRANSACTIONS


/* AULA 05 - Commit e Rolback condicionais
Vamos agora, a um exemplo um pouquinho mais complexo que os anteriores, em que estabeleceremos, dentro de uma transa��o, uma condi��o para que uma inser��o de dados seja salva de forma definitiva com um COMMIT, ou desfeita com um ROLLBACK.
Suponhamos que queiramos inserir no banco de dados uma cliente chamada Ruth Campos. S� que, antes de executar um COMMIT, primeiro queremos saber se o cadastro dessa cliente j� existe. Para isso, podemos estabelecer uma condi��o: se o cadastro dessa cliente j� existir, desfa�a a transa��o, se n�o existir, salve a transa��o.

Voc� deve inserir a cliente Ruth Campos no banco de dados. Se esse nome j� existir, desfa�a a transa��o. Se n�o existir, salve a transa��o. */

SELECT * FROM cliente_aux

-- 1. Antes de tudo, declaramos uma vari�vvel chamada @contador que mais a frente receber� a contagem de quantas clientes chamadas 'Ruth Campos' existem na tabela cliente_aux;
-- 2. Iniciamos a transa��o com um BEGIN TRANSACTION, dando a ela o nome de T1.
-- 3. Efetuamos um INSERT INTO com os dados da cliente Ruth Campos;

DECLARE @contador INT

BEGIN TRANSACTION T1
INSERT INTO cliente_aux(nome_cliente, genero, data_de_nascimento, cpf) VALUES
	('Ruth Campos', 'F', '23/03/1992', '324.731.903-89')

-- 4. Fazemos uma contagem na tabela cliente_aux de todas as clientes que se chamam 'Ruth Campos', e armazenamos essa contagem na vari�vel @contador que criamos anteriormente. Repare que, conforme vimos anteriormente, at� agora, n�o t�nhamos nenhuma cliente chamada Ruth Campos cadastrada na tabela cliente_aux. 
	-- Quando iniciamos a transa��o T1, inserimos um registo com os dados de uma cliente chamada 'Ruth Campos'. Portanto, agora, a nossa contagem (COUNT) verificar� que existe o registro de uma cliente chamada 'Ruth Campos' na tabela cliente_aux, por isso armazenar� na vari�vel @contador o valor 1.

SELECT @contador = COUNT(*) FROM cliente_aux WHERE nome_cliente = 'Ruth Campos'

-- 5. Continuamos agora estabelecendo a condi��o: se a vari�vel @contador for igual a 1, devemos salvar definitivamente esse novo registro executando um COMMIT na transa��o T1. Al�m disso, imprimiremos na tela a mensagem 'Ruth Campos cadastrada com sucesso'.

-- 6. Caso contr�rio, ou seja, se a vari�vel @contador tiver recebido um maior maior que 1, significa que esse registro j� existia na tabela, portanto, devemos desfazer essa inser��o executando um ROLLBACK na transa��o T1. Al�m disso, imprimiremos na tela uma mensagem 'Ruth Campos j� foi cadastrada na tabela. Insert abortado'.


IF @contador = 1
	BEGIN
		COMMIT TRANSACTION T1
		PRINT 'Ruth Campos cadastrada com sucesso.'
	END
ELSE
	BEGIN
		ROLLBACK TRANSACTION T1
		PRINT 'Ruth Campos j� foi cadastrada na tabela. Insert abortado.'
	END