-- M�DULO 08 - SQL SERVER - GROUP BY + JOINs

-- Os exerc�cios abaixo est�o divididos de acordo com uma determinada tabela do Bando de Dados. Voc� pode utilizar o INNER JOIN para resolver todas as quest�es. 

-- FACTSALES
/* EXERCICIO 1.
a) Fa�a um resumo da quantidade vendida (SalesQuantity) de acordo com o nome do canal de venda (ChannelName). Voce deve ordernar a tabela final de acordo com SalesQuantity, em ordem decrescente. */
SELECT TOP (100) * FROM FactSales
SELECT * FROM DimChannel

SELECT
	ChannelName AS 'Canal de Venda',
	SUM(SalesQuantity) AS 'Total Vendido'
FROM	
	FactSales
	INNER JOIN DimChannel
		ON FactSales.channelKey = DimChannel.ChannelKey
GROUP BY ChannelName
ORDER BY SUM(SalesQUantity) DESC

-- b) Fa�a um agrupamento mostrando a quantidade total vendida (SalesQuantity) e a quantidade devolvida (Return Quantity) de acordo com o nome das lojas (StoreName).
SELECT TOP (100) * FROM FactSales
SELECT * FROM DimStore

SELECT
	StoreName,
	SUM(SalesQuantity),
	SUM(ReturnQuantity)
FROM
	FactSales
	INNER JOIN DimStore
		ON FactSales.StoreKey = DimStore.StoreKey
GROUP BY StoreName

-- c) Fa�a um resumo do valor total vendido (SalesAmount) pra cada m�s (CalendarMonthLabel) e ano (CalendarYear).
SELECT TOP(100) * FROM FactSales
SELECT * FROM DimDate

SELECT
	CalendarMonthLabel,
	CalendarYear,
	SUM(SalesAmount)
FROM
	FactSales
	INNER JOIN DimDate
		ON FactSales.DateKey = DimDate.Datekey
GROUP BY CalendarMonthLabel, CalendarYear, CalendarMonth
ORDER BY CalendarMonth ASC

------------------------------

/* EXERCICIO 2.
Voc� precisa fazer uma an�lise de vendas por produtos. O objetivo final � descobrir o valor total vendido (SalesAmount) por produto. */
SELECT TOP (100) * FROM FactSales
SELECT * FROM DimProduct

SELECT
	ProductName AS 'Produto',
	SUM(SalesAmount) AS 'Total Vendido'
FROM
	FactSales
	INNER JOIN DimProduct
		ON FactSales.ProductKey = DimProduct.ProductKey
GROUP BY ProductName

-- a) Descubra qual � a cor de produto que mais � vendida de acordo com SalesQuantity.
-- b) Quantas cores tiveram uma quantidade vendida acima de 3.000.000
SELECT
	ColorName AS 'Cor',
	SUM(SalesQuantity) AS 'QTD. Vendida'
FROM
	FactSales
	INNER JOIN DimProduct
		ON FactSales.ProductKey = DimProduct.ProductKey
GROUP BY ColorName
HAVING SUM(SalesQuantity) >= 3000000
ORDER BY SUM(SalesQuantity) DESC

------------------------------

/* EXERCICIO 3.
Observe a imagem abaixo: se trata de um agrupamento de quantidade vendida (SalesQuantity) agrupada por ProductCategoryName. Crie o mesmo agrupamento do zero. OBS: Voc� precisar� fazer mais do que 1 INNER JOIN, dado que a rela��o entre FactSales e DimProductCategory n�o � direta. */

SELECT TOP (100) * FROM FactSales
SELECT * FROM DimProduct
SELECT * FROM DimProductSubcategory
SELECT * FROM DimProductCategory

SELECT
	ProductCategoryName AS 'Categoria',
	SUM(SalesQuantity) AS 'QTD. Vendida'
FROM
	FactSales
	INNER JOIN DimProduct
		ON FactSales.ProductKey = DimProduct.ProductKey
		INNER JOIN DimProductSubcategory
			ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
				INNER JOIN DimProductCategory
					ON DimProductSubcategory.ProductCategoryKey = DimProductCategory.ProductCategoryKey
GROUP BY ProductCategoryName

------------------------------

-- FACTSALES
/* EXERCICIO 4.
a) Voc� deve fazer uma consulta � tabela FactOnlineSales e descobrir qual � o nome completo do cliente que mais realizou compras online de acordo com a coluna SalesQuantity. */

SELECT TOP (100) * FROM FactOnlineSales
SELECT * FROM DimCustomer


SELECT
	DimCustomer.CustomerKey AS 'ID Cliente',
	FirstName AS 'Nome',
	LastName AS 'Sobrenome',
	SUM(SalesQuantity) AS 'QTD. Vendida'
FROM
	FactOnlineSales
	INNER JOIN DimCustomer
		ON FactOnlineSales.CustomerKey = DimCustomer.CustomerKey
