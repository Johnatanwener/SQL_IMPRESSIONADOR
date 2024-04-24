-- Módulo 14 - SQL SERVER - Subqueries e CTE's

/* AULA 07 e 08 - EXISTS
O operador EXISTS é usado para testar a existência de qualquer registro (linha) em uma subconsulta.
Pensando em um exemplo prático, imagina que queiramos descobrir quais são os produtos que possuem vendas em um determinado dia.

Exemplo: Retornar uma tabela com todos os produtos (ID Produto e Nome Produto) que possuem alguma venda no dia 01/01/2007 */

-- Conta a quantidade de Produtos
SELECT COUNT(*) FROM DimProduct -- 2.517 produtos
SELECT TOP(100) * FROM FactSales

-- Retorna uma tabela com todos os produtos que possuem alguma venda
SELECT
	ProductKey,
	ProductName
FROM	
	DimProduct
WHERE EXISTS(
	SELECT
		ProductKey
	FROM
		factSales
	WHERE
		DateKey = '01/01/2007'
		AND factSales.ProductKey = DimProduct.ProductKey
)


-- Solução alternativa com o ANY
SELECT
	ProductKey,
	ProductName
FROM	
	DimProduct
WHERE ProductKey = ANY(
	SELECT
		ProductKey
	FROM
		factSales
	WHERE
		DateKey = '01/01/2007'
		-- AND factSales.ProductKey = DimProduct.ProductKey
	)