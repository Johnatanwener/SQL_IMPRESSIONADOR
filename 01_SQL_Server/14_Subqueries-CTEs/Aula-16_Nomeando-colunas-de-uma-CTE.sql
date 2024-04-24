-- Módulo 14 - SQL SERVER - Subqueries e CTE's


/* AULA 16 - Nomeando colunas de uma CTE
Também seria possível criar uma CTE especificando os nomes das suas colunas. No exemplo abaixo, temos a CTE com colunas chamadas 'Marca' e 'Total'. Posteriormente, podemos fazer um SELECT referenciando o nome delas.

Exemplo: Crie uma CTE que seja o resultado do agrupamento de total de produtos por marca. Faça uma média de produtos por marca. */

WITH cte(Marca, Total) AS (
	SELECT
		BrandName,
		COUNT(*)
	FROM
		DimProduct
	GROUP BY
		BrandName
)

SELECT Marca, Total FROM cte