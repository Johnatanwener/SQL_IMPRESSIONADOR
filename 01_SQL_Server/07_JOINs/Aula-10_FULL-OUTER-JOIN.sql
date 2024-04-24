-- M�DULO 07 - SQL SERVER - JOINs 

/* AULA 10 - FULL (OUTER) JOIN - Explica��o
O FULL JOIN permite relacionar duas tabelas e criar uma nova tabela. A tabela resultante desse JOIN ter� todas as linhas da tabela A e todas as linhas da tabela B. */

SELECT * FROM DimProduct
SELECT * FROM DimProductSubcategory

SELECT
	DimProduct.ProductKey,
	DimProduct.ProductName,
	DimProduct.ProductSubcategoryKey,
	DimProductSubcategory.ProductSubcategoryName
FROM
	DimProduct
FULL JOIN DimProductSubcategory
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey