-- MÓDULO 07 - SQL SERVER - JOINs 

/* AULA 09 - INNER JOIN - Explicação
O INNER JOIN permite relacionar duas tabelas e criar uma nova tabela. A tabela resultante desse JOIN terá apenas as linhas que são a interseção entre a tabela A e a tabela B. */

SELECT * FROM DimProduct
SELECT * FROM DimProductSubcategory

SELECT
	DimProduct.ProductKey,
	DimProduct.ProductName,
	DimProduct.ProductSubcategoryKey,
	DimProductSubcategory.ProductSubcategoryName
FROM
	DimProduct
INNER JOIN DimProductSubcategory
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey