-- M�DULO 05 - SQL SERVER - Fun��es e Agrega��es


/* AULA 04 - Fun��o COUNT mais DISTINCT
A fun��o COUNT combinado com o DISTINCT � utilizado para fazer uma contagem distinta dos valores de uma coluna */

SELECT * FROM DimProduct

-- 1. Fa�a uma consulta que retorna a contagem distinta de cores de produtos.
SELECT
	COUNT(DISTINCT COlorName) AS 'QTD. Cores'
FROM DimProduct


-- 2. Fa�a uma consulta que retorna a contagem distinta das marcas dos produtos
SELECT
	COUNT(DISTINCT BrandName) AS 'QTD. Marcas'
FROM DimProduct

