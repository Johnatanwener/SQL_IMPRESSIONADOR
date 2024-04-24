-- Módulo 06 - SQL SERVER - AGRUPAMENTOS NO SQL

/* AULA 05 - GROUP BY mais WHERE
O comando GROUP BY combinado com o WHERE permite que a tabela principal seja filtrada antes de o agrupamento ser criado.

Faça uma consulta que retorne a CONTAGEM do total de produtos por COR, FILTRE os valores pela marca 'Contoso' e faça uma ordenação */
SELECT * FROM DimProduct

SELECT
	ColorName AS 'Cor do Produto',
	COUNT(*) AS 'Total de Produtos'
FROM
	DimProduct
WHERE BrandName = 'Contoso'
GROUP BY ColorName
ORDER BY [Total de Produtos] DESC