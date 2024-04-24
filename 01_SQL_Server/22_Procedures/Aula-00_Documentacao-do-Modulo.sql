-- M�DULO 22 - SQL SERVER - PROCEDURES

/* AULA 01 - Introdu��o - Stored Procedures
Nesse m�dulo vamos aprender sobre procedures no SQL

- O que � uma Procedure?
- Criando uma Procedure Sem Par�metros
- Criando uma Procedure Com Par�metros
- Criando Procedure Complexas
- Excluindo Procedures
- Functions vs Procedures */


/* AULA 02 - O que � uma Procedure?
-- PROCEDURES

- 1. O que � uma Procedure
Uma PROCEDURE � um bloco de c�digo que possui um nome e pode ser armazenado no banco de dados.
Ele pode incluir uma s�rie de comandos SQL para executar alguma tarefa.

- 2. Por que usar uma Procedure
Procedures s�o usadas para fazer tarefas repetitivas que n�o s�o poss�veis em queries do SQL ou que dariam muito trabalho.
Pode incluir estruturas de controle e comandos.

- 3. Tipos de Procedure
Uma Procedure pode ou n�o aceitar par�metros de entrada

- Na PROCEDURE sem Par�metros, todas as informa��es necess�rias para sua execu��o ser�o atribu�das dentro da pr�pria PROCEDURE.
- Na PROCEDURE com Par�metros, essas informa��es ser�o fornecidas pelo usu�rio.

Podemos visualizar as procedures do sistema na pasta Programa��o > Procedimentos Armazenados > Procedimentos Armazenados do Sistema. */

------------------------------

/* AULA 03 - Criando uma Procedure Sem Par�metros

 Suponhamos que desejamos criar uma procedure para armazenar uma consulta � tabela dGerente.

 1. Iniciamos a procedure com o comando CREATE PROCEDURE e damos um nome a ela;
 2. Abrimos o bloco de execu��o com o comando BEGIN;
 3. Dentro do bloco de execu��o, passamos todas as instru��es da procedure. No caso, o nosso SELECT � tabela dGerente;
 4. Finalizamos o bloco de execu��o e a procedure com o comando END.
 5. Para executar nossa procedure, utilizamos o seguinte comando:


Exemplo 1. Crie uma Procedure que executa um SELECT simples (sem par�metros). */

USE Exercicios
Select * FROM dCliente
SELECT * FROM dGerente
SELECT * FROM fContratos

CREATE PROCEDURE prOrdenaGerentes
AS
BEGIN

	SELECT
		id_gerente,
		nome_gerente,
		salario
	FROM dGerente
	ORDER BY salario DESC

END

EXECUTE prOrdenaGerentes

-- Agora, toda vez que precisarmos visualizar o resultado dessa mesma consulta, basta utilizarmos o comando  acima e executar a procedure prOrdenaGerentes, em vez de ter que recriar todo o c�digo novamente.

------------------------------

/* AULA 04 - Criando uma Procedure Com 1 Par�metro
 Suponhamos que queiramos criar uma procedure para armazenar uma consulta � tabela dCliente que retorne apenas os clientes do sexo masculino ou feminino, a depender do que for informado pelo usu�rio.
Exemplo 2. Crie uma Procedure que executa um SELECT que recebe um par�metro de entrada para filtrar a tabela dClientes de acordo com o g�nero informado. */
SELECT * FROM dCliente

CREATE OR ALTER PROCEDURE prListaClientes(@gen VARCHAR(MAX))
AS
BEGIN

	SELECT
		nome_cliente,
		genero,
		data_de_nascimento,
		cpf
	FROM dCliente
	WHERE genero = @gen

END

EXECUTE prListaClientes 'M'

