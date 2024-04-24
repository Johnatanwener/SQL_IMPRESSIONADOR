-- M�DULO 05 - SQL SERVER - Fun��es e Agrega��es


-- AULA 06 - Fun��o AVG
-- A fun��o AVG retorna a m�dia dos valores de uma determinada coluna. Tamb�m � poss�vel fazer uma m�dia e especificar um determinado crit�rio.

SELECT * FROM DimCustomer

-- 1. Fa�a uma consulta que retorna a m�dia de YearlyIncome (m�dia de sal�rio) da tabela DimCustomer.
SELECT
	AVG(YearlyIncome) AS 'M�dia Anual de Sal�rio'
FROM DimCustomer

