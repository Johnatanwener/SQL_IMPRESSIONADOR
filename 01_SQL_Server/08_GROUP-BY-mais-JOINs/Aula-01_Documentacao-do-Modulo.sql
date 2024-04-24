-- MÓDULO 08 - SQL SERVER - GROUP BY + JOINs

/* AULA 01 - GROUP BY mais INNER JOIN
Nos últimos dois módulos, aprendemos a criar agrupamentos com o GROUP BY e também a fazer relações/junções entre tabelas, por meio dos JOINS.
Nesse módulo, vamos praticar com alguns casos que combinam os dois conceitos: Criar agrupamentos utilizando o JOIN. */


-- 1. a) Crie um agrupamento mostrando o total de vendas (SalesQuantity) por ano (CalendarYear).
-- 1. b) Considere apenas o mês (CalendarMonthLabel) de 'January'.
-- 1. c) Na tabela resultante, mostre apenas os anos com um total de vendas maior ou igual a de 1200000

SELECT TOP (100) * FROM FactSales
SELECT * FROM DimDate

SELECT
	CalendarYear AS 'Ano',
	SUM(SalesQuantity) AS 'Total Vendido'
FROM
	FactSales
INNER JOIN DimDate
	ON FactSales.DateKey = DimDate.Datekey
WHERE CalendarMonthLabel = 'January'
GROUp BY CalendarYear
HAVING SUM(SalesQuantity) >= 1200000

------------------------------

-- AULA 02 - Explicação Exercícios
-- AULA 03 - Resolução Exercício 01
-- AULA 04 - Resolução Exercício 02
-- AULA 05 - Resolução Exercício 03
-- AULA 06 - Resolução Exercício 04
-- AULA 07 - Resolução Exercício 05
-- AULA 08 - Resolução Exercício 06
-- AULA 09 - Resolução Exercício 07
-- AULA 10 - Resolução Exercício 08
-- AULA 11 - Resolução Exercício 09
-- AULA 12 - Resolução Exercício 10
