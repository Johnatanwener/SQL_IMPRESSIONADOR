-- M�DULO 07 - SQL SERVER - JOINs 

/*AULA 12 - LEFT, RIGHT, INNER JOIN e ANTI JOIN - Exemplos
A estrutura de um LEFT JOIN, RIGHT JOIN OU INNER JOIN � muito semelhante, apenas trocamos o JOIN. 

Lembrando que: 
Um LEFT JOIN retorna todas as linhas da tabela A (esquerda) mais as linhas que s�o a interse��o entre a Tabela A e a Tabela B.

Um RIGHT JOIN retorna todas as linhas da tabela B (direita) mais as linhas que s�o a interse��o entre a Tabela A e a Tabela B.

Um INNER JOIN retorna somente as linhas que s�o a interse��o entre as tabelas A e B.

Um LEFT ANTI JOIN n�o existe como cl�usula pois necessita ser usado com o WHERE, onde consideramos os valores NULL

Um RIGHT ANTI JOIN n�o existe como cl�usula pois necessita ser usado com o WHERE, onde consideramos os valores NULL

Um FULL ANTI JOIN n�o existe como cl�usula pois necessita ser usado com o WHERE, onde consideramos os valores NULL

Na pr�tica, os JOINs (ANTI) sempre ser�o uma combina��o entre JOINs 'normais' com o WHERE, onde consideramos os  valores nulos.
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