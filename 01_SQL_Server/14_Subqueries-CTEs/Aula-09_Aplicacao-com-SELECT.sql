-- M�dulo 14 - SQL SERVER - Subqueries e CTE's


/* AULA 09 - Subquery na pr�tica (Aplica��o com o SELECT)
Podemos tamb�m utilizar subqueries para criar novas colunas dentro de uma consulta.
Repare no exemplo abaixo: Queremos descobrir qual foi o total de vendas de cada produto da nossa tabela DimProduct. Para isso, adicionamos uma subquery (um novo SELECT) como sendo uma couna extra da nossa consulta principal. Assim, al�m de mostrar as colunas ProductKey e ProductName da tabela dimProduct, adicionamos tamb�m uma coluna que faz a contagem de vendas na tabela FactSales.

 Exemplo: Retornar uma tabela com todos os produtos (ID Produto e Nome Produto) e tamb�m o total de vendas para cada produto */

SELECT
	ProductKey,
	ProductName,
	(SELECT COUNT(ProductKey) FROM FactSales WHERE FactSales.ProductKey = DimProduct.ProductKey) AS 'Qtd. Vendas'
FROM
	DimProduct
