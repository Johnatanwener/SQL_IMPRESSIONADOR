-- M�DULO 09 - SQL SERVER - VARI�VEIS

/* AULA 01 - Introdu��o ao M�dulo
Nesse m�dulo vamos aprender a criar vari�veis no SQL SERVER.

- Tipos de Dados
- CAST e FORMAT
- ROUND, FLOOR e CEILING
- DECLARE e SET
- Aplica��es de vari�veis
- PRINT
- Vari�veis globais	
*/

------------------------------

/* AULA 02 - TIPO DE DADOS
O tipo de dado � a maneira como o SQL consegue diferenciar cada valor dentro de um banco de dados. Todo dado possui um tipo espec�fico: ele pode ser um n�mero, um texto ou uma data. Em resumo, temos abaixo os 4 principais tipos de dados:

a) Inteiro
Qualquer n�mero que seja representado apenas pela sua parte inteira, sem casa decimais.
Exemplos: 1, 100, 569
O SQL entender� que estamos trabalhando com um n�mero inteiro atrav�s do identificador: INT

b) Decimal
Qualquer n�mero que contenha casas decimais.
Exemplos: 10.33, 90.91, 410.787
O SQL entender� que estamos trabalhando com um n�mero decimal atrav�s do identificador: FLOAT
O SQL entender� que estamos trabalhando com um n�mero decimal atrav�s do identificador: DECIMAL(N, M)
	N � a quantidade de d�gitos que o n�meto pode ter, incluindo casas decimais
	M � o n�mero m�ximo de casas decimais

c) Texto/String
Toda cadeira de caracteres que pode ser interpretada commo um texto.
Exemplos: 'Carla', 'Motorola', 'Pastel', '44'
O SQL entender� que estamos trabalhando com um texto atrav�s do identificador: VARCHAR(N)

d) Data
Qualquer dado no formato de data.
Exemplos: '01/01/2021', '23/03/2021'
O SQL entender� que estamos trabalhando com uma data atrav�s do identificador: DATE
O SQL entender� que estamos trabalhando com uma data/hora atrav�s do identificador: DATETIME
 */

------------------------------

-- AULA 03 - OPERA��ES B�SICAS 
SELECT 10 AS 'N�mero'
SELECT 'Johnatan' AS 'Nome'
SELECT '27/03/2024' AS 'Data'

-- Opera��es com N�meros
SELECT 10+20 AS 'Soma'
SELECT 20-5 AS 'Subtra��o'
SELECT 31*40 AS 'Multiplica��o'
SELECT 431/23 AS 'Divis�o INTEIRA' -- Retorna somente a parte inteira da divis�o
SELECT 431.0/23 AS 'Divis�o ' -- Retorna a divis�o completa (INT + FLOAT)

-- Opera��es com Texto
SELECT 'SQL' + ' ' + 'Impressionador' AS 'Curso',
'Johnatan' + ' ' + 'Wener' AS 'Aluno'

-- Opera��es com Datas
SELECT '20/06/2021' + 1 -- Neste caso ocorrer� um erro pois o SQL entender� a 'data' como um VARCHAR (caractere) e n�o como Data

------------------------------

/* AULA 04 - SQL_VARIANT_PROPERTY - IDENTIFICANDO O TIPO DE DADO
O comando SQL_VARIANT_PROPERTY � muito �til para se descobrir o tipo dos dados. 
Essa fun��o nos pede dois argumentos: o primeiro argumento � o dado que queremos descobrir o tipo, e o segundo argumento � a informa��o que queremos: BaseType, ou seja, o tipo do dado. */

SELECT 10 AS 'N�mero'
SELECT 49.50 AS 'Decimal'
SELECT 'Marcus' AS 'Nome'
SELECT '20/06/2021' AS 'Data'

SELECT SQL_VARIANT_PROPERTY(10, 'BaseType')
SELECT SQL_VARIANT_PROPERTY(49.50, 'BaseType')
SELECT SQL_VARIANT_PROPERTY('Johnatan', 'BaseType')
SELECT SQL_VARIANT_PROPERTY('20/06/2021', 'BaseType') -- Quando declaramos uma data neste formato e entre aspas simples o SQL entender� que isto � um texto.

------------------------------

/* AULA 05 - CAST - ESPECIFICANDO O TIPO DE UM DADO
A fun��o CAST nos permite especificar o tipo de um dado.

1) CAST: Fun��o para especificar o tipo dos valores.
int: inteiro, float: decimal, varchar: string/texto, datetime: data e hora */

SELECT SQL_VARIANT_PROPERTY('31/05/2014', 'BaseType')
SELECT SQL_VARIANT_PROPERTY(CAST('31/05/2014' AS DATETIME), 'BaseType') -- For�a o SQL a converter o valor no tipo de dado que deseja.


SELECT CAST(21.45 AS INT)

