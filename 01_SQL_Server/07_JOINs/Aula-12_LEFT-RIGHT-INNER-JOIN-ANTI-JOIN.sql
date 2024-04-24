-- MÓDULO 07 - SQL SERVER - JOINs 

/*AULA 12 - LEFT, RIGHT, INNER JOIN e ANTI JOIN - Exemplos
A estrutura de um LEFT JOIN, RIGHT JOIN OU INNER JOIN é muito semelhante, apenas trocamos o JOIN. 

Lembrando que: 
Um LEFT JOIN retorna todas as linhas da tabela A (esquerda) mais as linhas que são a interseção entre a Tabela A e a Tabela B.

Um RIGHT JOIN retorna todas as linhas da tabela B (direita) mais as linhas que são a interseção entre a Tabela A e a Tabela B.

Um INNER JOIN retorna somente as linhas que são a interseção entre as tabelas A e B.

Um LEFT ANTI JOIN não existe como cláusula pois necessita ser usado com o WHERE, onde consideramos os valores NULL

Um RIGHT ANTI JOIN não existe como cláusula pois necessita ser usado com o WHERE, onde consideramos os valores NULL

Um FULL ANTI JOIN não existe como cláusula pois necessita ser usado com o WHERE, onde consideramos os valores NULL

Na prática, os JOINs (ANTI) sempre serão uma combinação entre JOINs 'normais' com o WHERE, onde consideramos os  valores nulos.
*/
SELECT ProductKey, ProductName, ProductSubcategoryKey FROM DimProduct
SELECT ProductSubcategoryKey, ProductSubcategoryName FROM DimProductSubcategory

SELECT
	ProductKey,
	ProductName,
	DimProduct.ProductSubcategoryKey,
	ProductSubcategoryName
FROM
	DimProduct
INNER JOIN DimProductSubcategory -- LEFT JOIN e RIGHT JOIN
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
	-- WHERE DimProductSubcategoryKey IS NULL