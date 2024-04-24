-- M�dulo 06 - SQL SERVER - AGRUPAMENTOS NO SQL


/* AULA 04 - GROUP BY mais ORDER BY
Fa�a uma consulta que retorne a soma da quantidade de funcionarios por tipo de loja e filtre por quantidade. */
SELECT * FROM DimStore

SELECT
	StoreType,
	SUM(EmployeeCount) AS 'Qtd. Total Funcion�rios'
FROM
	DimStore
GROUP BY StoreType
ORDER BY SUM(EmployeeCount) DESC
