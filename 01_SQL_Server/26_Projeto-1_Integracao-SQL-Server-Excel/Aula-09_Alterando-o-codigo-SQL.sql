-- M�DULO 26 - SQL SERVER - Integra��o SQL SERVER e EXCEL

/* AULA 09 - Alterando o c�digo SQL e efetivando a altera��o no Power Query
Anteriormente hav�amos 'esquecido' de prop�sito de incluir a coluna Gender na nossa View porque quer�amos deixar para inclu�-la posteriormente, quando j� tivessemos conectado o SQL SERVER ao Excel, para mostrarmos como � poss�vel alterar um c�digo SQL ap�a integra��o j� ter sido efetuada. 
Vamos incluir a coluna Gender e nomear como Sexo. */

CREATE OR ALTER VIEW VENDAS_INTERNET AS
SELECT 
	fis.SalesOrderNumber AS 'N� Pedido',
	fis.OrderDate AS 'Data Pedido',
	dpc.EnglishProductCategoryName AS 'Categoria Produto',
	dc.FirstName + ' ' + dc.LastName AS 'Nome Cliente',
	dc.Gender AS 'Sexo',
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

/* Pronto, a nova coluna foi inclu�da em nossa view. Agora voltaremos ao Excel para atualizarmos nossa planilha.
Obs.: Note que, a planilha n�o ser� atualizada automaticamente, ou seja, n�o ir� aparecer a coluna Sexo assim que retornarmos, precisaremos realizar algumas tarefas para que isso ocorra.

Passo 1: Clique em qualquer campo DENTRO da tabela para que a guia Design da Tabela apare�a;
Passo 2: Na guia Design da Tabela, clique no �cone Atualizar.
Passo 3: Pronto! Efetuado a atualiza��o, a nova coluna Sexo aparecer� em nossa tabela. */
