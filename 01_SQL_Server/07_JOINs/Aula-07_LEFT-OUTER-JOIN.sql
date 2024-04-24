-- M�DULO 07 - SQL SERVER - JOINs 

/* AULA 07 - LEFT (OUTER) JOIN - Explica��o
O LEFT JOIN permite relacionar duas tabelas e criar uma nova tabela. A tabela resultante desse JOIN ter� todas as linhas exclusivas da tabela A, mais as linhas que s�o a interse��o entre a tabela A e a tabela B. Nenhuma linha presente apenas na tabela B ser� inclu�da na tabela resultante desse JOIN. */

SELECT * FROM DimProduct
SELECT * FROM DimProductSubcategory

SELECT
	DimProduct.ProductKey,
	DimProduct.ProductName,
	DimProduct.ProductSubcategoryKey,
	DimProductSubcategory.ProductSubcategoryName
FROM
	DimProduct
LEFT JOIN DimProductSubcategory
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey