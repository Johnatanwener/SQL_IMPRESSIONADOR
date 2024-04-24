-- Módulo 06 - SQL SERVER - AGRUPAMENTOS NO SQL


-- Os exercícios abaixo estão divididos de acordo com uma determinada tabela do Banco de Dados. FACTSALES


/* Exercício 01:
a) Faça um resumo da quantidade vendida (SalesQuantity) de acordo com o canal de vendas (channelkey). */
SELECT TOP (100) * FROM FactSales

SELECT
	ChannelKey AS 'Canal de Venda',
	SUM(SalesQuantity) AS 'Total Vendido'
FROM
	FactSales
GROUP BY channelKey


-- b) Faça um agrupamento mostrando a quantidade total vendida (SalesQuantity) e quantidade total devolvida (Return Quantity) de acordo com o ID das lojas (StoreKey). 
SELECT TOP (100) * FROM FactSales

SELECT
	StoreKey AS 'ID da Loja',
	SUM(SalesQuantity) AS 'Total Vendido',
	SUM(ReturnQuantity) AS 'Total Devolvio'
FROM
	FactSales
GROUP BY StoreKey


-- c) Faça um resumo do valor total vendido (SalesAmount) para cada canal de venda, mas apenas para o ano de 2007.
SELECT TOP(100) * FROM FactSales

SELECT
	channelKey AS 'Canal de Venda',
	SUM(SalesAmount) AS 'Faturamento Total'
FROM
	FactSales
WHERE DateKey LIKE '%2007%' -- ou WHERE DateKey BETWEEN '20070101' AND 20071231'
GROUP BY channelKey

------------------------------

/* Exercício 02:
Você precisa fazer uma análise de vendas por produtos. O objetivo final é descobrir o valor total vendido (SalesAmount) por produto (ProductKey). 

a) A tabela final deverá estar ordenada de acordo com a quantidade vendida e, além disso, mostrar apenas os produtos que tiveram um resultado final de vendas maior do que $5.000.000. */
SELECT TOP (100) * FROM FactSales

SELECT
	ProductKey AS 'ID do Produto',
	SUM(SalesAmount) AS 'Faturamento Total'
FROM
	FactSales
GROUP BY ProductKey
HAVING SUM(SalesAmount) >= 5000000
ORDER BY SUM(SalesAmount) DESC


-- b) Faça uma adaptação no exercício anterior e mostre os Top 10 produtos com mais vendas. Desconsidere o filtro de $5.000.000 aplicado.
SELECT TOP (100) * FROM FactSales

SELECT
	TOP (10) ProductKey AS 'ID do Produto',
	SUM(SalesAmount) AS 'Faturamento Total'
FROM
	FactSales
GROUP BY ProductKey
HAVING SUM(SalesAmount) >= 5000000
ORDER BY SUM(SalesAmount) DESC

------------------------------

--FACTONLINESALES
/* Exercício 03:
a) Você deve fazer uma consulta à tabela FactOnlineSales e descobrir qual é o ID (CustomerKey) do cliente que mais realizou compras online (de acordo com a coluna SalesQuantity). */
SELECT TOP (100) * FROM FactOnlineSales

SELECT
	CustomerKey AS 'ID do Cliente',
	SUM(SalesQuantity) AS 'Total Comprado'
FROM
	FactOnlineSales
GROUP BY CustomerKey
ORDER BY SUM(SalesQuantity) DESC


-- b) Feito isso, faça um agrupamento de total vendido (SalesQuantity) por ID do produto e descubra quais foram os top 3 produtos mais comprados pelo cliente da letra a).
SELECT
	TOP (3) ProductKey AS 'ID do Produto',
	SUM(SalesQuantity) AS 'Total Comprado'
FROM
	FactOnlineSales
WHERE CustomerKey = '19037'
GROUP BY ProductKey
ORDER BY SUM(SalesQuantity) DESC

------------------------------

-- DIMPRODUCT
/* Exercício 04:
a) Faça um agrupamento e descubra a quantidade total de produtos por marca. */
SELECT * FROM DimProduct

SELECT
	BrandName AS 'Marca',
	COUNT(ProductName) AS 'QTD. Produtos'
FROM
	DimProduct
GROUP BY BrandName


-- b) Determine a média do preço unitário (UnitPrice) para cada ClassName.
SELECT * FROM DimProduct

 SELECT
	ClassName AS 'Classe do Produto',
	AVG(UnitPrice) AS 'Preço Médio'
 FROM
	DimProduct
