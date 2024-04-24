-- MÓDULO 09 - SQL SERVER - VARIÁVEIS

/* AULA 01 - Introdução ao Módulo
Nesse módulo vamos aprender a criar variáveis no SQL SERVER.

- Tipos de Dados
- CAST e FORMAT
- ROUND, FLOOR e CEILING
- DECLARE e SET
- Aplicações de variáveis
- PRINT
- Variáveis globais	
*/

------------------------------

/* AULA 02 - TIPO DE DADOS
O tipo de dado é a maneira como o SQL consegue diferenciar cada valor dentro de um banco de dados. Todo dado possui um tipo específico: ele pode ser um número, um texto ou uma data. Em resumo, temos abaixo os 4 principais tipos de dados:

a) Inteiro
Qualquer número que seja representado apenas pela sua parte inteira, sem casa decimais.
Exemplos: 1, 100, 569
O SQL entenderá que estamos trabalhando com um número inteiro através do identificador: INT

b) Decimal
Qualquer número que contenha casas decimais.
Exemplos: 10.33, 90.91, 410.787
O SQL entenderá que estamos trabalhando com um número decimal através do identificador: FLOAT
O SQL entenderá que estamos trabalhando com um número decimal através do identificador: DECIMAL(N, M)
	N é a quantidade de dígitos que o númeto pode ter, incluindo casas decimais
	M é o número máximo de casas decimais

c) Texto/String
Toda cadeira de caracteres que pode ser interpretada commo um texto.
Exemplos: 'Carla', 'Motorola', 'Pastel', '44'
O SQL entenderá que estamos trabalhando com um texto através do identificador: VARCHAR(N)

d) Data
Qualquer dado no formato de data.
Exemplos: '01/01/2021', '23/03/2021'
O SQL entenderá que estamos trabalhando com uma data através do identificador: DATE
O SQL entenderá que estamos trabalhando com uma data/hora através do identificador: DATETIME
 */

------------------------------

-- AULA 03 - OPERAÇÕES BÁSICAS 
SELECT 10 AS 'Número'
SELECT 'Johnatan' AS 'Nome'
SELECT '27/03/2024' AS 'Data'

-- Operações com Números
SELECT 10+20 AS 'Soma'
SELECT 20-5 AS 'Subtração'
SELECT 31*40 AS 'Multiplicação'
SELECT 431/23 AS 'Divisão INTEIRA' -- Retorna somente a parte inteira da divisão
SELECT 431.0/23 AS 'Divisão ' -- Retorna a divisão completa (INT + FLOAT)

-- Operações com Texto
SELECT 'SQL' + ' ' + 'Impressionador' AS 'Curso',
'Johnatan' + ' ' + 'Wener' AS 'Aluno'

-- Operações com Datas
SELECT '20/06/2021' + 1 -- Neste caso ocorrerá um erro pois o SQL entenderá a 'data' como um VARCHAR (caractere) e não como Data

------------------------------

/* AULA 04 - SQL_VARIANT_PROPERTY - IDENTIFICANDO O TIPO DE DADO
O comando SQL_VARIANT_PROPERTY é muito útil para se descobrir o tipo dos dados. 
Essa função nos pede dois argumentos: o primeiro argumento é o dado que queremos descobrir o tipo, e o segundo argumento é a informação que queremos: BaseType, ou seja, o tipo do dado. */

SELECT 10 AS 'Número'
SELECT 49.50 AS 'Decimal'
SELECT 'Marcus' AS 'Nome'
SELECT '20/06/2021' AS 'Data'

SELECT SQL_VARIANT_PROPERTY(10, 'BaseType')
SELECT SQL_VARIANT_PROPERTY(49.50, 'BaseType')
SELECT SQL_VARIANT_PROPERTY('Johnatan', 'BaseType')
SELECT SQL_VARIANT_PROPERTY('20/06/2021', 'BaseType') -- Quando declaramos uma data neste formato e entre aspas simples o SQL entenderá que isto é um texto.

------------------------------

/* AULA 05 - CAST - ESPECIFICANDO O TIPO DE UM DADO
A função CAST nos permite especificar o tipo de um dado.

1) CAST: Função para especificar o tipo dos valores.
int: inteiro, float: decimal, varchar: string/texto, datetime: data e hora */

