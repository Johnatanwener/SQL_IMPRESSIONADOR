-- MODULO 20 - SQL SERVER - TRANSACTIONS


-- AULA 03 - Iniciando uma Transa��o, Commit e Rolback
SELECT * FROM cliente_aux

/*
 Vamos supor que queremos criar uma transaction para inserir um novo registro na tabela cliente_aux.
 Para explicitarmos ao banco de dados que queremos iniciar uma transa��o, devemos utilizar o comando BEGIN TRANSACTION(ou BEGIN TRAN, que tamb�m funciona da mesma forma). Em seguida, acrescentamos o c�digo do que queremos fazer: */

BEGIN TRANSACTION
INSERT INTO cliente_aux(nome_cliente, genero, data_de_nascimento, cpf) VALUES
	('Maria Julia', 'F', '30/04/1995', '987.654.321-00')
-- Se consultarmos novamente a tabela cliente_aux, veremos que o registro foi inserido:

-- Por�m, ele n�o est� definitivamente salvo, pois o inserimos por meio de uma tansa��o expl�cita que iniciamos com o BEGIN TRANSACTION. Desta forma, temos a oportunidade de verificar se este registro est� correto antes de executarmos a pr�xima a��o. E agora, temos duas op��es: Verificando que a inser��o dos dados foi efetuada de acordo com o esperado, podemos salv�-la definitivamente no banco de dados por meio de um COMMIT. Ou, percebendo que algo errado aconteceu, podemos desfazer esta inser��o por meio de um ROLLBACK.

-- Vamos supoer que verificamos que algo n�o saiu conforme o esperado e desejamos desfazer esta inser��o. Para isso, devemos utilizar o comando ROLLBAK TRANSACTION

ROLLBACK TRANSACTION
-- Consultando novamente a tabela cliente_aux, repare que o registro que hav�amos inserido foi exclu�do:

SELECT * FROM cliente_aux

-- Note que, uma vez que demos um ROLLBACK, n�o conseguimos efetuar um COMMIT para salvar essa mesma inser��o de dados:
COMMIT TRANSACTION

-- Isso acontece porque, uma transa��o, uma vez iniciada, pode ser salva com um COMMIT ou desfeita com um ROLLBACK. Enquanto n�o for efetuada nenhuma das duas a��es, a transa��o permanece em aberto.

-- Por�m, ap�s executado um COMMIT ou um ROLLBACK, essa transa��o � encerrada. Portanto, se, ap�s executado um ROLLBACK, tentarmos efeturar um COMMIT, o sistema retornar� um erro, pois a transa��o j� havia sido encerrada, n�o sendo mais poss�vel efetuar nenhuma a��o em rela��o a ela. O contr�rio tamb�m � v�lido: Ap�s um COMMIT, a transa��o � encerrada, n�o sendo poss�vel efetuar um ROLLBACK.

-- Agora, vamos executar novamente o nosso BEGIN TRANSACTION para efetuar a inser��o do mesmo registo. Assim, iniciaremos uma nova transa��o:
BEGIN TRANSACTION
INSERT INTO cliente_aux(nome_cliente, genero, data_de_nascimento, cpf) VALUES
	('Maria Julia', 'F', '30/04/1995', '987.654.321-00')

-- Repare que o registro foi mais uma vez inserido na tabela cliente_aux
-- Por�m, como j� abordado anteriormente, sabemos que ele n�o est� definitivamente salvo, pois o inserimos por meio de uma transa��o expl�cita que iniciamos com o BEGIN TRANSACTION. Desta forma, temos a oportunidade de verificar se este registo est� correto antes de executarmos a pr�xima a��o. E agora, temos novamente duas op��es.

-- Verificando que a inser��o dos dados foi efetuada de acordo com o esperado, podemos salv�-la definitivamente no banco de dados por meio de um COMMIT. Ou, percebendo que algo errado aconteceu, podemos desfazer esta inser��o por meio de um ROLLBACK.

-- No exemplo anterior, hav�amos desfeito a inser��o com um ROLLBACK. Agora, vimos que tudo saiu conforme o esperado, e por isso queremos salver essa inser��o definitivamente na nossa tabela. Para isso, executamos um COMMIT.

COMMIT TRANSACTION

-- Consultando novamente a tabela cliente_aux, veremos que o registro permaneceu l�, pois foi definitamente salvo:
SELECT * FROM cliente_aux

-- Note que, uma vez que demos um COMMIT, n�o conseguimos efetuar um ROLLBACK para excluir essa mesma inser��o de dados:

ROLLBACK TRANSACTION
-- Isso acontece porque, uma transa��o, uma vez iniciada, pode ser salva com um COMMIT ou desfeita com um ROLLBACK. Enquanto n�o for efetuada nenhuma das a��es, a transa��o permanece em aberto. Por�m, ap�s executado um COMMIT ou um ROLLBACK, essa transa��o � encerrada. Portanto, se ap�s executado um COMMIT, tentarmos efetuar um ROLLBACK, o sistema retornar� um erro, pois a transa��o j� havia sido encerrada, n�o sendo poss�vel efetuar nenhuma a��o em rela��o a ela.

-- O contrario tamb�m vale: Ap�s um ROLLBACK, a transa��o � encerrada, n�o sendo poss�vel efetuar um COMMIT.

BEGIN TRANSACTION
UPDATE cliente_aux
SET cpf = '999.999.999-99'
WHERE id_cliente = 1

ROLLBACK TRANSACTION
COMMIT TRANSACTION
