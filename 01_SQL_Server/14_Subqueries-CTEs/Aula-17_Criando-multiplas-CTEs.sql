-- Módulo 14 - SQL SERVER - Subqueries e CTE's


/* AULA 17 - Criando múltiplas CTE's
Podemos criar múltiplas CTEs e em seguida criar uma relação entre elas. Observe a consulta abaixo. Criamos duas CTEs (produtos_contoso e vendas_top1000) e por fim, reaslizamos um JOIN entre essas CTEs.

Exemplo: Crie 2 CTE's:
1. A primeira, cjamada produtos_contoso, deve conter as seguintes colunas (DimProduct): ProductKey, ProductName, BrandName
2. A segunda, chamada vendas_top100, deve ser um top 100 vendas mais recentes, considerando as seguintes colunas da tabela FactSales: SalesKey, ProductKey, DateKey, SalesQuantity

Por fim, faça um INNER JOIN dessas tabelas */

WITH produtos_contoso AS (
	SELECT
		ProductKey,
		ProductName,
		BrandName
	FROM
		DimProduct
	WHERE
		BrandName = 'Contoso'
),
vendas_top100 AS (
SELECT TOP(100)
	SalesKey,
	ProductKey,
	DateKey,
	SalesQuantity
FROM
	FactSales
ORDER BY DateKey DESC
)

SELECT * FROM vendas_top100
INNER JOIN produtos_contoso
	ON vendas_top100.ProductKey = produtos_contoso.ProductKey