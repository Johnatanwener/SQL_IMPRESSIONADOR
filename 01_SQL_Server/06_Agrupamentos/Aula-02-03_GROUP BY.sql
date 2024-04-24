-- M�dulo 06 - SQL SERVER - AGRUPAMENTOS NO SQL


/* AULA 02-03 - Group BY
O comando GROUP BY permite agrupar valores de acordo com uma coluna, por exemplo, 'total de funcion�rios de acordo com o depertamento'.
O GROUP BY � usado junto com fun��es de agrega��o COUNT(), MAX(), MIM(), SUM() e AVG() para agrupar valores de acordo com uma ou mais colunas.

Fa�a uma consulta que retorne a quantidade total de produtos e agrupe por marcas; */
SELECT * FROM DimProduct

SELECT
	BrandName AS 'Nome da Marca',
	COUNT(*) AS 'QTD. Total'
FROM
	DimProduct
GROUP BY BrandName


-- Consulta 1: Fa�a uma consulta que retorne a quantidade total de funcion�rios e agrupe por tipo de loja.
SELECT * FROM DimStore

SELECT
	StoreType,
	SUM(EmployeeCount) AS 'Qtd. Total Funcion�rios'
FROM
	DimStore
GROUP BY StoreType


-- Consulta 2: Fa�a uma consulta que retorne o custo m�dio dos produtos e agrupe por Marca
SELECT * FROM DimProduct

SELECT
	BrandName,
	AVG(UnitCost) AS 'Custo M�dio'
FROM
	DimProduct
GROUP BY BrandName


-- Consulta 3: Fa�a uma consulta que retorne o pre�o m�ximo de um produto e agrupe por Classe
SELECT * FROM DimProduct

SELECT
	ClassName AS 'Classe do Produto',
	MAX(UnitPrice) AS 'M�ximo Pre�o'
FROM
	DimProduct
GROUP BY ClassName