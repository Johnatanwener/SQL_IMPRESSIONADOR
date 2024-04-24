-- MODULO 20 - SQL SERVER - TRANSACTIONS


/* AULA 01 - Introduçâo
Nesse módulo vamos aprender sobre transactions no SQL

- O que é uma Transaction
- Begin Transaction
- Commit Transaction
- Rolback Transaction */

------------------------------

/* AULA 02 - O que e uma Transaction

1. O que é uma transaction?
Uma TRANSACTION é uma ação realizada dentro do banco de dados. Essa ação pode ser uma: atualização (UPDATE), inserção (INSERT INTO) ou exclusão (DELETE) de dados do banco. Precisamos de transações quando estamos alterando o banco de dados de alguma forma, seja inserindo, atualizando ou excluindo dados.

Normalmente, não temos muito "controle" sobre transações, a menos que a gente explicite no nosso código que queremos fazer isso. Assim, a ideia de uma transação é agrupar um conjunto de instruções a serem executadas no banco de dados, e ter a flexibilidade de:

a. Se algo der errado, desfazer aquela transação
b. Se tudo der certo, salvar aquela transação

Até agora vimos como inserir, alterar e excluir dados no banco de dados com comandos como estes abaixo: */

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


/* Quando executamos as ações acima, desta forma, não temos controle sobre desfazê-las ou salvá-las no banco de dados, pois as transações efetuadas estão implícitas (não declaradas). Mas, quando usamos transações explícitas, conseguimos controlar melhor essas ações.

E este controle é possível por meio dos comandos:

BEGIN TRANSACTION		- Com ele informamos ao sistema que estamos iniciando uma transação;
ROLLBACK TRANSACTION	- Comando TCL que usamos para desfazer uma transação no banco;
COMMIT (TRANSACTION)	- Comando TCL por meio do qual salvamos uma transação no banco;
*/

------------------------------

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

------------------------------

-- AULA 04 - Criando transações nomeadas
-- Veremos agora que podemos criar transações nomeadas. O processo é o mesmo de se criar uma transação sem nome. Devemos apenas acrescentar o nome que desejamos dar a ela após o BEGIN TRANSACTION, dessa forma:

BEGIN TRANSACTION T1 -- Nomeando transacoes
INSERT INTO cliente_aux(nome_cliente, genero, data_de_nascimento, cpf) VALUES
	('Naldo Reis', 'M', '10/02/1992', '412.889.311-90')

-- No exemplo acima, chamamos nossa transação de T1. Assim, quando formos efetuar um COMMIT ou um ROLLBACK nesta transação, informamos o nome dela junto ao comando a ser executado.

-- Commitando uma transação
COMMIT TRANSACTION T1

------------------------------

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

------------------------------

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

------------------------------

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

------------------------------

-- AULA 08 - Explicação Exercícios
-- AULA 09 - Resolução Exercício 01 e 02 */