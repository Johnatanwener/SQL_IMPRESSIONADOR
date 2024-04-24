-- M�dulo 14 - SQL SERVER - Subqueries e CTE's


/* AULA 03, 04 e 05 - Subquery na pr�tica (Aplica��o com o WHERE)
Para entender a ideia por tr�s das subqueries, vamos come�ar fazendo 3 exemplos com a aplica��o WHERE.

Exemplo 1: Quais produtos da tabela DimProduct possuem custos acima da m�dia? */
SELECT AVG(UnitCost) FROM DimProduct     -- 147.6555

SELECT
	*
FROM
	DimProduct
WHERE UnitCost >= (SELECT AVG(UnitCost) FROM DimProduct)

/* Exemplo 2: Fa�a uma consulta para retornar os produtos da categoria 'Televisions'. Tome cuidado pois n�o temos a informa��o de Nome da Subcategoria na tabela DimProduct. Dessa forma, precisaremos criar um SELECT que descubra o ID da categoria 'Televisions' e passar esse resultado como o valor que queremos filtrar dentro do WHERE. */
SELECT * FROM DimProduct
WHERE ProductSubcategoryKey = 
	(SELECT ProductSubcategoryKey FROM DimProductSubcategory
		WHERE ProductSubcategoryName = 'Televisions')


/* Exemplo 3: Filtre a tabela FactSales e mostre apenas as vendas referentes �s lojas com 100 ou mais funcion�rios */
SELECT	StoreKey FROM DimStore WHERE EmployeeCount >= 100
SELECT * FROM FactSales WHERE StoreKey IN (199, 200, 289)
-- Ao inv�s de fazer a consulta igual acima, poderemos automatizar o filtro da seguinte forma:

SELECT * FROM FactSales
WHERE StoreKey IN (
	SELECT	StoreKey
	FROM DimStore
	WHERE EmployeeCount >= 100
)