-- M�dulo 14 - SQL SERVER - Subqueries e CTE's


/* AULA 14 - CTE (Common table Expression)
Nessa aula vamos aprender o que � uma CTE (Common Table Expression), uma esp�cie de tabela tempor�ria que conseguimos criar no nosso c�digo e reaproveitar ao longo deste c�digo.

Abaixo temos uma CTE. A estrutura para cri�-la � bem simples. Utilizamos o comando WITH, seguido do nome da CTE, e em seguida o AS para especificar o que vai compor essa CTE. No exemplo abaixo, a CTE vai armazenar determinadas colunas da tabela dimProduct, mas considerando apenas a marca Contoso. Em seguida, podemos selecionar essa CTE utilizando o comando SELECT.

Exemplo: Crie uma CTE para armazenar o resultado de uma consulta que contenha: ProductKey, ProductName, BrandName, ColorName e UnitPrice, apenas para a marca Contoso. */

WITH cte AS (
SELECT
	ProductKey,
	ProductName,
	BrandName,
	ColorName,
	UnitPrice
FROM
	DimProduct
WHERE BrandName = 'Contoso'
)

--SELECT * FROM cte
SELECT COUNT(*) FROM cte