SELECT SQL_VARIANT_PROPERTY('31/05/2014', 'BaseType')
SELECT SQL_VARIANT_PROPERTY(CAST('31/05/2014' AS DATETIME), 'BaseType') -- Força o SQL a converter o valor no tipo de dado que deseja.


SELECT CAST(21.45 AS INT)

SELECT CAST(21.45 AS FLOAT)

SELECT CAST(18.7 AS VARCHAR)

SELECT CAST('15.6' AS FLOAT)

SELECT CAST('31/05/2014' AS DATETIME)

-- Exercício 1: Crie uma consulta juntanto o texto 'O preço do PASTEL é: ' com o valor 30.99

SELECT 'O preço do PASTEL é 30.99'
SELECT 'O preço do PASTEL: ' + 30.99 -- Desta forma será retornado um erro, pois estou tentando juntar um texto com um número.
SELECT 'O preço do PASTEL: ' + CAST(30.99 AS VARCHAR(50)) -- Desta forma eu estarei forçando o SQL a entender o valor 30.99 como um VARCHAR, assim não será retornado o erro anterior.

-- Exercício 2: Adicione 1 dia à data '20/06/2021'

SELECT '20/06/2021' + 1 -- Será retornado um erro pois desta forma o SQL entende a 'data' como um texto VARCHAR.
SELECT CAST('20/06/2021' AS DATETIME) + 1 -- Desta forma eu estou forçando o SQL entender a 'data' como um DATETIME e desta forma não será retornado o erro anterior.

------------------------------

/* AULA 06 - FORMAT - FORMATAÇÃO DE DADOS PERSONALIZADA
A função FORMAT nos permite formatar um valor a partir de um determinado código de formatação. */

-- Estrtura FORMAT: SELECT FORMAT(valor, formato)

-- a) Numéricos:
SELECT FORMAT(1000, 'N') -- É retornado o valor númerico 1.000.00 com o separador/formatação de milhar e decimal.
SELECT FORMAT(1000, 'G') -- È retornado o valor geral, sem o separador

-- b) Personalizados:
SELECT FORMAT(123456789, '###-##-####')

-- c) Data:
SELECT FORMAT('21/03/2021', 'dd/MM/yyy') -- O 'MM' tem que obrigatoriamente está em maiúsculo para o SQL entender que se trata de mês porém, neste caso ocorrerá um erro pois o SQL está reconhecendo a 'data' como um VARCHAR e não DATETIME
SELECT FORMAT(CAST('21/03/2021' AS DATETIME), 'dd/MM/yyyy')
SELECT FORMAT(CAST('21/03/2021' AS DATETIME), 'dd/MMM/yyyy') -- Se acrescentar mais 1 'M' o SQL retornará as três primeiras letras do mês
SELECT FORMAT(CAST('21/03/2021' AS DATETIME), 'dd/MMMM/yyyy') -- Se acrescentar mais um 'M' o SQL retornará o nome do mês

SELECT FORMAT(CAST('21/03/2021' AS DATETIME), 'ddd') -- Será retornado o dia da semana abreviado e acrescentando mais um 'd' será retornado o nome inteiro.

-- Exercício 3: Crie uma consulta juntando o texto 'A data de validade do produto é: ' com a data 17/abr/2022. obs: Você deverá usar o CAST para garantir que a data é entendida com o tipo DATETIME

SELECT 'A data de validade do produto é: ' + FORMAT(CAST('17/04/2022' AS DATETIME), 'dd/MMM/yyyy')

------------------------------

/* AULA 07 - ROUND, FLOOR e CEILING - FUNÇÕES DE ARREDONDAMENTO
Existem algumas funções muito úteis para arredondamento de valores: ROUND, FLOOR e CEILING.

Essas funções são bem intuitivas:

- ROUND: Arredonda um valor com uma quantidade de casas decimais.
- FLOOR: Arredonda um valor para baixo, ou seja, para um número inteiro.
- CEILING: Arredonda um valor para cima, ou seja, para um número inteiro acima. 

Obs.: A função ROUND possui uma aplicação além de apenas arredondar um valor de acordo com um número de casas decimais. Na aplicação 2 (logo abaixo) utilizamos um terceiro argumento (número 1) para informar que o que queremos na verdade não é arredondar, mas sim cortar o número na segunda casa decimal. Então em vez do valor ficar 18.74 (arredondado), ele ficará 18.73. */

