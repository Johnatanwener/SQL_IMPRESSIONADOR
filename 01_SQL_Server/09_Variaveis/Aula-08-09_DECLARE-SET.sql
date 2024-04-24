-- M�DULO 09 - SQL SERVER - VARI�VEIS


/* AULA 08 - DECLARE e SET - DECLARANDO UMA VARI�VEL

1) O que � uma vari�vel?
Uma vari�vel � um objeto que armazena o valor de um dado. Vari�veis s�o muito �teis para tornar nossos c�lculos mais autom�ticos. Sempre que precisarmos utilizar um mesmo valor diversas vezes ao longo do c�digo, podemos utilizar vari�veis para o caso de precisarmos alterar estes valroes de uma s� vez.

2. Estrutura
Declaramos uma vari�vel dentro do SQL conforme a estrutura abaixo:

DECLARE @var tipo
SET @var = valor
SELECT @var 

Toda declar���o de vari�vel come�a com um DECLARE, seguido do nome da vari�vel (iniciado com o @), um TIPO (que pose ser INT, FLOAT, VARCHAR ou DATETIME), e na linha seguinte atribu�mos um valor a essa vari�vel.

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

-- Exemplo 1: Declare uma vari�vel chamada 'idade' e armazene o valor 30
DECLARE @idade AS INT
SET @idade = 30
SELECT @idade AS 'Idade'

-- Exemplo 2: Declare uma vari�vel chamada 'preco' e armazene o valor 10.89
DECLARE @preco AS FLOAT
SET @preco = 10.89
SELECT @preco AS 'Pre�o Unit�rio'

DECLARE @preco2 AS DECIMAL(5, 2)
SET @preco2 = 10.89
SELECT @preco2

-- Exemplo 3: Declare uma vari�vel chamada 'nome' e armazene o valor 'Mateus'
DECLARE @nome AS VARCHAR(50)
SET @nome = 'Johnatan'
SELECT @nome AS 'Nome'

-- Exemplo 4: Declare uma vari�vel chamada 'data' e armazene a data de hoje.
DECLARE @data AS DATETIME
SET @data = '27/03/2024'
SELECT @data AS 'Data de Hoje'

SELECT DAY(@data)

------------------------------

-- AULA 09 - DECLARE e SET - DECLARANDO MAIS DE UMA VARI�VEL
-- Tamb�m � poss�vel declarar mais de uma vari�vel por vez.

DECLARE @var1 TIPO1, @var2 TIPO2
SET @var1 = valor1
SET @var2 = valor2

-- Exemplo:
DECLARE @quantidade INT, @preco FLOAT, @faturamento FLOAT
SET @quantidade = 100
SET @preco = 8.99
SET @faturamento = @quantidadade * @preco


-- OP��O 1
DECLARE @var1 INT 
DECLARE @var2 INT
DECLARE @texto VARCHAR(30)
DECLARE @data DATETIME
	
SET @var1 = 10
SET @var2 = 45
SET @texto = 'Um texto qualquer'
SET @data = '18/02/2021'
SELECT @var1, @var2, @texto, @data

-- OP��O 2
DECLARE @var1 INT,
		@var2 INT,
		@texto VARCHAR(30),
		@data DATETIME
	
SET @var1 = 10
SET @var2 = 45
SET @texto = 'Um texto qualquer'
SET @data = '18/02/2021'
SELECT @var1, @var2, @texto, @data

-- OP��O 3
DECLARE @var1 INT = 10,
		@var2 INT = 45,
		@texto VARCHAR(30) = 'Um texto qualquer',
		@data DATETIME = '18/02/2021'
	
SELECT @var1, @var2, @texto, @data


-- Exerc�cio 1: A sua loja fez uma venda de 100 camisas, cada uma custando 89.99. Fa�a um SELECT para obter o resultado do faturamento (multiplica��o da quantidade vezes o pre�o).
SELECT 100 * 89.99 AS 'faturamento'


-- Exerc�cio 2: Refa�a o exerc�cio anterior utilizando vari�veis para deixar o c�lculo mais otimizado.
DECLARE @quantidade INT
DECLARE @preco FLOAT
SET @quantidade = 100
SET @preco = 89.99
SELECT @quantidade * @preco AS 'Faturamento'

DECLARE @quantidade AS INT, @preco AS FLOAT
SET @quantidade = 100
SET @preco = 8.99
SELECT @quantidade * @preco AS 'Faturamento'