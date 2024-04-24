-- MÓDULO 05 - SQL SERVER - Funções e Agregações


/* AULA 03 - Função COUNT
A função COUNT() retorna a quantidade de linhas de uma coluna. É possível fazer uma contagem e especificar um determinado critério. */

SELECT * FROM DimProduct

-- 1. Faça uma consulta que retorna a contagem total de produtos da tabela DimProduct
SELECT
	COUNT(*) AS 'Total de Produtos'
FROM DimProduct


-- 2. Faça uma consulta que retorna a contagem total de produtos. Considere a coluna ProductName para este cálculo
SELECT
	COUNT(ProductName) AS 'Qtd. Produtos'
FROM DimProduct


-- 3. Faça uma consulta que retorna a contagem total de produtos. Considere a coluna Size para este cálculo
SELECT
	COUNT(Size) AS 'Tamanho'
FROM DimProduct
-- Obs: A função COUNT não conta valores nulos da coluna, então tome cuidado com o resultado que você espera.