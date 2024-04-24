-- M�DULO 07 - SQL SERVER - JOINs 

/* AULA 11 - LEFT, RIGHT e FULL ANTI JOIN - Explica��o
O LEFT ANTI JOIN permite relacionar duas tabelas e criar uma nova tabela.
A tabela resultande desse JOIN ter� apenas as linhas que s� existem na tabela A */

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
-- WHERE nome_subcategoria IS NULL


/* O RIGHT ANTI JOIN permite relacionar duas tabelas e criar uma nova tabela.
A tabela resultande desse JOIN ter� apenas as linhas que s� existem na tabela B */

SELECT * FROM DimProduct
SELECT * FROM DimProductSubcategory

SELECT
	DimProduct.ProductKey,
	DimProduct.ProductName,
	DimProduct.ProductSubcategoryKey,
	DimProductSubcategory.ProductSubcategoryName
FROM
	DimProduct
RIGHT JOIN DimProductSubcategory
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
-- WHERE id_pruduto IS NULL


/* O FULL ANTI JOIN permite relacionar duas tabelas e criar uma nova tabela.
A tabela resultande desse JOIN ter� apenas as linhas que s� existem na tabela A ou na tabela B. */

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
-- WHERE id_produto IS NULL OR nome_subtagoria IS NULL