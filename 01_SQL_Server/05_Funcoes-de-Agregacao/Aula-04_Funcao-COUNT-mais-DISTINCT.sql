-- MÓDULO 05 - SQL SERVER - Funções e Agregações


/* AULA 04 - Função COUNT mais DISTINCT
A função COUNT combinado com o DISTINCT é utilizado para fazer uma contagem distinta dos valores de uma coluna */

SELECT * FROM DimProduct

-- 1. Faça uma consulta que retorna a contagem distinta de cores de produtos.
SELECT
	COUNT(DISTINCT COlorName) AS 'QTD. Cores'
FROM DimProduct


-- 2. Faça uma consulta que retorna a contagem distinta das marcas dos produtos
SELECT
	COUNT(DISTINCT BrandName) AS 'QTD. Marcas'
FROM DimProduct

