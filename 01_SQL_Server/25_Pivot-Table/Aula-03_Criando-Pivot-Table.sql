-- M�DULO 25 - SQL SERVER - PIVOT TABLE


/* AULA 03 - Criando uma Pivot Table
Para conseguir criar uma PIVOT TABLE das colunas BrandName e Contagem de Produtos da tabela DimProduct precisamos primeiro efetuar uma consulta � tabela DimProduct */

SELECT
	BrandName,
	COUNT(ProductKey) AS Total_Produtos
FROM
	DimProduct
GROUP BY BrandName

/* Depois, para criarmos a PIVOT TABLE, precisamos executar o c�digo abaixo:

Repare que, precisamos de uma subquery para ser utilizada como tabela da nossa consulta principal. Nesta subquery: 
- 1. Fazemos uma consulta �s colunas dos dados que queremos ver na PIVOT TABLE: BrandName e Contagem da tabela ProductKey.
- 2. Inclu�mos o operador PIVOT e passamos as informa��es necess�rias para ele, que s�o:
- 3. O c�lculo que desejamos efetuar (uma contagem da quantidade de produtos): COUNT(ProductKey);
- 4. Para qual coluna devemos agrupar nossa PIVOT TABLE: Neste caso, se queremos uma contagem da quantidade de produtos por marca, devemos agrupar pela coluna BrandName. Ent�o, inclu�mos a linha FOR BrandName.
- 5. Para o operador IN, passamos os nomes de todas as marcas (BrandName) que servir�o de colunas para a nossa PIVOT TABLE. Repare que cada marca precisa estar entre colchetes [], separados por v�rgulas. */

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

-- 1�) O primeiro passo � selecionar os dados que ser�o usados como base para cria��o da Pivot Table
-- 2�) Como n�o conseguimos aplicar o Pivot diretamente nos dados acima, precisaremos fazer isso indiretamente
-- 3�) Agora sim podemos aplicar o Pivot, incluindo o c�lculo desejado e os nomes das colunas a serem consideradas