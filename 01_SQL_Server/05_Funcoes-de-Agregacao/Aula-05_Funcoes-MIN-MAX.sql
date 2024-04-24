-- M�DULO 05 - SQL SERVER - Fun��es e Agrega��es


-- AULA 05 - Fun��o MIN e MAX
-- A fun��o MIN() retorna o m�nimo valor de uma determinada coluna.
-- A fun��o MAX() retorna o m�ximo valor de uma determinada coluna.


SELECT * FROM DimProduct

-- 1. Fa�a uma consulta que retorna os valores m�ximo e m�nimo de UnitPrice.
SELECT
	MAX(UnitPrice) AS 'Pre�o M�ximo',
	MIN(UnitPrice) AS 'Pre�o M�nimo'
FROM DimProduct


-- 2. Fa�a uma consulta que retorna os valores m�ximo e m�nimo de UnitCost.
SELECT
	MAX(UnitCost) AS 'Custo M�ximo',
	MIN(UnitCost) AS 'Custo M�nimo'
FROM DimProduct