SELECT CAST(21.45 AS FLOAT)

SELECT CAST(18.7 AS VARCHAR)

SELECT CAST('15.6' AS FLOAT)

SELECT CAST('31/05/2014' AS DATETIME)

-- Exerc�cio 1: Crie uma consulta juntanto o texto 'O pre�o do PASTEL �: ' com o valor 30.99

SELECT 'O pre�o do PASTEL � 30.99'
SELECT 'O pre�o do PASTEL: ' + 30.99 -- Desta forma ser� retornado um erro, pois estou tentando juntar um texto com um n�mero.
SELECT 'O pre�o do PASTEL: ' + CAST(30.99 AS VARCHAR(50)) -- Desta forma eu estarei for�ando o SQL a entender o valor 30.99 como um VARCHAR, assim n�o ser� retornado o erro anterior.

-- Exerc�cio 2: Adicione 1 dia � data '20/06/2021'

SELECT '20/06/2021' + 1 -- Ser� retornado um erro pois desta forma o SQL entende a 'data' como um texto VARCHAR.
SELECT CAST('20/06/2021' AS DATETIME) + 1 -- Desta forma eu estou for�ando o SQL entender a 'data' como um DATETIME e desta forma n�o ser� retornado o erro anterior.

------------------------------

/* AULA 06 - FORMAT - FORMATA��O DE DADOS PERSONALIZADA
A fun��o FORMAT nos permite formatar um valor a partir de um determinado c�digo de formata��o. */

-- Estrtura FORMAT: SELECT FORMAT(valor, formato)

-- a) Num�ricos:
SELECT FORMAT(1000, 'N') -- � retornado o valor n�merico 1.000.00 com o separador/formata��o de milhar e decimal.
SELECT FORMAT(1000, 'G') -- � retornado o valor geral, sem o separador

-- b) Personalizados:
SELECT FORMAT(123456789, '###-##-####')

-- c) Data:
SELECT FORMAT('21/03/2021', 'dd/MM/yyy') -- O 'MM' tem que obrigatoriamente est� em mai�sculo para o SQL entender que se trata de m�s por�m, neste caso ocorrer� um erro pois o SQL est� reconhecendo a 'data' como um VARCHAR e n�o DATETIME
SELECT FORMAT(CAST('21/03/2021' AS DATETIME), 'dd/MM/yyyy')
SELECT FORMAT(CAST('21/03/2021' AS DATETIME), 'dd/MMM/yyyy') -- Se acrescentar mais 1 'M' o SQL retornar� as tr�s primeiras letras do m�s
SELECT FORMAT(CAST('21/03/2021' AS DATETIME), 'dd/MMMM/yyyy') -- Se acrescentar mais um 'M' o SQL retornar� o nome do m�s

SELECT FORMAT(CAST('21/03/2021' AS DATETIME), 'ddd') -- Ser� retornado o dia da semana abreviado e acrescentando mais um 'd' ser� retornado o nome inteiro.

-- Exerc�cio 3: Crie uma consulta juntando o texto 'A data de validade do produto �: ' com a data 17/abr/2022. obs: Voc� dever� usar o CAST para garantir que a data � entendida com o tipo DATETIME

SELECT 'A data de validade do produto �: ' + FORMAT(CAST('17/04/2022' AS DATETIME), 'dd/MMM/yyyy')

------------------------------

/* AULA 07 - ROUND, FLOOR e CEILING - FUN��ES DE ARREDONDAMENTO
Existem algumas fun��es muito �teis para arredondamento de valores: ROUND, FLOOR e CEILING.

Essas fun��es s�o bem intuitivas:

- ROUND: Arredonda um valor com uma quantidade de casas decimais.
- FLOOR: Arredonda um valor para baixo, ou seja, para um n�mero inteiro.
- CEILING: Arredonda um valor para cima, ou seja, para um n�mero inteiro acima. 

Obs.: A fun��o ROUND possui uma aplica��o al�m de apenas arredondar um valor de acordo com um n�mero de casas decimais. Na aplica��o 2 (logo abaixo) utilizamos um terceiro argumento (n�mero 1) para informar que o que queremos na verdade n�o � arredondar, mas sim cortar o n�mero na segunda casa decimal. Ent�o em vez do valor ficar 18.74 (arredondado), ele ficar� 18.73. */

-- Opera��es com n�meros
SELECT 10+20
SELECT 20-5
SELECT 31*40
SELECT 431.0/23

-- ROUND
SELECT ROUND(18.739130, 2)

-- ROUND (Truncar)
SELECT ROUND(18.739130, 2, 1)

-- FLOOR
SELECT FLOOR(18.739130)

-- CEILING
SELECT CEILING(18.739130)

------------------------------

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

------------------------------

