-- MÓDULO 25 - SQL SERVER - PIVOT TABLE


/* AULA 03 - Criando uma Pivot Table
Para conseguir criar uma PIVOT TABLE das colunas BrandName e Contagem de Produtos da tabela DimProduct precisamos primeiro efetuar uma consulta à tabela DimProduct */

SELECT
	BrandName,
	COUNT(ProductKey) AS Total_Produtos
FROM
	DimProduct
GROUP BY BrandName

/* Depois, para criarmos a PIVOT TABLE, precisamos executar o código abaixo:

Repare que, precisamos de uma subquery para ser utilizada como tabela da nossa consulta principal. Nesta subquery: 
- 1. Fazemos uma consulta às colunas dos dados que queremos ver na PIVOT TABLE: BrandName e Contagem da tabela ProductKey.
- 2. Incluímos o operador PIVOT e passamos as informações necessárias para ele, que são:
- 3. O cálculo que desejamos efetuar (uma contagem da quantidade de produtos): COUNT(ProductKey);
- 4. Para qual coluna devemos agrupar nossa PIVOT TABLE: Neste caso, se queremos uma contagem da quantidade de produtos por marca, devemos agrupar pela coluna BrandName. Então, incluímos a linha FOR BrandName.
- 5. Para o operador IN, passamos os nomes de todas as marcas (BrandName) que servirão de colunas para a nossa PIVOT TABLE. Repare que cada marca precisa estar entre colchetes [], separados por vírgulas. */

SELECT * FROM
(SELECT
	ProductKey,
	BrandName
FROM DimProduct) AS Daddos
PIVOT(
	COUNT(ProductKey)
	FOR BrandName
	IN ([Northwind Traders]
		,[Contoso]
		,[Tailspin Toys]
		,[Adventure Works]
		,[Southridge Video]
		,[Wide World Importers]
		,[The Phone Company]
		,[Fabrikam]
		,[Litware]
		,[A. Datum]
		,[Proseware]
	)
) AS PivotTable

SELECT DISTINCT ',[' + TRIM(BrandName) + ']' FROM DimProduct

-- 1º) O primeiro passo é selecionar os dados que serão usados como base para criação da Pivot Table
-- 2º) Como não conseguimos aplicar o Pivot diretamente nos dados acima, precisaremos fazer isso indiretamente
-- 3º) Agora sim podemos aplicar o Pivot, incluindo o cálculo desejado e os nomes das colunas a serem consideradas