-- MÓDULO 26 - SQL SERVER - Integração SQL SERVER e EXCEL

/* AULA 06-07 - Iniciando o código da view VENDAS_INTERNET

Agora, vamos criar o código da nossa view Vendas_internet. Lembrando que, queremos construir os seguintes indicadores para construir nossas análises. 

Obs.: Propositalmente não será incluído a coluna 'Gender', para posteriormente aprendermos como alterar um código e incluir uma nova coluna após a integração com o Excel ter sido efetuada.

1º Total de Vendas Internet por Categoria do Produto;
2º Receita Total Internet por Mês do Pedido;
3º Receita e Custo Total Internet por País;
4º Total de Vendas Internet por Sexo do Cliente;

- Obs.: O ano de análise será apenas 2013 (ANO DO PEDIDO)		*/

CREATE OR ALTER VIEW VENDAS_INTERNET AS
SELECT 
	fis.SalesOrderNumber AS 'Nº Pedido',
	fis.OrderDate AS 'Data Pedido',
	dpc.EnglishProductCategoryName AS 'Categoria Produto',
	dc.FirstName + ' ' + dc.LastName AS 'Nome Cliente',
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