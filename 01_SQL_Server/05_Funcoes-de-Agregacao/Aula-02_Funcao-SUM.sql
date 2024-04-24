-- M�DULO 05 - SQL SERVER - Fun��es e Agrega��es

/* AULA 02 - Fun��o SUM 
A fun��o SUM retorna a soma total de uma determinada coluna.

1. Fa�a uma consulta que retorna a soma total de SalesQuantity e a soma total de ReturnQuantity. */

SELECT TOP (100) * FROM FactSales

SELECT
	SUM(SalesQuantity) AS 'Total Vendido',
	SUM(ReturnQuantity) AS 'Total Devolvido'
FROM
	FactSales