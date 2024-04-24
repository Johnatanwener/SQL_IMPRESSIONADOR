-- MÓDULO 07 - SQL SERVER - JOINs 


/* Os Joins têm como principal objetivo deixar as tabelas mais informativas, permitindo buscar dados de uma tabela para outra, de acordo com uma coluna em comum que permita essa relação. Dito isso, faça os seguintes exercícios: 


EXERCICIO 1.
Utilize o INNER JOIN para trazer os nomes das subcategorias dos produtos, da tabela DimProductSubcategory para a tabela DimProduct. */
SELECT * FROM DimProduct
SELECT * FROM DimProductSubcategory

SELECT
	DimProduct.ProductKey,
	DimProduct.ProductName,
	DimProductSubcategory.ProductSubcategoryName
FROM
	DimProduct
INNER JOIN DimProductSubcategory
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey

------------------------------

/* EXERCICIO 2.
Identifique uma coluna em comum entre as tabelas DimProductSubcategory e 
DimProductCategory. Utilize essa coluna para complementar informações na tabela 
DimProductSubcategory a partir da DimProductCategory. Utilize o LEFT JOIN. */

SELECT * FROM DimProductSubcategory
SELECT * FROM DimProductCategory

SELECT
	ProductSubcategoryKey AS 'ID Subcategoria',
	ProductSubcategoryName AS 'Subcategoria',
	ProductCategoryName AS 'Categoria'
FROM
	DimProductSubcategory
LEFT JOIN DimProductCategory
	ON DimProductSubcategory.ProductCategoryKey = DimProductCategory.ProductCategoryKey

------------------------------

/* EXERCICIO 3
Para cada loja da tabela DimStore, descubra qual o Continente e o Nome do País associados 
(de acordo com DimGeography). Seu SELECT final deve conter apenas as seguintes colunas: 
StoreKey, StoreName, EmployeeCount, ContinentName e RegionCountryName. Utilize o LEFT 
JOIN neste exercício. */

SELECT * FROM DimStore
SELECT * FROM DimGeography

SELECT
	StoreKey AS 'ID Loja',
	StoreName AS 'Nome Loja',
	EmployeeCount AS 'QTD. Funcionários',
	ContinentName AS 'Continente',
	RegionCountryName AS 'País'
FROM
	DimStore
LEFT JOIN DimGeography
	ON DimStore.GeographyKey = DimGeography.GeographyKey

------------------------------

/* EXERCICIO 4
Complementa a tabela DimProduct com a informação de ProductCategoryDescription. Utilize 
o LEFT JOIN e retorne em seu SELECT apenas as 5 colunas que considerar mais relevantes. */

SELECT * FROM DimProduct
SELECT * FROM DimProductSubcategory
SELECT * FROM DimProductCategory


SELECT
	ProductKey AS 'ID Produto',
	ProductName AS 'Nome',
	ProductCategoryDescription AS 'Categoria',
	ProductSubcategoryDescription AS 'Subcategoria',
	BrandName AS 'Marca'
FROM
	DimProduct
LEFT JOIN DimProductSubcategory
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
		LEFT JOIN DimProductCategory
			ON DimProductSubcategory.ProductCategoryKey = DimProductCategory.ProductCategoryKey

------------------------------

/* EXERCICIO 5.
A tabela FactStrategyPlan resume o planejamento estratégico da empresa. Cada linha 
representa um montante destinado a uma determinada AccountKey. 

a) Faça um SELECT das 100 primeiras linhas de FactStrategyPlan para reconhecer a tabela. 
b) Faça um INNER JOIN para criar uma tabela contendo o AccountName para cada 
AccountKey da tabela FactStrategyPlan. O seu SELECT final deve conter as colunas: 
• StrategyPlanKey 
• DateKey 
• AccountName 
• Amount */

SELECT TOP (100) * FROM FactStrategyPlan
SELECT * FROM DimAccount

SELECT
	StrategyPlanKey AS 'ID Planejamento',
	Datekey AS 'Data',
	AccountName AS 'Nome da Conta',
	Amount AS 'Quantia'
FROM
	FactStrategyPlan
