-- Módulo 14 - SQL SERVER - Subqueries e CTE's


/* AULA 15 - Calculando agregações com CTE
Podemos armazenar consultas mais complexas dentro de uma CTE. No exemplo abaixo, criamos uma CTE que é o agrupamento da tabela dimProduct, contendo o total de produtos por marca. Por fim, podemos descobrir a média de produtos por marca, aplicando o AVG na coluna Total da nossa CTE.


-- Exemplo: Crie uma CTE que seja o resultado do agrupamento de total de produtos por marca. Faça uma média de produtos por marca. */

WITH cte AS (
	SELECT
		BrandName,
		COUNT(*) AS 'Total'
	FROM
		DimProduct
	GROUP BY
		BrandName
)

--SELECT * FROM cte
SELECT AVG(Total) FROM cte

