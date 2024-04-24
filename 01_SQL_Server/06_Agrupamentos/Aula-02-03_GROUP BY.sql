-- Módulo 06 - SQL SERVER - AGRUPAMENTOS NO SQL


/* AULA 02-03 - Group BY
O comando GROUP BY permite agrupar valores de acordo com uma coluna, por exemplo, 'total de funcionários de acordo com o depertamento'.
O GROUP BY é usado junto com funções de agregação COUNT(), MAX(), MIM(), SUM() e AVG() para agrupar valores de acordo com uma ou mais colunas.

Faça uma consulta que retorne a quantidade total de produtos e agrupe por marcas; */
SELECT * FROM DimProduct

SELECT
	BrandName AS 'Nome da Marca',
	COUNT(*) AS 'QTD. Total'
FROM
	DimProduct
GROUP BY BrandName


-- Consulta 1: Faça uma consulta que retorne a quantidade total de funcionários e agrupe por tipo de loja.
SELECT * FROM DimStore

SELECT
	StoreType,
	SUM(EmployeeCount) AS 'Qtd. Total Funcionários'
FROM
	DimStore
GROUP BY StoreType


-- Consulta 2: Faça uma consulta que retorne o custo médio dos produtos e agrupe por Marca
SELECT * FROM DimProduct

SELECT
	BrandName,
	AVG(UnitCost) AS 'Custo Médio'
FROM
	DimProduct
GROUP BY BrandName


-- Consulta 3: Faça uma consulta que retorne o preço máximo de um produto e agrupe por Classe
SELECT * FROM DimProduct

SELECT
	ClassName AS 'Classe do Produto',
	MAX(UnitPrice) AS 'Máximo Preço'
FROM
	DimProduct
GROUP BY ClassName