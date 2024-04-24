-- M�DULO 09 - SQL SERVER - VARI�VEIS


/*AULA 15 - ARMAZENANDO EM UMA VARI�VEL UM REGISTRO DE UMA CONSULTA
Vari�veis tamb�m nos permitem armazenar determinados registros dentro de uma tabela.

Registros s�o as informa��es que temos dentro de uma tabela. Por meio de um filtro ou TOP(N) � poss�vel acessar esses registros. E para fechar, conseguimos armazenar esses registros dentro de vari�veis.

No exemplo abaixo, armazenamos dentro de duas vari�veis o nome e o total vendido. Utilizamos para isso o TOPN(N) e o ORDER BY */

SELECT TOP(100) * FROM FactSales
ORDER BY SalesQuantity DESC

-- Exemplo 1: Qual � o nome do produto que teve a maior quantidade vendida EM UMA �NICA VENDA da tabela FactSales?
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