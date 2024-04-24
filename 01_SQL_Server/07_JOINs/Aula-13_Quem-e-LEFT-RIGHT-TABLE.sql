-- MÓDULO 07 - SQL SERVER - JOINs 

-- AULA 13 - Como definir quem é a LEFT TABLE e quem é a RIGHT TABLE
-- 1. LEFT JOIN para completar informações da tabela produtos (LEFT) de acordo com a tabela de categoria (RIGHT)
SELECT
	DimProduct.ProductKey,
	DimProduct.ProductName,
	DimProduct.ProductSubcategoryKey,
	DimProductSubcategory.ProductSubcategoryName
FROM
	DimProduct
LEFT JOIN DimProductSubcategory
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey

-- 2. Obtendo o LEFT JOIN do caso 1 usando um RIGHT JOIN e invertendo as tabelas de lado
SELECT
	DimProduct.ProductKey,
	DimProduct.ProductName,
	DimProduct.ProductSubcategoryKey,
	DimProductSubcategory.ProductSubcategoryName
FROM
	DimProductSubcategory -- Era DimProduct alterou para DimProductSubcategory
RIGHT JOIN DimProduct -- Era LEFT JOIN DimProductSubcategory e alterou para RIGHT JOIN DimProduct
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey

-- OBS: O mais comum é utilizar a primeira estrutura com o LEFT JOIN pois assim será mais fácil e intuitivo de ler porém, nada impede de usar a segunda estrutura, só tomar o cuidado de se quiser visualizar as informações a partir da tabela B ou direita, utilizar o RIGHT JOIN.