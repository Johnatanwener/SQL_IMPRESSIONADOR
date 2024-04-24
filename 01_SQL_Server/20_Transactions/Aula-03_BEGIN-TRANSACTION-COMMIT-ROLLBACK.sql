-- MODULO 20 - SQL SERVER - TRANSACTIONS


-- AULA 03 - Iniciando uma Transaçâo, Commit e Rolback
SELECT * FROM cliente_aux

/*
 Vamos supor que queremos criar uma transaction para inserir um novo registro na tabela cliente_aux.
 Para explicitarmos ao banco de dados que queremos iniciar uma transação, devemos utilizar o comando BEGIN TRANSACTION(ou BEGIN TRAN, que também funciona da mesma forma). Em seguida, acrescentamos o código do que queremos fazer: */

BEGIN TRANSACTION
INSERT INTO cliente_aux(nome_cliente, genero, data_de_nascimento, cpf) VALUES
	('Maria Julia', 'F', '30/04/1995', '987.654.321-00')
-- Se consultarmos novamente a tabela cliente_aux, veremos que o registro foi inserido:

-- Porém, ele não está definitivamente salvo, pois o inserimos por meio de uma tansação explícita que iniciamos com o BEGIN TRANSACTION. Desta forma, temos a oportunidade de verificar se este registro está correto antes de executarmos a próxima ação. E agora, temos duas opções: Verificando que a inserção dos dados foi efetuada de acordo com o esperado, podemos salvá-la definitivamente no banco de dados por meio de um COMMIT. Ou, percebendo que algo errado aconteceu, podemos desfazer esta inserção por meio de um ROLLBACK.

-- Vamos supoer que verificamos que algo não saiu conforme o esperado e desejamos desfazer esta inserção. Para isso, devemos utilizar o comando ROLLBAK TRANSACTION

ROLLBACK TRANSACTION
-- Consultando novamente a tabela cliente_aux, repare que o registro que havíamos inserido foi excluído:

SELECT * FROM cliente_aux

-- Note que, uma vez que demos um ROLLBACK, não conseguimos efetuar um COMMIT para salvar essa mesma inserção de dados:
COMMIT TRANSACTION

-- Isso acontece porque, uma transação, uma vez iniciada, pode ser salva com um COMMIT ou desfeita com um ROLLBACK. Enquanto não for efetuada nenhuma das duas ações, a transação permanece em aberto.

-- Porém, após executado um COMMIT ou um ROLLBACK, essa transação é encerrada. Portanto, se, após executado um ROLLBACK, tentarmos efeturar um COMMIT, o sistema retornará um erro, pois a transação já havia sido encerrada, não sendo mais possível efetuar nenhuma ação em relação a ela. O contrário também é válido: Após um COMMIT, a transação é encerrada, não sendo possível efetuar um ROLLBACK.

-- Agora, vamos executar novamente o nosso BEGIN TRANSACTION para efetuar a inserção do mesmo registo. Assim, iniciaremos uma nova transação:
BEGIN TRANSACTION
INSERT INTO cliente_aux(nome_cliente, genero, data_de_nascimento, cpf) VALUES
	('Maria Julia', 'F', '30/04/1995', '987.654.321-00')

-- Repare que o registro foi mais uma vez inserido na tabela cliente_aux
-- Porém, como já abordado anteriormente, sabemos que ele não está definitivamente salvo, pois o inserimos por meio de uma transação explícita que iniciamos com o BEGIN TRANSACTION. Desta forma, temos a oportunidade de verificar se este registo está correto antes de executarmos a próxima ação. E agora, temos novamente duas opções.

-- Verificando que a inserção dos dados foi efetuada de acordo com o esperado, podemos salvá-la definitivamente no banco de dados por meio de um COMMIT. Ou, percebendo que algo errado aconteceu, podemos desfazer esta inserção por meio de um ROLLBACK.

-- No exemplo anterior, havíamos desfeito a inserção com um ROLLBACK. Agora, vimos que tudo saiu conforme o esperado, e por isso queremos salver essa inserção definitivamente na nossa tabela. Para isso, executamos um COMMIT.

COMMIT TRANSACTION

-- Consultando novamente a tabela cliente_aux, veremos que o registro permaneceu lá, pois foi definitamente salvo:
SELECT * FROM cliente_aux

-- Note que, uma vez que demos um COMMIT, não conseguimos efetuar um ROLLBACK para excluir essa mesma inserção de dados:

ROLLBACK TRANSACTION
-- Isso acontece porque, uma transação, uma vez iniciada, pode ser salva com um COMMIT ou desfeita com um ROLLBACK. Enquanto não for efetuada nenhuma das ações, a transação permanece em aberto. Porém, após executado um COMMIT ou um ROLLBACK, essa transação é encerrada. Portanto, se após executado um COMMIT, tentarmos efetuar um ROLLBACK, o sistema retornará um erro, pois a transação já havia sido encerrada, não sendo possível efetuar nenhuma ação em relação a ela.

-- O contrario também vale: Após um ROLLBACK, a transação é encerrada, não sendo possível efetuar um COMMIT.

BEGIN TRANSACTION
UPDATE cliente_aux
SET cpf = '999.999.999-99'
WHERE id_cliente = 1

ROLLBACK TRANSACTION
COMMIT TRANSACTION