/* 
AULA 10 - Cuidado ao executar o c�digo com vari�veis
AULA 11 - UTILIZANDO UMA VARI�VEL EM UMA CONSULTA PT. 01
� poss�vel utilizar vari�veis dentro de consultas, como mostrado no exemplo abaixo.

Criamos uma vari�vel @varDesconto para armazenar um determinado valor e usamos em nossa estrutura para calcular o pre�o com desconto em cima dos produtos.

Exemplo 1: Aplique um desconto de 10% em todos os pre�os dos produtos. Sua consulta final deve conter as colunas ProductKey, ProductName, UnitPrice e Pre�o com Desconto. */ 

preco = 100
desconto = 10% = 10/100 = 0.10
valor_do_desconto = 100 * 0.10 = 10
preco_com_desconto = 100 - 100 * 0.10 = 90
preco_com_desconto = 100 * (1 - 0.10) = 90
preco_com_desconto = 100 * (1 - desconto) = 90


DECLARE @varDesconto FLOAT
SET @varDesconto = 0.20

SELECT
	ProductKey AS 'ID',
	ProductName AS 'Nome do Produto',
	UnitPrice AS 'Pre�o Unit�rio',
	--UnitPrice * (1 - 0.10) AS 'Preco com Desconto'
	UnitPrice * (1 - @varDesconto) AS 'Preco com Desconto'
FROM
	DimProduct

------------------------------

/* AULA 12 - UTILIZANDO UMA VARI�VEL EM UMA CONSULTA PT. 02
Abaixo, temos mais um exemplo de como usar vari�veis dentro de consultas.

Dessa vez, criamos uma vari�vel @varData para tornar o filtro das consultas mais autom�tico.
Assim, sempre que precisarmos analisar uma nova data, alteramos o valor da vari�vel uma �nica vez e todos os lugares que utilizam esse c�digo ser�o atualizados automaticamente.

Crie uma vari�vel de data para otimizar a consulta abaixo. */

DECLARE @varData DATETIME
SET @varData = '01/01/1980'

SELECT 
	FirstName AS 'Nome',
	LastName AS 'Sobrenome',
	BirthDate AS 'Nascimento',
	'Cliente' AS 'Tipo'
FROM	
	DimCustomer
WHERE BirthDate >= @varData

UNION

SELECT 
	FirstName AS 'Nome',
	LastName AS 'Sobrenome',
	BirthDate AS 'Nascimento',
	'Funcion�rio' AS 'Tipo'
FROM	
	DimEmployee
WHERE BirthDate >= @varData
ORDER BY Nascimento

------------------------------

/* AULA 13 - ARMAZENANDO O RESULTATO DE UM SELECT EM UMA VARI�VEL
Podemos tamb�m armazenar o resultado de uma consulta (SELECT) dentro de uma vari�vel.

No exemplo abaixo, armazenamos dentro de duas vari�veis os resultados de dois SELECTs: um que calcula a quantidade de funcion�rios em uma empresa, e o outro que calcula a quantidade de clientes, ambos considerando uma data de nascimento.

Exemplo 0: Crie uma vari�vel de data para otimizar a consulta abaixo. */
DECLARE @varData DATETIME
DECLARE @varNumFuncionarios INT
DECLARE @varNumClientes INT
SET @varData = '01/01/1980'
SET @varNumFuncionarios = (SELECT COUNT(*) FROM DimEmployee WHERE BirthDate >= @varData)
SET @varNumClientes = (SELECT COUNT(*) FROM DimCustomer WHERE BirthDate >= @varData)

SELECT 'N�mero de Funcion�rios', @varNumFuncionarios
UNION
SELECT 'N�mero de Clientes', @varNumClientes


-- Exemplo 1: Crie uma vari�vel para armazenar a quantidade total de funcion�rios da tabela DimEmployee.
SELECT COUNT(*) FROM DimEmployee

DECLARE @varTotalFuncionarios INT
SET @varTotalFuncionarios = (SELECT COUNT(*) FROM DimEmployee)
SELECT @varTotalFuncionarios


-- Exemplo 2: Crie uma vari�vel para armazenar a quantidade total de lojas com o status Off.
SELECT COUNT(*) FROM DimStore WHERE Status = 'Off'

DECLARE @varLojasOff INT
SET @varLojasOff = (SELECT COUNT(*) FROM DimStore WHERE Status = 'Off')
SELECT @varLojasOff

------------------------------

/* AULA 14 - PRINT - PRINTANDO UMA MENSAGEM NA TELA
Um outro comando muito �til � o PRINT. Podemos criar um c�digo para printar/exibir um determinado valor na caixa de mensagens. */

SELECT * FROM DimProduct
SELECT COUNT(*) FROM DImProduct

-- Exemplo 1: Printe na tela a quantidade de lojas On e a quantidade  de lojas Off da tabela DimStore. Utilize vari�veis para isso.
SET NOCOUNT ON

