-- M�dulo 06 - SQL SERVER - AGRUPAMENTOS NO SQL


-- Os exerc�cios abaixo est�o divididos de acordo com uma determinada tabela do Banco de Dados. FACTSALES


/* Exerc�cio 01:
a) Fa�a um resumo da quantidade vendida (SalesQuantity) de acordo com o canal de vendas (channelkey). */
SELECT TOP (100) * FROM FactSales

SELECT
	ChannelKey AS 'Canal de Venda',
	SUM(SalesQuantity) AS 'Total Vendido'
FROM
	FactSales
GROUP BY channelKey


-- b) Fa�a um agrupamento mostrando a quantidade total vendida (SalesQuantity) e quantidade total devolvida (Return Quantity) de acordo com o ID das lojas (StoreKey). 
SELECT TOP (100) * FROM FactSales

SELECT
	StoreKey AS 'ID da Loja',
	SUM(SalesQuantity) AS 'Total Vendido',
	SUM(ReturnQuantity) AS 'Total Devolvio'
FROM
	FactSales
GROUP BY StoreKey


-- c) Fa�a um resumo do valor total vendido (SalesAmount) para cada canal de venda, mas apenas para o ano de 2007.
SELECT TOP(100) * FROM FactSales

SELECT
	channelKey AS 'Canal de Venda',
	SUM(SalesAmount) AS 'Faturamento Total'
FROM
	FactSales
WHERE DateKey LIKE '%2007%' -- ou WHERE DateKey BETWEEN '20070101' AND 20071231'
GROUP BY channelKey

------------------------------

/* Exerc�cio 02:
Voc� precisa fazer uma an�lise de vendas por produtos. O objetivo final � descobrir o valor total vendido (SalesAmount) por produto (ProductKey). 

a) A tabela final dever� estar ordenada de acordo com a quantidade vendida e, al�m disso, mostrar apenas os produtos que tiveram um resultado final de vendas maior do que $5.000.000. */
SELECT TOP (100) * FROM FactSales

SELECT
	ProductKey AS 'ID do Produto',
	SUM(SalesAmount) AS 'Faturamento Total'
FROM
	FactSales
GROUP BY ProductKey
HAVING SUM(SalesAmount) >= 5000000
ORDER BY SUM(SalesAmount) DESC


-- b) Fa�a uma adapta��o no exerc�cio anterior e mostre os Top 10 produtos com mais vendas. Desconsidere o filtro de $5.000.000 aplicado.
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
/* Exerc�cio 03:
a) Voc� deve fazer uma consulta � tabela FactOnlineSales e descobrir qual � o ID (CustomerKey) do cliente que mais realizou compras online (de acordo com a coluna SalesQuantity). */
SELECT TOP (100) * FROM FactOnlineSales

SELECT
	CustomerKey AS 'ID do Cliente',
	SUM(SalesQuantity) AS 'Total Comprado'
FROM
	FactOnlineSales
GROUP BY CustomerKey
ORDER BY SUM(SalesQuantity) DESC


-- b) Feito isso, fa�a um agrupamento de total vendido (SalesQuantity) por ID do produto e descubra quais foram os top 3 produtos mais comprados pelo cliente da letra a).
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
/* Exerc�cio 04:
a) Fa�a um agrupamento e descubra a quantidade total de produtos por marca. */
SELECT * FROM DimProduct

SELECT
	BrandName AS 'Marca',
	COUNT(ProductName) AS 'QTD. Produtos'
FROM
	DimProduct
GROUP BY BrandName


-- b) Determine a m�dia do pre�o unit�rio (UnitPrice) para cada ClassName.
SELECT * FROM DimProduct

 SELECT
	ClassName AS 'Classe do Produto',
	AVG(UnitPrice) AS 'Pre�o M�dio'
 FROM
	DimProduct
GROUP BY ClassName


-- c) Fa�a um agrupamento de cores e descubra o peso total que cada cor de produto possui. 
SELECT * FROM DimProduct

SELECT
	ColorName AS 'Cor',
	SUM(Weight) AS 'Peso Total'
FROM
	DimProduct
GROUP BY ColorName

------------------------------

/* Exerc�cio 05: 
Voc� dever� descobrir o peso total para cada tipo de produto (StockTypeName).  
A tabela final deve considerar apenas a marca �Contoso� e ter os seus valores classificados em ordem decrescente. */
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

/* Exerc�cio 06: 
Voc� seria capaz de confirmar se todas as marcas dos produtos possuem � disposi��o todas as 16 op��es de cores? */
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
/* Exerc�cio 07: 
Fa�a um agrupamento para saber o total de clientes de acordo com o Sexo e tamb�m a m�dia salarial de acordo com o Sexo. Corrija qualquer resultado �inesperado� com os seus conhecimentos em SQL. */
SELECT * FROM DimCustomer

-- Total de Cliente de acordo com o G�nero
SELECT
	Gender AS 'G�nero',
	COUNT(CustomerKey) AS 'Total de Cliente'
FROM
	DimCustomer
WHERE Gender IS NOT NULL
Group BY Gender

-- M�dia Salarial de acordo com o G�nero.
SELECT
	Gender AS 'G�nero',
	AVG(YearlyIncome) AS 'M�dia Sal�rial'
FROM
	DimCustomer
WHERE Gender IS NOT NULL
Group BY Gender

-- Total de Cliente e M�dia Salarial de acordo com o G�nero
SELECT
	Gender AS 'G�nero',
	COUNT(CustomerKey) AS 'Total de Cliente',
	AVG(YearlyIncome) AS 'M�dia Sal�rial'
FROM
	DimCustomer
WHERE Gender IS NOT NULL
Group BY Gender

------------------------------

/* Exerc�cio 08: 
Fa�a um agrupamento para descobrir a quantidade total de clientes e a m�dia salarial de acordo com o seu n�vel escolar. Utilize a coluna Education da tabela DimCustomer para fazer esse agrupamento. */
SELECT * FROM DimCustomer

SELECT
	Education AS 'N�vel Escolar',
	COUNT(CustomerKey) AS 'QTD. de Clientes',
	AVG(YearlyIncome) AS 'M�dia Salarial'
FROM
	DimCustomer
WHERE Education IS NOT NULL
GROUP BY Education


-- DIMEMPLOYEE
/* Exerc�cio 09: 
Fa�a uma tabela resumo mostrando a quantidade total de funcion�rios de acordo com o Departamento (DepartmentName). Importante: Voc� dever� considerar apenas os funcion�rios ativos. */

SELECT * FROM DimEmployee WHERE DepartmentName = 'Executive'

SELECT
	DepartmentName AS 'Departamento',
	COUNT(EmployeeKey) AS 'QTD. de Funcion�rios'
FROM
	DimEmployee
WHERE Status = 'Current' OR EndDate IS NULL
GROUP BY DepartmentName

------------------------------

/* Exerc�cio 10: 
Fa�a uma tabela resumo mostrando o total de VacationHours para cada cargo (Title). Voc� deve considerar apenas as mulheres, dos departamentos de Production, Marketing, Engineering e Finance, para os funcion�rios contratados entre os anos de 1999 e 2000.  */
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