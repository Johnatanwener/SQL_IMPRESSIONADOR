-- Módulo 06 - SQL SERVER - AGRUPAMENTOS NO SQL


/* AULA 07 - WHERE VS HAVING
É muito importante que fique claro a diferença entre os comandos WHERE e HAVING.

Para entender a diferença entre os dois, vale lembrar que o GROUP BY permite que a gente crie um agrupamento a partir de uma tabela principal.

O comando WHERE será utilizado para filtrar a tabela principal antes de criar o agrupamento.
O comando HAVING será utilizado para filtrar a tabela após o agrupamento.

Portanto, podemos entender que:

- O WHERE será utilizado antes do agrupamento feito;
- O HAVING será um filtro utilizado após o agrupamento feito.

Diferenças entre WHERE e HAVING na filtragem de tabelas. */
SELECT * FROM DimProduct

SELECT
	BrandName AS 'Marca',
	COUNT(BrandName) AS 'Total por Marca'
FROM
	DimProduct
WHERE ClassName = 'Economy'	   -- Filtra a tabela original, antes do agrupamento.
GROUP BY BrandName
HAVING COUNT(BrandName) >= 200 -- Filtra a tabela depois de agrupada.