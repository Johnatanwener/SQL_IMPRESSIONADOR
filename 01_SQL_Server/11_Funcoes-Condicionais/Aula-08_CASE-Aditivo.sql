-- M�dulo 11 - SQL SERVER - FUN��ES CONDICIONAIS


/* AULA 08 - CASE Aditivo
Uma outra aplica��o do CASE � em uma situ���o especial, mostrada abaixo. Nessa aplica��o, conseguimos adicionar uma condi��o a uma condi��o anterior.

Por exemplo, no exerc�cio abaixo, queremos aplicar um desconto de 10% aos produtos da categoria 'TV and Video'. E al�m disso, caso tamb�m seja da subcategoria 'Televis�o', queremos aplicar mais 5%, fechando em 15% de desconto.

Criamos um primeiro CASE para verificar a categoria. Logo em seguida, seomamos ao CASE que verifica se a subcategoria � televis�o. */

-- Os produtos da categoria 'TV and Video' ter�o um desconto de 10%
-- Se al�m de ser da categoria 'TV and Video', o produto for da subcategoria 'Televisions', receber� mais 5%. Total, 15%

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