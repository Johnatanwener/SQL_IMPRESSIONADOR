-- MODULO 20 - SQL SERVER - TRANSACTIONS


/* AULA 01 - Introdu��o
Nesse m�dulo vamos aprender sobre transactions no SQL

- O que � uma Transaction
- Begin Transaction
- Commit Transaction
- Rolback Transaction */

------------------------------

/* AULA 02 - O que e uma Transaction

1. O que � uma transaction?
Uma TRANSACTION � uma a��o realizada dentro do banco de dados. Essa a��o pode ser uma: atualiza��o (UPDATE), inser��o (INSERT INTO) ou exclus�o (DELETE) de dados do banco. Precisamos de transa��es quando estamos alterando o banco de dados de alguma forma, seja inserindo, atualizando ou excluindo dados.

Normalmente, n�o temos muito "controle" sobre transa��es, a menos que a gente explicite no nosso c�digo que queremos fazer isso. Assim, a ideia de uma transa��o � agrupar um conjunto de instru��es a serem executadas no banco de dados, e ter a flexibilidade de:

a. Se algo der errado, desfazer aquela transa��o
b. Se tudo der certo, salvar aquela transa��o

At� agora vimos como inserir, alterar e excluir dados no banco de dados com comandos como estes abaixo: */

SELECT *
INTO cliente_aux
FROM dCliente

-- 1. Adicionamos novas linhas (registros) na tabela
INSERT INTO cliente_aux(nome_cliente, genero, data_de_nascimento, cpf) VALUES
	('Maria Julia', 'F', '30/04/1995', '987.654.321-00')


-- 2. Atualizamos linhas (registros) da tabela
UPDATE cliente_aux
	SET nome_cliente = LOWER(nome_cliente)


-- 3. Excluimos linhas (registros) da tabela
DELETE FROM dCliente
	WHERE id_cliente = 1


/* Quando executamos as a��es acima, desta forma, n�o temos controle sobre desfaz�-las ou salv�-las no banco de dados, pois as transa��es efetuadas est�o impl�citas (n�o declaradas). Mas, quando usamos transa��es expl�citas, conseguimos controlar melhor essas a��es.

E este controle � poss�vel por meio dos comandos:

BEGIN TRANSACTION		- Com ele informamos ao sistema que estamos iniciando uma transa��o;
ROLLBACK TRANSACTION	- Comando TCL que usamos para desfazer uma transa��o no banco;
COMMIT (TRANSACTION)	- Comando TCL por meio do qual salvamos uma transa��o no banco;
*/

------------------------------

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

------------------------------

-- AULA 04 - Criando transa��es nomeadas
-- Veremos agora que podemos criar transa��es nomeadas. O processo � o mesmo de se criar uma transa��o sem nome. Devemos apenas acrescentar o nome que desejamos dar a ela ap�s o BEGIN TRANSACTION, dessa forma:

BEGIN TRANSACTION T1 -- Nomeando transacoes
INSERT INTO cliente_aux(nome_cliente, genero, data_de_nascimento, cpf) VALUES
	('Naldo Reis', 'M', '10/02/1992', '412.889.311-90')

-- No exemplo acima, chamamos nossa transa��o de T1. Assim, quando formos efetuar um COMMIT ou um ROLLBACK nesta transa��o, informamos o nome dela junto ao comando a ser executado.

-- Commitando uma transa��o
COMMIT TRANSACTION T1

------------------------------

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

------------------------------

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

------------------------------

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

------------------------------

-- AULA 08 - Explica��o Exerc�cios
-- AULA 09 - Resolu��o Exerc�cio 01 e 02 */