-- Operações com números
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

------------------------------

/* 
AULA 10 - Cuidado ao executar o código com variáveis
AULA 11 - UTILIZANDO UMA VARIÁVEL EM UMA CONSULTA PT. 01
É possível utilizar variáveis dentro de consultas, como mostrado no exemplo abaixo.

Criamos uma variável @varDesconto para armazenar um determinado valor e usamos em nossa estrutura para calcular o preço com desconto em cima dos produtos.

Exemplo 1: Aplique um desconto de 10% em todos os preços dos produtos. Sua consulta final deve conter as colunas ProductKey, ProductName, UnitPrice e Preço com Desconto. */ 

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
	UnitPrice AS 'Preço Unitário',
	--UnitPrice * (1 - 0.10) AS 'Preco com Desconto'
	UnitPrice * (1 - @varDesconto) AS 'Preco com Desconto'
FROM
	DimProduct

------------------------------

/* AULA 12 - UTILIZANDO UMA VARIÁVEL EM UMA CONSULTA PT. 02
Abaixo, temos mais um exemplo de como usar variáveis dentro de consultas.

Dessa vez, criamos uma variável @varData para tornar o filtro das consultas mais automático.
Assim, sempre que precisarmos analisar uma nova data, alteramos o valor da variável uma única vez e todos os lugares que utilizam esse código serão atualizados automaticamente.

Crie uma variável de data para otimizar a consulta abaixo. */

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
	'Funcionário' AS 'Tipo'
FROM	
	DimEmployee
WHERE BirthDate >= @varData
ORDER BY Nascimento

------------------------------

/* AULA 13 - ARMAZENANDO O RESULTATO DE UM SELECT EM UMA VARIÁVEL
Podemos também armazenar o resultado de uma consulta (SELECT) dentro de uma variável.

No exemplo abaixo, armazenamos dentro de duas variáveis os resultados de dois SELECTs: um que calcula a quantidade de funcionários em uma empresa, e o outro que calcula a quantidade de clientes, ambos considerando uma data de nascimento.

Exemplo 0: Crie uma variável de data para otimizar a consulta abaixo. */
DECLARE @varData DATETIME
DECLARE @varNumFuncionarios INT
DECLARE @varNumClientes INT
SET @varData = '01/01/1980'
SET @varNumFuncionarios = (SELECT COUNT(*) FROM DimEmployee WHERE BirthDate >= @varData)
SET @varNumClientes = (SELECT COUNT(*) FROM DimCustomer WHERE BirthDate >= @varData)

SELECT 'Número de Funcionários', @varNumFuncionarios
UNION
SELECT 'Número de Clientes', @varNumClientes


-- Exemplo 1: Crie uma variável para armazenar a quantidade total de funcionários da tabela DimEmployee.
SELECT COUNT(*) FROM DimEmployee

DECLARE @varTotalFuncionarios INT
SET @varTotalFuncionarios = (SELECT COUNT(*) FROM DimEmployee)
SELECT @varTotalFuncionarios


-- Exemplo 2: Crie uma variável para armazenar a quantidade total de lojas com o status Off.
SELECT COUNT(*) FROM DimStore WHERE Status = 'Off'

DECLARE @varLojasOff INT
SET @varLojasOff = (SELECT COUNT(*) FROM DimStore WHERE Status = 'Off')
SELECT @varLojasOff

------------------------------

/* AULA 14 - PRINT - PRINTANDO UMA MENSAGEM NA TELA
Um outro comando muito útil é o PRINT. Podemos criar um código para printar/exibir um determinado valor na caixa de mensagens. */

SELECT * FROM DimProduct
SELECT COUNT(*) FROM DImProduct

-- Exemplo 1: Printe na tela a quantidade de lojas On e a quantidade  de lojas Off da tabela DimStore. Utilize variáveis para isso.
SET NOCOUNT ON

