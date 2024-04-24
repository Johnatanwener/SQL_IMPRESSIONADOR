-- M�DULO 08 - SQL SERVER - GROUP BY + JOINs

/* AULA 01 - GROUP BY mais INNER JOIN
Nos �ltimos dois m�dulos, aprendemos a criar agrupamentos com o GROUP BY e tamb�m a fazer rela��es/jun��es entre tabelas, por meio dos JOINS.
Nesse m�dulo, vamos praticar com alguns casos que combinam os dois conceitos: Criar agrupamentos utilizando o JOIN. */


-- 1. a) Crie um agrupamento mostrando o total de vendas (SalesQuantity) por ano (CalendarYear).
-- 1. b) Considere apenas o m�s (CalendarMonthLabel) de 'January'.
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

-- AULA 02 - Explica��o Exerc�cios
-- AULA 03 - Resolu��o Exerc�cio 01
-- AULA 04 - Resolu��o Exerc�cio 02
-- AULA 05 - Resolu��o Exerc�cio 03
-- AULA 06 - Resolu��o Exerc�cio 04
-- AULA 07 - Resolu��o Exerc�cio 05
-- AULA 08 - Resolu��o Exerc�cio 06
-- AULA 09 - Resolu��o Exerc�cio 07
-- AULA 10 - Resolu��o Exerc�cio 08
-- AULA 11 - Resolu��o Exerc�cio 09
-- AULA 12 - Resolu��o Exerc�cio 10
