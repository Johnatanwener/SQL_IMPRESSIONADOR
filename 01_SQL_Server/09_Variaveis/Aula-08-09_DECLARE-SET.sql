-- MÓDULO 09 - SQL SERVER - VARIÁVEIS


/* AULA 08 - DECLARE e SET - DECLARANDO UMA VARIÁVEL

1) O que é uma variável?
Uma variável é um objeto que armazena o valor de um dado. Variáveis são muito úteis para tornar nossos cálculos mais automáticos. Sempre que precisarmos utilizar um mesmo valor diversas vezes ao longo do código, podemos utilizar variáveis para o caso de precisarmos alterar estes valroes de uma só vez.

2. Estrutura
Declaramos uma variável dentro do SQL conforme a estrutura abaixo:

DECLARE @var tipo
SET @var = valor
SELECT @var 

Toda declarãção de variável começa com um DECLARE, seguido do nome da variável (iniciado com o @), um TIPO (que pose ser INT, FLOAT, VARCHAR ou DATETIME), e na linha seguinte atribuímos um valor a essa variável.

Exemplo:

DECLARE @quantidade INT
SET @quantidade = 100


3) Exemplo:
Em vez de...

SELECT 1000
SELECT 1000 * 1000
SELECT FORMAT (1000 * 1000, 'N')

Seria melhor...

DECLARE @numero FLOAT
SET @numero = 1000

SELECT @numero
SELECT @numero
SELECT FORMAT(@numero * @numero, 'N')

*/

-- Exemplo 1: Declare uma variável chamada 'idade' e armazene o valor 30
DECLARE @idade AS INT
SET @idade = 30
SELECT @idade AS 'Idade'

-- Exemplo 2: Declare uma variável chamada 'preco' e armazene o valor 10.89
DECLARE @preco AS FLOAT
SET @preco = 10.89
SELECT @preco AS 'Preço Unitário'

DECLARE @preco2 AS DECIMAL(5, 2)
SET @preco2 = 10.89
SELECT @preco2

-- Exemplo 3: Declare uma variável chamada 'nome' e armazene o valor 'Mateus'
DECLARE @nome AS VARCHAR(50)
SET @nome = 'Johnatan'
SELECT @nome AS 'Nome'

-- Exemplo 4: Declare uma variável chamada 'data' e armazene a data de hoje.
DECLARE @data AS DATETIME
SET @data = '27/03/2024'
SELECT @data AS 'Data de Hoje'

SELECT DAY(@data)

------------------------------

-- AULA 09 - DECLARE e SET - DECLARANDO MAIS DE UMA VARIÁVEL
-- Também é possível declarar mais de uma variável por vez.

DECLARE @var1 TIPO1, @var2 TIPO2
SET @var1 = valor1
SET @var2 = valor2

-- Exemplo:
DECLARE @quantidade INT, @preco FLOAT, @faturamento FLOAT
SET @quantidade = 100
SET @preco = 8.99
SET @faturamento = @quantidadade * @preco


-- OPÇÃO 1
DECLARE @var1 INT 
DECLARE @var2 INT
DECLARE @texto VARCHAR(30)
DECLARE @data DATETIME
	
SET @var1 = 10
SET @var2 = 45
SET @texto = 'Um texto qualquer'
SET @data = '18/02/2021'
SELECT @var1, @var2, @texto, @data

-- OPÇÃO 2
DECLARE @var1 INT,
		@var2 INT,
		@texto VARCHAR(30),
		@data DATETIME
	
SET @var1 = 10
SET @var2 = 45
SET @texto = 'Um texto qualquer'
SET @data = '18/02/2021'
SELECT @var1, @var2, @texto, @data

-- OPÇÃO 3
DECLARE @var1 INT = 10,
		@var2 INT = 45,
		@texto VARCHAR(30) = 'Um texto qualquer',
		@data DATETIME = '18/02/2021'
	
SELECT @var1, @var2, @texto, @data


-- Exercício 1: A sua loja fez uma venda de 100 camisas, cada uma custando 89.99. Faça um SELECT para obter o resultado do faturamento (multiplicação da quantidade vezes o preço).
SELECT 100 * 89.99 AS 'faturamento'


-- Exercício 2: Refaça o exercício anterior utilizando variáveis para deixar o cálculo mais otimizado.
DECLARE @quantidade INT
DECLARE @preco FLOAT
SET @quantidade = 100
SET @preco = 89.99
SELECT @quantidade * @preco AS 'Faturamento'

DECLARE @quantidade AS INT, @preco AS FLOAT
SET @quantidade = 100
SET @preco = 8.99
SELECT @quantidade * @preco AS 'Faturamento'