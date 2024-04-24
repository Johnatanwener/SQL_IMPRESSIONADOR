-- MÓDULO 26 - SQL SERVER - Integração SQL SERVER e EXCEL

/* AULA 04 - Definindo as tabelas a serem analisadas

Obs.: Iremos trabalhar com as vendas registradas na tabela FactInternetSales

1º Total de Vendas Internet por Categoria do Produto;
- Para construir este indicador, precisaremos relacionar a tabela FactInternetSales com a tabela DimProductCategory.

2º Receita Total Internet por Mês do Pedido;
- Para construir este indicador, precisaremos somente da tabela FactInternetSales.

3º Receita e Custo Total Internet por País;
- Para construir este indicador, precisaremos relacionar a tabela FactInternetSales com a tabela DimSalesTerritory.

4º Total de Vendas Internet por Sexo do Cliente;
- E por último, para construir este indicador, precisaremos relacionar as tabelas FactInternetSales com a tabela DimCustomer.

Ou seja, iremos trabalhar com as informações das seguintes tabelas: */

SELECT * FROM FactInternetSales
SELECT * FROM DimProductCategory
SELECT * FROM DimSalesTerritory
SELECT * FROM DimCustomer

-- Além de precisar das tabelas seguintes para estabelecer os relacionamentos intermediários com JOINS entre as tabelas FactInternetSales e DimProductcategory, e são elas:

SELECT * FROM DimProduct
SELECT * FROM DimProductSubcategory