/* Repare que iniciamos com a jun��o dos comandos CREATE OR ALTER PROCEDURE. Como explicado no m�dulo de Functions, fazendo desta forma, o sistema ser� capaz de verificar:

- A. Se a procedure n�o existe, ent�o ele criar� uma nova procedure por meio do comando CREATE;
- B. Se a procedure j� existe, assim ele alterar� a procedure j� existente por meio do comando ALTER. 

Vejamos o passo a passo

1. Iniciamos a procedure como comando CREATE OR ALTER PROCEDURE, a nomeamos, e declaramos o nome e o tipo de dado do par�metro que receber� a informa��o de g�nero que ser� passada pelo usu�rio;
2. Abrimos o bloco de execu��o com o comando BEGIN;
3. Dentro do bloco de execu��o, passamos todas as instru��es da procedure. No caso, o nosso SELECT � tabela dCliente(observe que no filtro que fizemos com o comando WHERE, em vez de estabelecer que genero � = �M� ou genero = �F�, informamos o nome do par�metro que criamos na primeira linha do nosso c�digo, junto ao comando CREATE OR ALTER PROCEDURE :@gen )
4. Finalizamos o bloco de execu��o e a procedure com o comando END.

Para executar nossa procedure, utilizamos o comando EXECUTE seguido do nome da procedure e da informa��o que dever� ser passada ao par�metro @gen (no caso, 'M' para retornar todos os clientes do g�nero masculino ou 'F' para retornar todas as clientes do g�nero feminino) */

------------------------------

/* AULA 05 - Criando uma Procedure com mais de 1 par�metro
Suponhamos que agora queremos, l� na nossa procedure prListasClientes, al�m de poder filtrar nossos clientes por g�nero, tamb�m escolher o ano de sua data de nascimento. Para isso,precisaremos alterar alguns detalhes no nosso c�digo.

Vejamos o passo a passo:

- 1. Iniciamos a procedure com o comando CREATEOR ALTER PROCEDURE, a nomeamos, e declaramos os nomes e os tipos de dados dos par�metros que receber�o as informa��es de g�nero e ano de nascimento que ser�o passados pelo usu�rio;
- 2. Abrimos o bloco de execu��o com o comando BEGIN;
- 3. Dentro do bloco de execu��o, passamos todas as instru��es da procedure. No caso, o nosso SELECT � tabela dCliente(observe que no filtro que fizemos com o comando WHERE, em vez de estabelecer que genero = �M� ou genero = �F�, informamos o nome do par�metro que criamos na primeira linha do nosso c�digo, junto ao comando CREATE OR ALTER  PROCEDURE: @gen. O mesmo vale para o filtro YEAR(data_de_nascimento), pois n�o informamos um ano qualquer,  mas sim o par�metro que criamos: @ano);
- 4. Finalizamos o bloco de execu��o e a procedure com o comando END;

Para executar nossa procedure, utilizamos o comando EXECUTE seguido do nome da procedure e das informa��es que dever�o ser passadas aos par�metros @gen e @ano.

Exemplo 3. Crie uma Procedure que executa um SELECT que recebe um par�metro de entrada para filtrar a tabela dClientes de acordo com o g�nero informado e ano de nascimento informado. */
CREATE OR ALTER PROCEDURE prListaClientes(@gen VARCHAR(MAX), @ano INT)
AS
BEGIN

	SELECT
		nome_cliente,
		genero,
		data_de_nascimento,
		cpf
	FROM dCliente
	WHERE genero = @gen AND YEAR(data_de_nascimento) = @ano


END

EXECUTE prListaClientes 'M', 1989

-- Agora, que toda vez que precisarmos visualizar o resultado dessa mesma consulta, basta utilizarmos o comando acima e executar a procedure prListaClientes, em vez de ter que recriar todo o c�digo novamente.

------------------------------

/* AULA 06 - Criando uma Procedure com Par�metro Default

Podemos passar um valor (Default) para um par�metro. Esse valor default ser� sempre utilizado caso o usu�rio n�o informe nenhum valor para o par�metro em quest�o.

Vamos imaginar que queiramos alterar novamente a nossa procedure prListaClientes, para podermos incluir o valor 'M' como default no par�metro @gen. Assim, caso o usu�rio n�o informe nenhum valor, sempre retornaremos os clientes do g�nero masculino na consulta efetuada pela procedure. Para isso, alteraremos um detalhe em nosso c�digo.

Essa altera��o ocorrer� na primeira linha de comando, quando fomos especificar o par�metro @gen.

Exemplo 3. Crie uma Procedure que executa um SELECT que recebe um par�metro de entrada para filtrar a tabela dClientes de acordo com o g�nero informado e ano de nascimento informado. */

