-- MÓDULO 05 - SQL SERVER - Funções e Agregações

/* AULA 02 - Função SUM 
A função SUM retorna a soma total de uma determinada coluna.

1. Faça uma consulta que retorna a soma total de SalesQuantity e a soma total de ReturnQuantity. */

SELECT TOP (100) * FROM FactSales

SELECT
	SUM(SalesQuantity) AS 'Total Vendido',
	SUM(ReturnQuantity) AS 'Total Devolvido'
FROM
	FactSales