GROUP BY ClassName


-- c) Faça um agrupamento de cores e descubra o peso total que cada cor de produto possui. 
SELECT * FROM DimProduct

SELECT
	ColorName AS 'Cor',
	SUM(Weight) AS 'Peso Total'
FROM
	DimProduct
GROUP BY ColorName

------------------------------

/* Exercício 05: 
Você deverá descobrir o peso total para cada tipo de produto (StockTypeName).  
A tabela final deve considerar apenas a marca ‘Contoso’ e ter os seus valores classificados em ordem decrescente. */
SELECT * FROM DimProduct

SELECT
	StockTypeName AS 'Tipo de Produto',
	SUM(Weight) AS 'Peso Total'
FROM
	DimProduct
WHERE BrandName = 'Contoso'
GROUP BY StockTypeName
ORDER BY SUM(Weight) DESC

------------------------------

/* Exercício 06: 
Você seria capaz de confirmar se todas as marcas dos produtos possuem à disposição todas as 16 opções de cores? */
SELECT * FROM DimProduct

SELECT
	BrandName AS 'Nome da Marca',
	COUNT(DISTINCT ColorName) AS 'Cores'
FROM
	DimProduct
GROUP BY BrandName

SELECT DISTINCT ColorName FROM DimProduct WHERE BrandName = 'Contoso'

------------------------------

-- DIMCUSTOMER
/* Exercício 07: 
Faça um agrupamento para saber o total de clientes de acordo com o Sexo e também a média salarial de acordo com o Sexo. Corrija qualquer resultado “inesperado” com os seus conhecimentos em SQL. */
SELECT * FROM DimCustomer

-- Total de Cliente de acordo com o Gênero
SELECT
	Gender AS 'Gênero',
	COUNT(CustomerKey) AS 'Total de Cliente'
FROM
	DimCustomer
WHERE Gender IS NOT NULL
Group BY Gender

-- Média Salarial de acordo com o Gênero.
SELECT
	Gender AS 'Gênero',
	AVG(YearlyIncome) AS 'Média Salárial'
FROM
	DimCustomer
WHERE Gender IS NOT NULL
Group BY Gender

-- Total de Cliente e Média Salarial de acordo com o Gênero
SELECT
	Gender AS 'Gênero',
	COUNT(CustomerKey) AS 'Total de Cliente',
	AVG(YearlyIncome) AS 'Média Salárial'
FROM
	DimCustomer
WHERE Gender IS NOT NULL
Group BY Gender

------------------------------

/* Exercício 08: 
Faça um agrupamento para descobrir a quantidade total de clientes e a média salarial de acordo com o seu nível escolar. Utilize a coluna Education da tabela DimCustomer para fazer esse agrupamento. */
SELECT * FROM DimCustomer

SELECT
	Education AS 'Nível Escolar',
	COUNT(CustomerKey) AS 'QTD. de Clientes',
	AVG(YearlyIncome) AS 'Média Salarial'
FROM
	DimCustomer
WHERE Education IS NOT NULL
GROUP BY Education


-- DIMEMPLOYEE
/* Exercício 09: 
Faça uma tabela resumo mostrando a quantidade total de funcionários de acordo com o Departamento (DepartmentName). Importante: Você deverá considerar apenas os funcionários ativos. */

SELECT * FROM DimEmployee WHERE DepartmentName = 'Executive'

SELECT
	DepartmentName AS 'Departamento',
	COUNT(EmployeeKey) AS 'QTD. de Funcionários'
FROM
	DimEmployee
WHERE Status = 'Current' OR EndDate IS NULL
GROUP BY DepartmentName

------------------------------

/* Exercício 10: 
Faça uma tabela resumo mostrando o total de VacationHours para cada cargo (Title). Você deve considerar apenas as mulheres, dos departamentos de Production, Marketing, Engineering e Finance, para os funcionários contratados entre os anos de 1999 e 2000.  */
SELECT * FROM DimEmployee

SELECT
	Title AS 'Cargo',
	SUM(VacationHours) AS 'Horas Totais'
FROM
	DimEmployee
WHERE Gender = 'F' AND 
	DepartmentName IN ('Production', 'Marketing', 'Engineering', 'Finance')  AND
	HireDate BETWEEN '1999-01-01' AND '2000-12-31'
GROUP BY Title