WHERE CustomerType = 'Person'
GROUP BY DimCustomer.CustomerKey, FirstName, LastName
ORDER BY SUM(SalesQuantity) DESC

-- b) Feito isso, fa�a um agrupamento de produtos e descubra quais foram os top 10 produtos mais comprados pelo cliente da letra a), considerando o nome do produto.
SELECT TOP (100) * FROM FactOnlineSales
SELECT * FROM DimProduct


SELECT TOP (10)
	ProductName AS 'Produto',
	SUM(SalesQuantity) AS 'QTD. Vendida'
FROM
	FactOnlineSales
	INNER JOIN DimProduct
		ON FactOnlineSales.ProductKey = DimProduct.ProductKey
WHERE CustomerKey = '7665'
GROUP BY ProductName
ORDER BY SUM(SalesQuantity) DESC

------------------------------

/* EXERCICIO 5.
Fa�a um resumo mostrando o total de produtos comprados (SalesQuantity) de acordo com o sexo dos clientes. */

SELECT TOP (100) * FROM FactOnlineSales
SELECT * FROM DimCustomer

SELECT
	Gender AS 'Sexo',
	SUM(SalesQuantity) AS 'QTD. Vendida'
FROM
	FactOnlineSales
	INNER JOIN DimCustomer
		ON FactOnlineSales.CustomerKey = DimCustomer.CustomerKey
WHERE CustomerType = 'Person'
GROUP BY Gender

------------------------------

-- FACTEXCHANGERATE
/* EXERCICIO 6.
Fa�a uma tabela resumo mostrando a taxa de cambio m�dia de acordo com cada CurrencyDescription. A tabela final deve conter apenas taxas entre 10 e 100. */
SELECT TOP (100) * FROM FactExchangeRate
SELECT * FROM DimCurrency

SELECT
	CurrencyDescription AS 'Moeda',
	AVG(AverageRate) AS 'Taxa m�dia'
FROM
	FactExchangeRate
	INNER JOIN DimCurrency
		ON FactExchangeRate.CurrencyKey = DimCurrency.CurrencyKey
GROUP BY CurrencyDescription
HAVING AVG(AverageRate) BETWEEN 10 AND 100

------------------------------

-- FACTSTRATEGYPLAN
/* EXERCICIO 7.
Descubra o valor total na tabela factStrategyPlan destinado para os cen�rios: Actual e Budget. */
SELECT TOP (100) * FROM FactStrategyPlan
SELECT * FROM DimScenario

SELECT
	ScenarioName AS 'Cen�rio',
	SUM(Amount) AS 'valor Total'
FROM
	FactStrategyPlan
	INNER JOIN DimScenario
		ON FactStrategyPlan.ScenarioKey = DimScenario.ScenarioKey
WHERE ScenarioName IN ('Actual', 'Budget')
-- ou WHERE ScenarioName <> 'Forecast'
GROUP BY ScenarioName
-- ou HAVING ScenarioName <> 'Forecast'
-- ou HAVING ScenarioName IN ('Actual', 'Budget')

------------------------------

/* EXERC�CIO 8.
Fa�a uma tabela resumo mostrando o resultado do planejamento estrat�gico agrupado por ano. */

SELECT TOP (100) * FROM FactStrategyPlan
SELECT * FROM DimDate

SELECT
	CalendarYear AS 'Ano',
	SUM(Amount) AS 'Valor Total'
FROM
	FactStrategyPlan
	INNER JOIN DimDate
		ON FactStrategyPlan.Datekey = DimDate.Datekey
GROUP BY CalendarYear

------------------------------

-- DIMPRODUCT/DIMPRODUCTSUBCATEGORY
/* EXERCICIO 9.
Fa�a um agrupamento de quantidade de produtos por ProductSubcategoryName. Leve em considera��o em sua an�lise apenas a marca Contoso e a cor Silver. */
SELECT * FROM DimProduct
SELECT * FROM DimProductSubcategory

SELECT
	ProductSubcategoryName AS 'Subcategoria',
	COUNT(*) AS 'QTD. Produtos'
FROM
	DimProduct
	INNER JOIN DimProductSubcategory
		ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
WHERE BrandName = 'Contoso' AND ColorName = 'Silver'
GROUP BY ProductSubcategoryName

------------------------------

/* EXERCICIO 10.
Fa�a um agrupamento duplo de quantidade de produtos por BrandName e ProductSubcategoryName. A tabela final dever� ser ordenada de acordo com a coluna BrandName. */
SELECT * FROM DimProduct
SELECT * FROM DimProductSubcategory

SELECT
	BrandName AS 'Marca',
	ProductSubcategoryName AS 'Subcategoria',
	COUNT(*) AS 'QTD. Produtos'
FROM
	DimProduct
	INNER JOIN DimProductSubcategory
		ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
GROUP BY BrandName, ProductSubcategoryName
ORDER BY BrandName ASC
