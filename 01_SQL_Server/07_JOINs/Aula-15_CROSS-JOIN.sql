-- M�DULO 07 - SQL SERVER - JOINs 

/* AULA 15 - CROSS JOIN
Um outro JOIN que pode ser �til � o CROSS JOIN.

Com este JOIN, conseguimos criar uma tabela que � a combina��o de TODOS os valores entre duas colunas.

A combina��o resultante desse JOIN � conhecida como produto cartesiano, uma combina��o um a um de todos os valores de duas ou mais colunas.
*/

SELECT DISTINCT BrandName FROM DimProduct 
SELECT * FROM DimProductCategory

SELECT DISTINCT
	BrandName,
	ProductCategoryName
FROM DimProduct CROSS JOIN DimProductCategory