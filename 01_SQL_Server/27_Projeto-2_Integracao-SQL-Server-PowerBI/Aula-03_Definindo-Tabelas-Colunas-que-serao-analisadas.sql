-- MÓDULO 27 - SQL SERVER - INTEGRAÇÃO SQL SERVER - POWER BI

-- AULA 03 - Definindo as Tabelas e Colunas a serem usadas

SELECT * FROM FactInternetSales
SELECT * FROM DimProductCategory
SELECT * FROM DimCustomer
SELECT * FROM DimGeography

-- COLUNAS
-- SalesOrderNumber                    (FactInternetSales)
-- OrderDate                           (FactInternetSales)
-- EnglishProductCategoryName          (DimProductCategory) ****
-- CustomerKey                         (DimCustomer)
-- FirstName + ' ' + LastName          (DimCustomer)
-- Gender                              (DimCustomer)
-- EnglishCountryRegionName            (DimGeography)
-- OrderQuantity                       (FactInternetSales)
-- SalesAmount                         (FactInternetSales)
-- TotalProductCost                    (FactInternetSales)
-- SalesAmount - TotalProductCost      (FactInternetSales)