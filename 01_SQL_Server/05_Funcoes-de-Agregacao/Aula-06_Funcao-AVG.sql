-- MÓDULO 05 - SQL SERVER - Funções e Agregações


-- AULA 06 - Função AVG
-- A função AVG retorna a média dos valores de uma determinada coluna. Também é possível fazer uma média e especificar um determinado critério.

SELECT * FROM DimCustomer

-- 1. Faça uma consulta que retorna a média de YearlyIncome (média de salário) da tabela DimCustomer.
SELECT
	AVG(YearlyIncome) AS 'Média Anual de Salário'
FROM DimCustomer

