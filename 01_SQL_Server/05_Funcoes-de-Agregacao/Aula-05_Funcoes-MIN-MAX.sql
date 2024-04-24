-- MÓDULO 05 - SQL SERVER - Funções e Agregações


-- AULA 05 - Função MIN e MAX
-- A função MIN() retorna o mínimo valor de uma determinada coluna.
-- A função MAX() retorna o máximo valor de uma determinada coluna.


SELECT * FROM DimProduct

-- 1. Faça uma consulta que retorna os valores máximo e mínimo de UnitPrice.
SELECT
	MAX(UnitPrice) AS 'Preço Máximo',
	MIN(UnitPrice) AS 'Preço Mínimo'
FROM DimProduct


-- 2. Faça uma consulta que retorna os valores máximo e mínimo de UnitCost.
SELECT
	MAX(UnitCost) AS 'Custo Máximo',
	MIN(UnitCost) AS 'Custo Mínimo'
FROM DimProduct