INNER JOIN DimAccount
	ON FactStrategyPlan.AccountKey = DimAccount.AccountKey

------------------------------

/* EXERCICIO 6.
Vamos continuar analisando a tabela FactStrategyPlan. Além da coluna AccountKey que 
identifica o tipo de conta, há também uma outra coluna chamada ScenarioKey. Essa coluna 
possui a numeração que identifica o tipo de cenário: Real, Orçado e Previsão. 
Faça um INNER JOIN para criar uma tabela contendo o ScenarioName para cada ScenarioKey 
da tabela FactStrategyPlan. O seu SELECT final deve conter as colunas: 
• StrategyPlanKey 
• DateKey 
• ScenarioName  
• Amount */

SELECT TOP(100) * FROM FactStrategyPlan
SELECT * FROM DimScenario

SELECT
	StrategyPlanKey,
	Datekey,
	ScenarioName,
	Amount
FROM
	FactStrategyPlan
	INNER JOIN DimScenario
		ON FactStrategyPlan.ScenarioKey = DimScenario.ScenarioKey

------------------------------

/* EXERCICIO 7.
Algumas subcategorias não possuem nenhum exemplar de produto. Identifique que 
subcategorias são essas. */

SELECT * FROM DimProduct				-- Tabela ESQUERDA
SELECT * FROM DimProductSubcategory		-- Tabela DIREITA

SELECT
	ProductKey,
	ProductName,
	ProductSubcategoryName
FROM
	DimProduct
	RIGHT JOIN DimProductSubcategory
		ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
		WHERE ProductName IS NULL

------------------------------

/* EXERCICIO 8.
A tabela abaixo mostra a combinação entre Marca e Canal de Venda, para as marcas Contoso, 
Fabrikam e Litware. Crie um código SQL para chegar no mesmo resultado. */

SELECT * FROM DimProduct
SELECT * FROM DimChannel
SELECT TOP(100) * FROM FactSalesQuota

SELECT
	DISTINCT BrandName,
	ChannelName
FROM
	DimProduct CROSS JOIN DimChannel
WHERE BrandName IN ('Contoso', 'Fabrikam', 'Litware')

------------------------------

/* EXERCICIO 9.
Neste exercício, você deverá relacionar as tabelas FactOnlineSales com DimPromotion. 
Identifique a coluna que as duas tabelas têm em comum e utilize-a para criar esse 
relacionamento. 

Retorne uma tabela contendo as seguintes colunas: 
• OnlineSalesKey 
• DateKey 
• PromotionName 
• SalesAmount 
A sua consulta deve considerar apenas as linhas de vendas referentes a produtos com 
desconto (PromotionName <> ‘No Discount’). Além disso, você deverá ordenar essa tabela de 
acordo com a coluna DateKey, em ordem crescente.  */

SELECT TOP (100) * FROM FactOnlineSales
SELECT * FROM DimPromotion

SELECT TOP (1000) 
	OnlineSalesKey,
	DateKey,
	PromotionName,
	SalesAmount
FROM
	FactOnlineSales
	INNER JOIN DimPromotion
		ON FactOnlineSales.PromotionKey = DimPromotion.PromotionKey
WHERE PromotionName <> 'No Discount'
ORDER BY DateKey ASC

------------------------------

/* EXERCICIO 10.
A tabela abaixo é resultado de um Join entre a tabela FactSales e as tabelas: DimChannel, 
DimStore e DimProduct. 
Recrie esta consulta e classifique em ordem crescente de acordo com SalesAmount. */

SELECT TOP (100) * FROM FactSales
SELECT * FROM DimChannel
SELECT * FROM DimStore
SELECT * FROM DimProduct

SELECT TOP (100)
	SalesKey,
	ChannelName,
	StoreName,
	ProductName,
	SalesAmount
FROM
	FactSales
	INNER JOIN DimChannel
		ON FactSales.channelKey = DimChannel.ChannelKey
	INNER JOIN DimStore
		ON FactSales.StoreKey = DimStore.StoreKey
	INNER JOIN DimProduct
		ON FactSales.ProductKey = DimProduct.ProductKey
ORDER BY SalesAmount DESC