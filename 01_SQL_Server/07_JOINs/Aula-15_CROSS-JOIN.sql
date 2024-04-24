-- MÓDULO 07 - SQL SERVER - JOINs 

/* AULA 15 - CROSS JOIN
Um outro JOIN que pode ser útil é o CROSS JOIN.

Com este JOIN, conseguimos criar uma tabela que é a combinação de TODOS os valores entre duas colunas.

A combinação resultante desse JOIN é conhecida como produto cartesiano, uma combinação um a um de todos os valores de duas ou mais colunas.
*/

SELECT DISTINCT BrandName FROM DimProduct 
SELECT * FROM DimProductCategory

SELECT DISTINCT
	BrandName,
	ProductCategoryName
FROM DimProduct CROSS JOIN DimProductCategory