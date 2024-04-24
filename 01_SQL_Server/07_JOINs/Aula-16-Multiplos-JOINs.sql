-- M�DULO 07 - SQL SERVER - JOINs 

/* AULA 16 - M�LTIPLOS JOINs
Em algumas situa��es precisaremos utilizar m�ltiplos JOINs para conseguir criar nossa tabela com as informa��es que necessitados.

Por exemplo: No banco de dados ContosoRetailDW, temos uma tabela chamada DimProduct, que cont�m as informa��es dos produtos. 
Por�m, essa tabela n�o possui informa��es das categorias desses produtos, apenas as informa��es de IDs das subcategorias.
Portanto, sabemos apenas de forma indireta qual � a categoria do produto. 
De acordo com o ID da subcategoria, conseguimos descobrir qual � o nome da categoria do produto. Para isso, teremos que fazer um JOIN entre a tabela DimProduct com a tabela DimProductSubcategory e depois outro JOIN da tabela DimProductSubcategory com a tabela DimProductCategory. */


SELECT ProductKey, ProductName, ProductSubcategoryKey FROM DimProduct
SELECT ProductSubcategoryKey, ProductSubcategoryName, ProductCategoryKey FROM DimProductSubcategory
SELECT ProductCategoryKey, ProductCategoryName FROM DimProductCategory

SELECT
	ProductKey,
	ProductName,
	DimProduct.ProductSubcategoryKey,
	ProductCategoryName
FROM
	DimProduct
INNER JOIN DimProductSubcategory
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
		INNER JOIN DimProductCategory
			ON DimProductSubcategory.ProductCategoryKey = DimProductCategory.ProductCategoryKey