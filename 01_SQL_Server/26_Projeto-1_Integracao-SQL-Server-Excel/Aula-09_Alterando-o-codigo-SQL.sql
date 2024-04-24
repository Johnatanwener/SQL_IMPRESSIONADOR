-- MÓDULO 26 - SQL SERVER - Integração SQL SERVER e EXCEL

/* AULA 09 - Alterando o código SQL e efetivando a alteração no Power Query
Anteriormente havíamos 'esquecido' de propósito de incluir a coluna Gender na nossa View porque queríamos deixar para incluí-la posteriormente, quando já tivessemos conectado o SQL SERVER ao Excel, para mostrarmos como é possível alterar um código SQL apóa integração já ter sido efetuada. 
Vamos incluir a coluna Gender e nomear como Sexo. */

CREATE OR ALTER VIEW VENDAS_INTERNET AS
SELECT 
	fis.SalesOrderNumber AS 'Nº Pedido',
	fis.OrderDate AS 'Data Pedido',
	dpc.EnglishProductCategoryName AS 'Categoria Produto',
	dc.FirstName + ' ' + dc.LastName AS 'Nome Cliente',
	dc.Gender AS 'Sexo',
	dst.SalesTerritoryCountry AS 'País',
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

/* Pronto, a nova coluna foi incluída em nossa view. Agora voltaremos ao Excel para atualizarmos nossa planilha.
Obs.: Note que, a planilha não será atualizada automaticamente, ou seja, não irá aparecer a coluna Sexo assim que retornarmos, precisaremos realizar algumas tarefas para que isso ocorra.

Passo 1: Clique em qualquer campo DENTRO da tabela para que a guia Design da Tabela apareça;
Passo 2: Na guia Design da Tabela, clique no ícone Atualizar.
Passo 3: Pronto! Efetuado a atualização, a nova coluna Sexo aparecerá em nossa tabela. */
