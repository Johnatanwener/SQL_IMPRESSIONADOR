-- M�DULO 07 - SQL SERVER - JOINs 

/* AULA 09 - INNER JOIN - Explica��o
O INNER JOIN permite relacionar duas tabelas e criar uma nova tabela. A tabela resultante desse JOIN ter� apenas as linhas que s�o a interse��o entre a tabela A e a tabela B. */

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