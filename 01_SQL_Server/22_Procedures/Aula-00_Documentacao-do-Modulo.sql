-- MÓDULO 22 - SQL SERVER - PROCEDURES

/* AULA 01 - Introdução - Stored Procedures
Nesse módulo vamos aprender sobre procedures no SQL

- O que é uma Procedure?
- Criando uma Procedure Sem Parâmetros
- Criando uma Procedure Com Parâmetros
- Criando Procedure Complexas
- Excluindo Procedures
- Functions vs Procedures */


/* AULA 02 - O que é uma Procedure?
-- PROCEDURES

- 1. O que é uma Procedure
Uma PROCEDURE é um bloco de código que possui um nome e pode ser armazenado no banco de dados.
Ele pode incluir uma série de comandos SQL para executar alguma tarefa.

- 2. Por que usar uma Procedure
Procedures são usadas para fazer tarefas repetitivas que não são possíveis em queries do SQL ou que dariam muito trabalho.
Pode incluir estruturas de controle e comandos.

- 3. Tipos de Procedure
Uma Procedure pode ou não aceitar parâmetros de entrada

- Na PROCEDURE sem Parâmetros, todas as informações necessárias para sua execução serão atribuídas dentro da própria PROCEDURE.
- Na PROCEDURE com Parâmetros, essas informações serão fornecidas pelo usuário.

Podemos visualizar as procedures do sistema na pasta Programação > Procedimentos Armazenados > Procedimentos Armazenados do Sistema. */

------------------------------

/* AULA 03 - Criando uma Procedure Sem Parâmetros

 Suponhamos que desejamos criar uma procedure para armazenar uma consulta à tabela dGerente.

 1. Iniciamos a procedure com o comando CREATE PROCEDURE e damos um nome a ela;
 2. Abrimos o bloco de execução com o comando BEGIN;
 3. Dentro do bloco de execução, passamos todas as instruções da procedure. No caso, o nosso SELECT à tabela dGerente;
 4. Finalizamos o bloco de execução e a procedure com o comando END.
 5. Para executar nossa procedure, utilizamos o seguinte comando:


Exemplo 1. Crie uma Procedure que executa um SELECT simples (sem parâmetros). */

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

-- Agora, toda vez que precisarmos visualizar o resultado dessa mesma consulta, basta utilizarmos o comando  acima e executar a procedure prOrdenaGerentes, em vez de ter que recriar todo o código novamente.

------------------------------

/* AULA 04 - Criando uma Procedure Com 1 Parâmetro
 Suponhamos que queiramos criar uma procedure para armazenar uma consulta à tabela dCliente que retorne apenas os clientes do sexo masculino ou feminino, a depender do que for informado pelo usuário.
Exemplo 2. Crie uma Procedure que executa um SELECT que recebe um parâmetro de entrada para filtrar a tabela dClientes de acordo com o gênero informado. */
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

/* Repare que iniciamos com a junção dos comandos CREATE OR ALTER PROCEDURE. Como explicado no módulo de Functions, fazendo desta forma, o sistema será capaz de verificar:

- A. Se a procedure não existe, então ele criará uma nova procedure por meio do comando CREATE;
- B. Se a procedure já existe, assim ele alterará a procedure já existente por meio do comando ALTER. 

Vejamos o passo a passo

1. Iniciamos a procedure como comando CREATE OR ALTER PROCEDURE, a nomeamos, e declaramos o nome e o tipo de dado do parâmetro que receberá a informação de gênero que será passada pelo usuário;
2. Abrimos o bloco de execução com o comando BEGIN;
3. Dentro do bloco de execução, passamos todas as instruções da procedure. No caso, o nosso SELECT à tabela dCliente(observe que no filtro que fizemos com o comando WHERE, em vez de estabelecer que genero é = ‘M’ ou genero = ‘F’, informamos o nome do parâmetro que criamos na primeira linha do nosso código, junto ao comando CREATE OR ALTER PROCEDURE :@gen )
4. Finalizamos o bloco de execução e a procedure com o comando END.

Para executar nossa procedure, utilizamos o comando EXECUTE seguido do nome da procedure e da informação que deverá ser passada ao parâmetro @gen (no caso, 'M' para retornar todos os clientes do gênero masculino ou 'F' para retornar todas as clientes do gênero feminino) */

------------------------------