DECLARE @varLojasOn INT, @varLojasOff INT
SET @varLojasOn = (SELECT COUNT(*) FROM DimStore WHERE Status = 'On')
SET @varLojasOff = (SELECT COUNT(*) FROM DimStore WHERE Status = 'Off')

SELECT @varLojasOn AS 'Lojas Abertas', @varLojasOff AS 'Lojas Fechadas'


--PRINT @varLojasOn
--PRINT @varLojasOff
-- PRINT 'O total de lojas abertas é de ' + @varLojasOn
-- PRINT 'O total de lojas fechadas é de ' + @varLojasOff)
-- Obs: Executando a consulta desta forma, será retornado uma mensagem de erro pois estou tentando juntar um TEXTO com um NÚMERO, por isso colocamos o CAST para forçar a variavel ser entendida como VARCHAR

PRINT 'O total de lojas abertas é de ' + CAST(@varLojasOn AS VARCHAR(30))
PRINT 'O total de lojas fechadas é de ' + CAST(@varLojasOff AS VARCHAR(30))

-- E para excluir o texto que aparece na aba Mensagens (X linhas afetadas) precisaremos inserir um comando no inicio da consulta. SET NOCOUNT ON

------------------------------

/*AULA 15 - ARMAZENANDO EM UMA VARIÁVEL UM REGISTRO DE UMA CONSULTA
Variáveis também nos permitem armazenar determinados registros dentro de uma tabela.

Registros são as informações que temos dentro de uma tabela. Por meio de um filtro ou TOP(N) é possível acessar esses registros. E para fechar, conseguimos armazenar esses registros dentro de variáveis.

No exemplo abaixo, armazenamos dentro de duas variáveis o nome e o total vendido. Utilizamos para isso o TOPN(N) e o ORDER BY */

SELECT TOP(100) * FROM FactSales
ORDER BY SalesQuantity DESC

-- Exemplo 1: Qual é o nome do produto que teve a maior quantidade vendida EM UMA ÚNICA VENDA da tabela FactSales?
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

/* AULA 16 - ACUMULANDO VALORES DENTRO DE UMA VARIÁVEL
Variáveis também podem acumular mais de um valor de uma vez.

Exemplo 1: Retorne uma lista com os nomes das funcionárias do departamento de Marketing. */

-- Maneira mais simples
SELECT
	FirstName,
	DepartmentName
FROM
	DimEmployee
WHERE DepartmentName = 'Marketing' AND Gender = 'F'

-- E se eu quisesse printar na aba de Mensagens qual é o nome das funcionárias do departamento de Marketing?
DECLARE @varListaNomes VARCHAR(MAX)
SET @varListaNomes = ''

SELECT
	@varListaNomes = @varListaNomes + FirstName + ', ' + CHAR(10)
FROM
	DimEmployee
WHERE DepartmentName = 'Marketing' AND Gender = 'F'

PRINT LEFT(@varListaNomes, DATALENGTH(@varListaNomes) - 3)

------------------------------

/* AULA 17 - VARIÁVEIS GLOBAIS
O SQL possui algumas variáveis padrões, que podem ser acessadas quando utilizamos o @@, como mostrado abaixo.

Nos códigos abaixo, conseguimos acessar variáveis que retornam informações como: Nome do Servidor, Versão do Sistema ou até mesmo a contagem de linhas de uma tabela.

Para acessar a lista de variáveis globais será incluído depois de SELECT 2 @ '@@'. */

SELECT @@SERVERNAME AS 'Nome do Servidor' -- Descobrir o nome do servidor
SELECT @@VERSION AS 'Versão' -- Descobrir a versão do SSMS


SELECT * FROM DimProduct
SELECT @@ROWCOUNT AS 'Contagem de linhas' -- Contagem de linhas da tabela

------------------------------

-- AULA 18 - Explicação Exercícios
-- AULA 19 - Resolução Exercício 01
-- AULA 20 - Resolução Exercício 02
-- AULA 21 - Resolução Exercício 03
-- AULA 22 - Resolução Exercício 04
-- AULA 23 - Resolução Exercício 05