DECLARE @varLojasOn INT, @varLojasOff INT
SET @varLojasOn = (SELECT COUNT(*) FROM DimStore WHERE Status = 'On')
SET @varLojasOff = (SELECT COUNT(*) FROM DimStore WHERE Status = 'Off')

SELECT @varLojasOn AS 'Lojas Abertas', @varLojasOff AS 'Lojas Fechadas'


--PRINT @varLojasOn
--PRINT @varLojasOff
-- PRINT 'O total de lojas abertas � de ' + @varLojasOn
-- PRINT 'O total de lojas fechadas � de ' + @varLojasOff)
-- Obs: Executando a consulta desta forma, ser� retornado uma mensagem de erro pois estou tentando juntar um TEXTO com um N�MERO, por isso colocamos o CAST para for�ar a variavel ser entendida como VARCHAR

PRINT 'O total de lojas abertas � de ' + CAST(@varLojasOn AS VARCHAR(30))
PRINT 'O total de lojas fechadas � de ' + CAST(@varLojasOff AS VARCHAR(30))

-- E para excluir o texto que aparece na aba Mensagens (X linhas afetadas) precisaremos inserir um comando no inicio da consulta. SET NOCOUNT ON

------------------------------

/*AULA 15 - ARMAZENANDO EM UMA VARI�VEL UM REGISTRO DE UMA CONSULTA
Vari�veis tamb�m nos permitem armazenar determinados registros dentro de uma tabela.

Registros s�o as informa��es que temos dentro de uma tabela. Por meio de um filtro ou TOP(N) � poss�vel acessar esses registros. E para fechar, conseguimos armazenar esses registros dentro de vari�veis.

No exemplo abaixo, armazenamos dentro de duas vari�veis o nome e o total vendido. Utilizamos para isso o TOPN(N) e o ORDER BY */

SELECT TOP(100) * FROM FactSales
ORDER BY SalesQuantity DESC

-- Exemplo 1: Qual � o nome do produto que teve a maior quantidade vendida EM UMA �NICA VENDA da tabela FactSales?
DECLARE @varProdutoMaisVendido INT
DECLARE @varTotalMaisVendido INT

SELECT TOP (1)
	@varProdutoMaisVendido = ProductKey, -- 2495
	@varTotalMaisVendido = SalesQuantity -- 2880
FROM
	FactSales
ORDER BY SalesQuantity DESC

PRINT @varProdutoMaisVendido
PRINT @varTotalMaisVendido

SELECT
	ProductKey,
	ProductName
FROM
	DimProduct
WHERE ProductKey = @varProdutoMaisVendido

------------------------------

/* AULA 16 - ACUMULANDO VALORES DENTRO DE UMA VARI�VEL
Vari�veis tamb�m podem acumular mais de um valor de uma vez.

Exemplo 1: Retorne uma lista com os nomes das funcion�rias do departamento de Marketing. */

-- Maneira mais simples
SELECT
	FirstName,
	DepartmentName
FROM
	DimEmployee
WHERE DepartmentName = 'Marketing' AND Gender = 'F'

-- E se eu quisesse printar na aba de Mensagens qual � o nome das funcion�rias do departamento de Marketing?
DECLARE @varListaNomes VARCHAR(MAX)
SET @varListaNomes = ''

SELECT
	@varListaNomes = @varListaNomes + FirstName + ', ' + CHAR(10)
FROM
	DimEmployee
WHERE DepartmentName = 'Marketing' AND Gender = 'F'

PRINT LEFT(@varListaNomes, DATALENGTH(@varListaNomes) - 3)

------------------------------

/* AULA 17 - VARI�VEIS GLOBAIS
O SQL possui algumas vari�veis padr�es, que podem ser acessadas quando utilizamos o @@, como mostrado abaixo.

Nos c�digos abaixo, conseguimos acessar vari�veis que retornam informa��es como: Nome do Servidor, Vers�o do Sistema ou at� mesmo a contagem de linhas de uma tabela.

Para acessar a lista de vari�veis globais ser� inclu�do depois de SELECT 2 @ '@@'. */

SELECT @@SERVERNAME AS 'Nome do Servidor' -- Descobrir o nome do servidor
SELECT @@VERSION AS 'Vers�o' -- Descobrir a vers�o do SSMS


SELECT * FROM DimProduct
SELECT @@ROWCOUNT AS 'Contagem de linhas' -- Contagem de linhas da tabela

------------------------------

-- AULA 18 - Explica��o Exerc�cios
-- AULA 19 - Resolu��o Exerc�cio 01
-- AULA 20 - Resolu��o Exerc�cio 02
-- AULA 21 - Resolu��o Exerc�cio 03
-- AULA 22 - Resolu��o Exerc�cio 04
-- AULA 23 - Resolu��o Exerc�cio 05
