-- M�DULO 26 - SQL SERVER - Integra��o SQL SERVER e EXCEL

/* AULA 06-07 - Iniciando o c�digo da view VENDAS_INTERNET

Agora, vamos criar o c�digo da nossa view Vendas_internet. Lembrando que, queremos construir os seguintes indicadores para construir nossas an�lises. 

Obs.: Propositalmente n�o ser� inclu�do a coluna 'Gender', para posteriormente aprendermos como alterar um c�digo e incluir uma nova coluna ap�s a integra��o com o Excel ter sido efetuada.

1� Total de Vendas Internet por Categoria do Produto;
2� Receita Total Internet por M�s do Pedido;
3� Receita e Custo Total Internet por Pa�s;
4� Total de Vendas Internet por Sexo do Cliente;

- Obs.: O ano de an�lise ser� apenas 2013 (ANO DO PEDIDO)		*/

CREATE OR ALTER VIEW VENDAS_INTERNET AS
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