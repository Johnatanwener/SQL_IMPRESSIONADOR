-- M�dulo 06 - SQL SERVER - AGRUPAMENTOS NO SQL


/* AULA 07 - WHERE VS HAVING
� muito importante que fique claro a diferen�a entre os comandos WHERE e HAVING.

Para entender a diferen�a entre os dois, vale lembrar que o GROUP BY permite que a gente crie um agrupamento a partir de uma tabela principal.

O comando WHERE ser� utilizado para filtrar a tabela principal antes de criar o agrupamento.
O comando HAVING ser� utilizado para filtrar a tabela ap�s o agrupamento.

Portanto, podemos entender que:

- O WHERE ser� utilizado antes do agrupamento feito;
- O HAVING ser� um filtro utilizado ap�s o agrupamento feito.

Diferen�as entre WHERE e HAVING na filtragem de tabelas. */
SELECT * FROM DimProduct

SELECT
	BrandName AS 'Marca',
	COUNT(BrandName) AS 'Total por Marca'
FROM
	DimProduct
WHERE ClassName = 'Economy'	   -- Filtra a tabela original, antes do agrupamento.
GROUP BY BrandName
HAVING COUNT(BrandName) >= 200 -- Filtra a tabela depois de agrupada.