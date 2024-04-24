-- MÓDULO 05 - SQL SERVER - Funções e Agregações


/* AULA 01 - Introdução ao Módulo 06
Nesso módulo vamos aprender sobre fórmulas de agregação no SQL.

- COUNT
- COUNT + DISTINCT
- SUM
- MIN e MAX
- AVG
*/

------------------------------

/* AULA 02 - Função SUM 
A função SUM() retorna a soma total de uma determinada coluna. É possível fazer uma contagem e especificar um determinado critério.

1. Faça uma consulta que retorna a soma total de SalesQuantity e a soma total de ReturnQuantity. */

SELECT TOP (100) * FROM FactSales

SELECT
	SUM(SalesQuantity) AS 'Total Vendido',
	SUM(ReturnQuantity) AS 'Total Devolvido'
FROM
	FactSales

------------------------------

/* AULA 03 - Função COUNT
A função COUNT() retorna a quantidade de linhas de uma coluna. É possível fazer uma contagem e especificar um determinado critério. */

SELECT * FROM DimProduct

-- 1. Faça uma consulta que retorna a contagem total de produtos da tabela DimProduct
SELECT
	COUNT(*) AS 'Total de Produtos'
FROM DimProduct


-- 2. Faça uma consulta que retorna a contagem total de produtos. Considere a coluna ProductName para este cálculo
SELECT
	COUNT(ProductName) AS 'Qtd. Produtos'
FROM DimProduct


-- 3. Faça uma consulta que retorna a contagem total de produtos. Considere a coluna Size para este cálculo
SELECT
	COUNT(Size) AS 'Tamanho'
FROM DimProduct
-- Obs: A função COUNT não conta valores nulos da coluna, então tome cuidado com o resultado que você espera.

------------------------------

/* AULA 04 - Função COUNT mais DISTINCT
A função COUNT combinado com o DISTINCT é utilizado para fazer uma contagem distinta dos valores de uma coluna */

SELECT * FROM DimProduct

-- 1. Faça uma consulta que retorna a contagem distinta de cores de produtos.
SELECT
	COUNT(DISTINCT COlorName) AS 'QTD. Cores'
FROM DimProduct


-- 2. Faça uma consulta que retorna a contagem distinta das marcas dos produtos
SELECT
	COUNT(DISTINCT BrandName) AS 'QTD. Marcas'
FROM DimProduct

------------------------------

-- AULA 05 - Função MIN e MAX
-- A função MIN() retorna o mínimo valor de uma determinada coluna.
-- A função MAX() retorna o máximo valor de uma determinada coluna.


SELECT * FROM DimProduct

-- 1. Faça uma consulta que retorna os valores máximo e mínimo de UnitPrice.
SELECT
	MAX(UnitPrice) AS 'Preço Máximo',
	MIN(UnitPrice) AS 'Preço Mínimo'
FROM DimProduct


-- 2. Faça uma consulta que retorna os valores máximo e mínimo de UnitCost.
SELECT
	MAX(UnitCost) AS 'Custo Máximo',
	MIN(UnitCost) AS 'Custo Mínimo'
FROM DimProduct

------------------------------

-- AULA 06 - Função AVG
-- A função AVG retorna a média dos valores de uma determinada coluna. Também é possível fazer uma média e especificar um determinado critério.

SELECT * FROM DimCustomer

-- 1. Faça uma consulta que retorna a média de YearlyIncome (média de salário) da tabela DimCustomer.
SELECT
	AVG(YearlyIncome) AS 'Média Anual de Salário'
FROM DimCustomer


-- AULA 07 - Explicação Exercícios
-- AULA 08 -  Resolução Exercício 01
-- AULA 09 -  Resolução Exercício 02
-- AULA 10 -  Resolução Exercício 03
-- AULA 11 -  Resolução Exercício 04
-- AULA 12 -  Resolução Exercício 05