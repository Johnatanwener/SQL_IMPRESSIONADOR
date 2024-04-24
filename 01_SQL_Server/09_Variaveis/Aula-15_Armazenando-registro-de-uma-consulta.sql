-- MÓDULO 09 - SQL SERVER - VARIÁVEIS


/*AULA 15 - ARMAZENANDO EM UMA VARIÁVEL UM REGISTRO DE UMA CONSULTA
Variáveis também nos permitem armazenar determinados registros dentro de uma tabela.

Registros são as informações que temos dentro de uma tabela. Por meio de um filtro ou TOP(N) é possível acessar esses registros. E para fechar, conseguimos armazenar esses registros dentro de variáveis.

No exemplo abaixo, armazenamos dentro de duas variáveis o nome e o total vendido. Utilizamos para isso o TOPN(N) e o ORDER BY */

SELECT TOP(100) * FROM FactSales
ORDER BY SalesQuantity DESC

-- Exemplo 1: Qual é o nome do produto que teve a maior quantidade vendida EM UMA ÚNICA VENDA da tabela FactSales?
DECLARE @varProdutoMaisVendido INT
DECLARE @varTotalMaisVendido INT

SELECT TOP (1)
	@varProdutoMaisVendido = ProductKey, -- 2495
	@varTotalMaisVendido = SalesQuantity -- 2880
FROM
	FactSales
ORDER BY SalesQuantity DESC

PRINT @varProdutoMaisVendido
PRINT @varTotalMaisVendido

SELECT
	ProductKey,
	ProductName
FROM
	DimProduct
WHERE ProductKey = @varProdutoMaisVendido