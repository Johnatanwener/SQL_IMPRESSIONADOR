-- M�DULO 05 - SQL SERVER - Fun��es e Agrega��es


/* AULA 03 - Fun��o COUNT
A fun��o COUNT() retorna a quantidade de linhas de uma coluna. � poss�vel fazer uma contagem e especificar um determinado crit�rio. */

SELECT * FROM DimProduct

-- 1. Fa�a uma consulta que retorna a contagem total de produtos da tabela DimProduct
SELECT
	COUNT(*) AS 'Total de Produtos'
FROM DimProduct


-- 2. Fa�a uma consulta que retorna a contagem total de produtos. Considere a coluna ProductName para este c�lculo
SELECT
	COUNT(ProductName) AS 'Qtd. Produtos'
FROM DimProduct


-- 3. Fa�a uma consulta que retorna a contagem total de produtos. Considere a coluna Size para este c�lculo
SELECT
	COUNT(Size) AS 'Tamanho'
FROM DimProduct
-- Obs: A fun��o COUNT n�o conta valores nulos da coluna, ent�o tome cuidado com o resultado que voc� espera.