-- MÓDULO 26 - SQL SERVER - Integração SQL SERVER e EXCEL

/* AULA 05 - Definindo as colunas da view VENDAS_INTERNET
 Para exportamos para o Excel os dados que queremos analisar com base em nossos indicadores, precisaremos somente de 
algumas colunas das tabelas mencionadas na aula anterior. Sendo assim, criaremos uma View, que chamaremos de 
Vendas_Internet, que retornará como resultado essas colunas, para que possamos trabalhar somente com os dados que 
realmente importam para nossa análise. São elas:

- Colunas:
- SalesOrderNumber                (TABELA 1: FactInternetSales)
- OrderDate                       (TABELA 1: FactInternetSales)
- EnglishProductCategoryName      (TABELA 4: DimProductCategory)
- FirstName + LastName            (TABELA 2: DimCustomer)
- Gender                          (TABELA 2: DimCustomer)
- SalesTerritoryCountry           (TABELA 3: DimSalesTerritory)
- OrderQuantity                   (TABELA 1: FactInternetSales)
- TotalProductCost                (TABELA 1: FactInternetSales)
- SalesAmount                     (TABELA 1: FactInternetSales)
*/