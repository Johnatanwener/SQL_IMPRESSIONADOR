-- M�dulo 14 - SQL SERVER - Subqueries e CTE's

/* AULA 07 e 08 - EXISTS
O operador EXISTS � usado para testar a exist�ncia de qualquer registro (linha) em uma subconsulta.
Pensando em um exemplo pr�tico, imagina que queiramos descobrir quais s�o os produtos que possuem vendas em um determinado dia.

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


-- Solu��o alternativa com o ANY
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