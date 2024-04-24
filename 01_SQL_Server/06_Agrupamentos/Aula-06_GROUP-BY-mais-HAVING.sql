-- Módulo 06 - SQL SERVER - AGRUPAMENTOS NO SQL


/* AULA 06 - GROUP BY mais HAVING
O comando GROUP BY combinado com o HAVING permite que a tabela agrupada seja filtrada e que apenas os valores totais que atendam ao critério do HAVING sejam considerados.

Faça uma consulta que retorne a quantidade de produtos por MARCA e posteriormente realize um filtro nos dados agrupados para mostrar apenas as marcas com mais de 200 produtos. */
SELECT * FROM DimProduct

SELECT
	BrandName AS 'Marca',
	COUNT(BrandName) AS 'Total por Marca'
FROM
	DimProduct
GROUP BY BrandName
HAVING COUNT(BrandName) >= 200