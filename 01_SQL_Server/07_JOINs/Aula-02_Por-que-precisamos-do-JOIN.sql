-- M�DULO 07 - SQL SERVER - JOINs 

/* AULA 02 - Por que precisamos do JOIN?
A cl�usula JOIN em SQL, � uma opera��o de jun��o que combina colunas de uma ou mais tabels em um banco de dados relacional. 
Na linguagem SQL, executamos diversas consultas para gerealmente criar relat�rios que ser�o posteriormente utilizados para an�lise e tomada de decis�o, e para criarmos consultas cada vez mais completas e complexas precisaremos utilizar varias tabelas em conjunto e para isso iremos usar os JOINs. */

-- Para descobrir o ChannelName e juntar com as informa��es da tabela FactSales, precisariamos da cl�usula JOIN, pois na tabela FactSales n�o temos o ChannelName, apenas o ChannelKey.
SELECT TOP (1000) * FROM FactSales
SELECT * FROM DimChannel


SELECT
	ChannelKey,
	SUM(SalesQuantity) AS 'QTD. Vendida'
FROM
	FactSales
Group BY ChannelKey

-- Se quisermos descobrir as informa��es de um produto vendido precisariamos da cl�usula JOIN para extrair as informa��es da tabela DimProduct e juntar com as informa��es da tabela FactSales.
SELECT TOP(1000) * FROM FactSales
SELECT * FROM DimProduct

-- Se quisermos descobrir as informa��es de um determinado cliente a partir de um registro de compra da tabela FactOnlineSales, precisariamos utilizar a cl�usula JOIN, para juntar as informa��es das tabelas factOnlineSales e DimCustomer.
SELECT TOP(1000) * FROM FactOnlineSales
SELECT * FROM DimCustomer

-- Se quisermos identificar o ScenarioName para juntar com as informa��es da tabela FactStrategyPlan, precisariamos da cl�usula JOIN para juntar as tabelas FactStrategyPlan com a tabela DimScenario
SELECT TOP(100) * FROM FactStrategyPlan
SELECT * FROM DimScenario