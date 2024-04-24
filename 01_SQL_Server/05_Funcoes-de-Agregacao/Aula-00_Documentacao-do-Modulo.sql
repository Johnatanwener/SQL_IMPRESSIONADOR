-- M�DULO 05 - SQL SERVER - Fun��es e Agrega��es


/* AULA 01 - Introdu��o ao M�dulo 06
Nesso m�dulo vamos aprender sobre f�rmulas de agrega��o no SQL.

- COUNT
- COUNT + DISTINCT
- SUM
- MIN e MAX
- AVG
*/

------------------------------

/* AULA 02 - Fun��o SUM 
A fun��o SUM() retorna a soma total de uma determinada coluna. � poss�vel fazer uma contagem e especificar um determinado crit�rio.

1. Fa�a uma consulta que retorna a soma total de SalesQuantity e a soma total de ReturnQuantity. */

SELECT TOP (100) * FROM FactSales

SELECT
	SUM(SalesQuantity) AS 'Total Vendido',
	SUM(ReturnQuantity) AS 'Total Devolvido'
FROM
	FactSales

------------------------------

/* AULA 03 - Fun��o COUNT
A fun��o COUNT() retorna a quantidade de linhas de uma coluna. � poss�vel fazer uma contagem e especificar um determinado crit�rio. */

SELECT * FROM DimProduct

-- 1. Fa�a uma consulta que retorna a contagem total de produtos da tabela DimProduct
SELECT
	COUNT(*) AS 'Total de Produtos'
FROM DimProduct


-- 2. Fa�a uma consulta que retorna a contagem total de produtos. Considere a coluna ProductName para este c�lculo
SELECT
	COUNT(ProductName) AS 'Qtd. Produtos'
FROM DimProduct


-- 3. Fa�a uma consulta que retorna a contagem total de produtos. Considere a coluna Size para este c�lculo
SELECT
	COUNT(Size) AS 'Tamanho'
FROM DimProduct
-- Obs: A fun��o COUNT n�o conta valores nulos da coluna, ent�o tome cuidado com o resultado que voc� espera.

------------------------------

/* AULA 04 - Fun��o COUNT mais DISTINCT
A fun��o COUNT combinado com o DISTINCT � utilizado para fazer uma contagem distinta dos valores de uma coluna */

SELECT * FROM DimProduct

-- 1. Fa�a uma consulta que retorna a contagem distinta de cores de produtos.
SELECT
	COUNT(DISTINCT COlorName) AS 'QTD. Cores'
FROM DimProduct


-- 2. Fa�a uma consulta que retorna a contagem distinta das marcas dos produtos
SELECT
	COUNT(DISTINCT BrandName) AS 'QTD. Marcas'
FROM DimProduct

------------------------------

-- AULA 05 - Fun��o MIN e MAX
-- A fun��o MIN() retorna o m�nimo valor de uma determinada coluna.
-- A fun��o MAX() retorna o m�ximo valor de uma determinada coluna.


SELECT * FROM DimProduct

-- 1. Fa�a uma consulta que retorna os valores m�ximo e m�nimo de UnitPrice.
SELECT
	MAX(UnitPrice) AS 'Pre�o M�ximo',
	MIN(UnitPrice) AS 'Pre�o M�nimo'
FROM DimProduct


-- 2. Fa�a uma consulta que retorna os valores m�ximo e m�nimo de UnitCost.
SELECT
	MAX(UnitCost) AS 'Custo M�ximo',
	MIN(UnitCost) AS 'Custo M�nimo'
FROM DimProduct

------------------------------

-- AULA 06 - Fun��o AVG
-- A fun��o AVG retorna a m�dia dos valores de uma determinada coluna. Tamb�m � poss�vel fazer uma m�dia e especificar um determinado crit�rio.

SELECT * FROM DimCustomer

-- 1. Fa�a uma consulta que retorna a m�dia de YearlyIncome (m�dia de sal�rio) da tabela DimCustomer.
SELECT
	AVG(YearlyIncome) AS 'M�dia Anual de Sal�rio'
FROM DimCustomer


-- AULA 07 - Explica��o Exerc�cios
-- AULA 08 -  Resolu��o Exerc�cio 01
-- AULA 09 -  Resolu��o Exerc�cio 02
-- AULA 10 -  Resolu��o Exerc�cio 03
-- AULA 11 -  Resolu��o Exerc�cio 04
-- AULA 12 -  Resolu��o Exerc�cio 05