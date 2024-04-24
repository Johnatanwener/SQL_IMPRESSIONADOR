-- Módulo 11 - SQL SERVER - FUNÇÕES CONDICIONAIS


/* AULA 08 - CASE Aditivo
Uma outra aplicação do CASE é em uma situãção especial, mostrada abaixo. Nessa aplicação, conseguimos adicionar uma condição a uma condição anterior.

Por exemplo, no exercício abaixo, queremos aplicar um desconto de 10% aos produtos da categoria 'TV and Video'. E além disso, caso também seja da subcategoria 'Televisão', queremos aplicar mais 5%, fechando em 15% de desconto.

Criamos um primeiro CASE para verificar a categoria. Logo em seguida, seomamos ao CASE que verifica se a subcategoria é televisão. */

-- Os produtos da categoria 'TV and Video' terão um desconto de 10%
-- Se além de ser da categoria 'TV and Video', o produto for da subcategoria 'Televisions', receberá mais 5%. Total, 15%

SELECT
	ProductKey,
	ProductName,
	ProductCategoryName,
	ProductSubcategoryName,	
	UnitPrice,
	CASE WHEN ProductCategoryName = 'TV and Video' 
		THEN 0.10 ELSE 0.00 END
	+ CASE WHEN ProductSubCategoryName = 'Televisions' 
		THEN 0.05 ELSE 0.00 END
FROM DimProduct
INNER JOIN DimProductSubcategory
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
		INNER JOIN DimProductCategory
			ON DimProductSubcategory.ProductCategoryKey = DimProductCategory.ProductCategoryKey