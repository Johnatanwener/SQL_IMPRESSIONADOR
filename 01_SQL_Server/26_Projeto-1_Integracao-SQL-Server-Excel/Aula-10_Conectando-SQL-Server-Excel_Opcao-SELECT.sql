-- M�DULO 26 - SQL SERVER - Integra��o SQL SERVER e EXCEL

/* AULA 10 - Conectando SQL Server ao Excel (Op��o C�digo SQL no Excel)
Podemos conectar o SQL SERVER ao EXCEL de outra forma da qual foi utilizada nas aulas anteriores. 
E nessa aula iremos conectar novamente o SQL SERVER ao EXCEL s� que dessa vez utilizando a pr�pria consulta do SQL. 
 
Para isso, precisamos voltar ao SSMS apenas para copiar o c�digo do SELECT, 'esquecendo' novamenta a coluna Gender da tabela dimCustomer, para incluirmos posteriormente. 
Obs.: Dessa vez n�o iremos trabalhar com a VIEW, mas apenas com o c�digo SELECT da nossa consulta.

Passo 1: Crie uma nova pasta de trabalho em brando no Excel. 
Passo 2: Navegue at� a guia Dados > Obter Dados > Do Banco de Dados > Do Banco de Dados SQL SERVER. 
Passo 3: Digitar os nomes do Servidor e Banco de Dados 
Passo 4: Agora, ao inv�s de clicarmos em OK, vamos clicar em op��es avan�adas e colar o nossa intru��o SQL.
Passo 5: Novamente, uma janela um preview da tabela ser� apresentado, com as op��es Carregar e Transformar Dados, clicaremos em Carregar pois n�o queremos abrir o Editor do Power Query.	  
Passo 6: Teremos carregadas as mesmas 52.801 linhas do resultado do nosso SELECT dentro da planilha do Excel.
Assim como hav�amos conseguido fazer nas aulas anteriores, utilizando a View. Utilizar uma View ou colar o c�digo vai depender da prefer�ncia de cada um, no final n�o ir� mudar em nada.	  */

SELECT 
	fis.SalesOrderNumber AS 'N� Pedido',
	fis.OrderDate AS 'Data Pedido',
	dpc.EnglishProductCategoryName AS 'Categoria Produto',
	dc.FirstName + ' ' + dc.LastName AS 'Nome Cliente',
		dst.SalesTerritoryCountry AS 'Pa�s',
	fis.OrderQuantity AS 'Qtd. Vendida',
	fis.TotalProductCost AS 'Custo Venda',
	fis.SalesAmount AS 'Receita Venda'
FROM FactInternetSales fis
INNER JOIN DimProduct dp ON fis.ProductKey = dp.ProductKey
	INNER JOIN DimProductSubcategory dps ON dp.ProductSubcategoryKey = dps.ProductSubcategoryKey
		INNER JOIN DimProductCategory dpc ON dps.ProductCategoryKey = dpc.ProductCategoryKey
INNER JOIN DimSalesTerritory dst ON fis.SalesTerritoryKey = dst.SalesTerritoryKey
INNER JOIN DimCustomer dc ON fis.CustomerKey = dc.CustomerKey
WHERE YEAR(OrderDate) = 2013

SELECT * FROM VENDAS_INTERNET