/* AULA 05 - Criando uma Procedure com mais de 1 parâmetro
Suponhamos que agora queremos, lá na nossa procedure prListasClientes, além de poder filtrar nossos clientes por gênero, também escolher o ano de sua data de nascimento. Para isso,precisaremos alterar alguns detalhes no nosso código.

Vejamos o passo a passo:

- 1. Iniciamos a procedure com o comando CREATEOR ALTER PROCEDURE, a nomeamos, e declaramos os nomes e os tipos de dados dos parâmetros que receberão as informações de gênero e ano de nascimento que serão passados pelo usuário;
- 2. Abrimos o bloco de execução com o comando BEGIN;
- 3. Dentro do bloco de execução, passamos todas as instruções da procedure. No caso, o nosso SELECT à tabela dCliente(observe que no filtro que fizemos com o comando WHERE, em vez de estabelecer que genero = ‘M’ ou genero = ‘F’, informamos o nome do parâmetro que criamos na primeira linha do nosso código, junto ao comando CREATE OR ALTER  PROCEDURE: @gen. O mesmo vale para o filtro YEAR(data_de_nascimento), pois não informamos um ano qualquer,  mas sim o parâmetro que criamos: @ano);
- 4. Finalizamos o bloco de execução e a procedure com o comando END;

Para executar nossa procedure, utilizamos o comando EXECUTE seguido do nome da procedure e das informações que deverão ser passadas aos parâmetros @gen e @ano.

Exemplo 3. Crie uma Procedure que executa um SELECT que recebe um parâmetro de entrada para filtrar a tabela dClientes de acordo com o gênero informado e ano de nascimento informado. */
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

-- Agora, que toda vez que precisarmos visualizar o resultado dessa mesma consulta, basta utilizarmos o comando acima e executar a procedure prListaClientes, em vez de ter que recriar todo o código novamente.

------------------------------

/* AULA 06 - Criando uma Procedure com Parâmetro Default

Podemos passar um valor (Default) para um parâmetro. Esse valor default será sempre utilizado caso o usuário não informe nenhum valor para o parâmetro em questão.

Vamos imaginar que queiramos alterar novamente a nossa procedure prListaClientes, para podermos incluir o valor 'M' como default no parâmetro @gen. Assim, caso o usuário não informe nenhum valor, sempre retornaremos os clientes do gênero masculino na consulta efetuada pela procedure. Para isso, alteraremos um detalhe em nosso código.

Essa alteração ocorrerá na primeira linha de comando, quando fomos especificar o parâmetro @gen.

Exemplo 3. Crie uma Procedure que executa um SELECT que recebe um parâmetro de entrada para filtrar a tabela dClientes de acordo com o gênero informado e ano de nascimento informado. */

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

/* Obs.: Como nossa procedure possui dois parâmetros, precisamos informar no comando EXECUTE os dois parâmetros se quisermos um valor diferente do default no parâmetro @gen ou apenas o parâmetro @ano se quisermos o parâmetro @gen como default. E nesse caso, como teremos que, obrigatoriamente, informar vaores tanto para o parâmetro @gen quanto para o parâmetro @ano, não faz diferença se informamos ou não o nome do parâmetro no comando EXECUTE. */
------------------------------

-- AULA 07-08 - Criando uma Procedure mais Complexa para Cadastro de Contratos

SELECT * FROM dCliente
SELECT * FROM dGerente
SELECT * FROM fContratos

/*
Exemplo: Crie uma procedure para cadastrar uma nova assinatura de um contrato na tabela fContratos (com parâmetros).
Gerente: Lucas Sampaio
Cliente: Gustavo Barbosa
Valor do Contrato: 5000

- 1º Passo: Definir as variáveis a serem utilizadas.
- 2º Passo: Armazenar o valor de id_gerente de acordo com o gerente associado
- 3º Passo: Armazenar o valor de id_cliente de acordo com o nome do cliente
- 4º Passo: Armazenar a data da assinatura como sendo a data atual do sistema
- 5º Passo: Utilizar o INSERT INTO para inserir os dados na tabela fContratos
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

Existe 2 formas de se excluir uma Procedure, de forma manual ou através do comando DROP 

- Manual: 
1. Acesse o menu de Pesquisador de Objetos;
2. Clique no Banco de Dados onde a Procedure foi criada;
3. Navegue até a pasta Programação;
4. Abra a pasta 'Procedimentos Armazenados';
5. Selecione e exclua a Procedure que deseja;

- Comando DROP: */
DROP PROCEDURE prRegistraContrato

------------------------------

/* AULA 10 - Functions vs Procedures

Temos abaixo uma lista de principais diferenças entre Functions e Procedures.

Diferença 1.
- Procedures são usadas para executar um processo, uma sequência de comandos e blocos SQL.
- Functions são usadas para fazer cálculos

Diferença 2.
- Procedures não podem ser 'chamadas' dentro da cláusula SELECT (Possue uma chamada própria por meio do EXECUTE)
- Functions podem ser 'chamadas' dentro da cláusula SELECT (desde que não contenham comandos SELECT)

Diferença 3.
- Procedures não precisam retornar nenhum valor
- Functions precisam retornar algum valor
*/

------------------------------

-- AULA 11 - Explicação Exercícios
-- AULA 12 - Resolução Exercício 01
-- AULA 13 - Resolução Exercício 02
-- AULA 14 - Resolução Exercício 03
-- AULA 15 - Resolução Exercício 04, 05 e 06