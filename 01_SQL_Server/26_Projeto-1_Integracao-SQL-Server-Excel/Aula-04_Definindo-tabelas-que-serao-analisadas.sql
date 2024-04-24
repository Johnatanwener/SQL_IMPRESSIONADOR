-- M�DULO 26 - SQL SERVER - Integra��o SQL SERVER e EXCEL

/* AULA 04 - Definindo as tabelas a serem analisadas

Obs.: Iremos trabalhar com as vendas registradas na tabela FactInternetSales

1� Total de Vendas Internet por Categoria do Produto;
- Para construir este indicador, precisaremos relacionar a tabela FactInternetSales com a tabela DimProductCategory.

2� Receita Total Internet por M�s do Pedido;
- Para construir este indicador, precisaremos somente da tabela FactInternetSales.

3� Receita e Custo Total Internet por Pa�s;
- Para construir este indicador, precisaremos relacionar a tabela FactInternetSales com a tabela DimSalesTerritory.

4� Total de Vendas Internet por Sexo do Cliente;
- E por �ltimo, para construir este indicador, precisaremos relacionar as tabelas FactInternetSales com a tabela DimCustomer.

Ou seja, iremos trabalhar com as informa��es das seguintes tabelas: */

SELECT * FROM FactInternetSales
SELECT * FROM DimProductCategory
SELECT * FROM DimSalesTerritory
SELECT * FROM DimCustomer

-- Al�m de precisar das tabelas seguintes para estabelecer os relacionamentos intermedi�rios com JOINS entre as tabelas FactInternetSales e DimProductcategory, e s�o elas:

SELECT * FROM DimProduct
SELECT * FROM DimProductSubcategory