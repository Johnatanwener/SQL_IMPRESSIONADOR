-- Módulo 14 - SQL SERVER - Subqueries e CTE's


/* AULA 03, 04 e 05 - Subquery na prática (Aplicação com o WHERE)
Para entender a ideia por trás das subqueries, vamos começar fazendo 3 exemplos com a aplicação WHERE.

Exemplo 1: Quais produtos da tabela DimProduct possuem custos acima da média? */
SELECT AVG(UnitCost) FROM DimProduct     -- 147.6555

SELECT
	*
FROM
	DimProduct
WHERE UnitCost >= (SELECT AVG(UnitCost) FROM DimProduct)

/* Exemplo 2: Faça uma consulta para retornar os produtos da categoria 'Televisions'. Tome cuidado pois não temos a informação de Nome da Subcategoria na tabela DimProduct. Dessa forma, precisaremos criar um SELECT que descubra o ID da categoria 'Televisions' e passar esse resultado como o valor que queremos filtrar dentro do WHERE. */
SELECT * FROM DimProduct
WHERE ProductSubcategoryKey = 
	(SELECT ProductSubcategoryKey FROM DimProductSubcategory
		WHERE ProductSubcategoryName = 'Televisions')


/* Exemplo 3: Filtre a tabela FactSales e mostre apenas as vendas referentes às lojas com 100 ou mais funcionários */
SELECT	StoreKey FROM DimStore WHERE EmployeeCount >= 100
SELECT * FROM FactSales WHERE StoreKey IN (199, 200, 289)
-- Ao invés de fazer a consulta igual acima, poderemos automatizar o filtro da seguinte forma:

SELECT * FROM FactSales
WHERE StoreKey IN (
	SELECT	StoreKey
	FROM DimStore
	WHERE EmployeeCount >= 100
)