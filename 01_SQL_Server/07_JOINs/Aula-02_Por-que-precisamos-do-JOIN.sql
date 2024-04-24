-- MÓDULO 07 - SQL SERVER - JOINs 

/* AULA 02 - Por que precisamos do JOIN?
A cláusula JOIN em SQL, é uma operação de junção que combina colunas de uma ou mais tabels em um banco de dados relacional. 
Na linguagem SQL, executamos diversas consultas para gerealmente criar relatórios que serão posteriormente utilizados para análise e tomada de decisão, e para criarmos consultas cada vez mais completas e complexas precisaremos utilizar varias tabelas em conjunto e para isso iremos usar os JOINs. */

-- Para descobrir o ChannelName e juntar com as informações da tabela FactSales, precisariamos da cláusula JOIN, pois na tabela FactSales não temos o ChannelName, apenas o ChannelKey.
SELECT TOP (1000) * FROM FactSales
SELECT * FROM DimChannel


SELECT
	ChannelKey,
	SUM(SalesQuantity) AS 'QTD. Vendida'
FROM
	FactSales
Group BY ChannelKey

-- Se quisermos descobrir as informações de um produto vendido precisariamos da cláusula JOIN para extrair as informações da tabela DimProduct e juntar com as informações da tabela FactSales.
SELECT TOP(1000) * FROM FactSales
SELECT * FROM DimProduct

-- Se quisermos descobrir as informações de um determinado cliente a partir de um registro de compra da tabela FactOnlineSales, precisariamos utilizar a cláusula JOIN, para juntar as informações das tabelas factOnlineSales e DimCustomer.
SELECT TOP(1000) * FROM FactOnlineSales
SELECT * FROM DimCustomer

-- Se quisermos identificar o ScenarioName para juntar com as informações da tabela FactStrategyPlan, precisariamos da cláusula JOIN para juntar as tabelas FactStrategyPlan com a tabela DimScenario
SELECT TOP(100) * FROM FactStrategyPlan
SELECT * FROM DimScenario