CREATE OR ALTER PROCEDURE prListaClientes(@gen VARCHAR(MAX)='M', @ano INT)
AS
BEGIN

	SELECT
		nome_cliente,
		genero,
		data_de_nascimento,
		cpf
	FROM dCliente
	WHERE genero = @gen AND YEAR(data_de_nascimento) = @ano


END

EXECUTE prListaClientes @gen = 'F', @ano = 1989

/* Obs.: Como nossa procedure possui dois par�metros, precisamos informar no comando EXECUTE os dois par�metros se quisermos um valor diferente do default no par�metro @gen ou apenas o par�metro @ano se quisermos o par�metro @gen como default. E nesse caso, como teremos que, obrigatoriamente, informar vaores tanto para o par�metro @gen quanto para o par�metro @ano, n�o faz diferen�a se informamos ou n�o o nome do par�metro no comando EXECUTE. */
------------------------------

-- AULA 07-08 - Criando uma Procedure mais Complexa para Cadastro de Contratos

SELECT * FROM dCliente
SELECT * FROM dGerente
SELECT * FROM fContratos

/*
Exemplo: Crie uma procedure para cadastrar uma nova assinatura de um contrato na tabela fContratos (com par�metros).
Gerente: Lucas Sampaio
Cliente: Gustavo Barbosa
Valor do Contrato: 5000

- 1� Passo: Definir as vari�veis a serem utilizadas.
- 2� Passo: Armazenar o valor de id_gerente de acordo com o gerente associado
- 3� Passo: Armazenar o valor de id_cliente de acordo com o nome do cliente
- 4� Passo: Armazenar a data da assinatura como sendo a data atual do sistema
- 5� Passo: Utilizar o INSERT INTO para inserir os dados na tabela fContratos
*/

CREATE OR ALTER PROCEDURE prRegistraContrato(@gerente VARCHAR(MAX), @cliente VARCHAR(MAX), @valor FLOAT)
AS
BEGIN
	DECLARE
		@vIdGerente INT,
		@vIdCliente INT

	SELECT
		@vIdGerente = id_gerente
	FROM dGerente
	WHERE nome_gerente = @gerente

	SELECT
		@vIdCliente = id_cliente
	FROM dCliente
	WHERE nome_cliente = @cliente

	INSERT INTO fContratos(data_assinatura, id_cliente, id_gerente, valor_contrato) VALUES
		(GETDATE(), @vIdCliente, @vIdGerente, @valor)

	PRINT 'Contrato registrado com sucesso!'
END

EXECUTE prRegistraContrato @gerente = 'Lucas Sampaio', @cliente = 'Gustavo Barbosa', @valor = 5000

SELECT * FROM fContratos
SELECT * FROM dCliente
SELECT * FROM dGerente

------------------------------

/* AULA 09 - Excluindo uma Procedure

Existe 2 formas de se excluir uma Procedure, de forma manual ou atrav�s do comando DROP 

- Manual: 
1. Acesse o menu de Pesquisador de Objetos;
2. Clique no Banco de Dados onde a Procedure foi criada;
3. Navegue at� a pasta Programa��o;
4. Abra a pasta 'Procedimentos Armazenados';
5. Selecione e exclua a Procedure que deseja;

- Comando DROP: */
DROP PROCEDURE prRegistraContrato

------------------------------

/* AULA 10 - Functions vs Procedures

Temos abaixo uma lista de principais diferen�as entre Functions e Procedures.

Diferen�a 1.
- Procedures s�o usadas para executar um processo, uma sequ�ncia de comandos e blocos SQL.
- Functions s�o usadas para fazer c�lculos

Diferen�a 2.
- Procedures n�o podem ser 'chamadas' dentro da cl�usula SELECT (Possue uma chamada pr�pria por meio do EXECUTE)
- Functions podem ser 'chamadas' dentro da cl�usula SELECT (desde que n�o contenham comandos SELECT)

Diferen�a 3.
- Procedures n�o precisam retornar nenhum valor
- Functions precisam retornar algum valor
*/

------------------------------

-- AULA 11 - Explica��o Exerc�cios
-- AULA 12 - Resolu��o Exerc�cio 01
-- AULA 13 - Resolu��o Exerc�cio 02
-- AULA 14 - Resolu��o Exerc�cio 03
-- AULA 15 - Resolu��o Exerc�cio 04, 05 e 06