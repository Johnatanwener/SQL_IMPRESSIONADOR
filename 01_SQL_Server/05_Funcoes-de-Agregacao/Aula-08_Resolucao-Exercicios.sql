-- M�DULO 05 - SQL SERVER - Fun��es e Agrega��es


/* Exerc�cio 1:
O gerente comercial pediu a voc� uma an�lise da Quantidade Vendida e Quantidade Devolvida para o canal de venda mais importante da empresa:  Store. 
Utilize uma fun��o SQL para fazer essas consultas no seu banco de dados. Obs: Fa�a essa 
an�lise considerando a tabela FactSales. */

SELECT TOP (100) * FROM FactSales

SELECT
	SUM(SalesQuantity) AS 'QTD. Vendida',
	SUM(ReturnQuantity) AS 'QTD. Devolvida'
FROM
	FactSales
WHERE ChannelKey = 1

SELECT * FROM DimChannel

------------------------------

/* Exerc�cio 2:
Uma nova a��o no setor de Marketing precisar� avaliar a m�dia salarial de todos os clientes da empresa, mas apenas de ocupa��o Professional.  Utilize um comando SQL para atingir esse resultado. */

SELECT * FROM DimCustomer

SELECT
	AVG(YearlyIncome) AS 'M�dia Sal�rial'
FROM
	DimCustomer
WHERE Occupation = 'Professional'

------------------------------

/* Exerc�cio 3:
Voc� precisar� fazer uma an�lise da quantidade de funcion�rios das lojas registradas na empresa. O seu gerente te pediu os seguintes n�meros e informa��es: 

a) Quantos funcion�rios tem a loja com mais funcion�rios? 
b) Qual � o nome dessa loja? 
c) Quantos funcion�rios tem a loja com menos funcion�rios? 
d) Qual � o nome dessa loja? */

SELECT * FROM DimStore

-- a) Quantos funcion�rios tem a loja com mais funcion�rios? 
SELECT
	MAX(EmployeeCount) AS 'QTD. M�x. Funcion�rios'
FROM
	DimStore


-- b) Qual � o nome dessa loja? 
SELECT
	TOP(1) StoreName AS 'Nome da Loja',
	EmployeeCount AS 'QTD. Funcion�rios'
FROM
	DimStore
ORDER BY EmployeeCount DESC


-- c) Quantos funcion�rios tem a loja com menos funcion�rios? 
SELECT
	MIN(EmployeeCount) AS 'QTD. M�n. Funcion�rios'
FROM
	DimStore


-- d) Qual � o nome dessa loja? 
SELECT
	TOP(1) StoreName AS 'Nome da Loja',
	EmployeeCount AS 'QTD. Funcion�rios'
FROM
	DimStore
WHERE EmployeeCount IS NOT NULL
ORDER BY EmployeeCount

------------------------------

/* Exerc�cio 4: 
A �rea de RH est� com uma nova a��o para a empresa, e para isso precisa saber a quantidade total de funcion�rios do sexo Masculino e do sexo Feminino.  

a) Descubra essas duas informa��es utilizando o SQL. 
b) O funcion�rio e a funcion�ria mais antigos receber�o uma homenagem. Descubra as 
seguintes informa��es de cada um deles: Nome, E-mail, Data de Contrata��o. */

SELECT * FROM DimEmployee

-- Qtd. Sexo Masculino
SELECT
	COUNT(Gender) AS 'QTD. Funcion�rios Masc.'
FROM
	DimEmployee
WHERE Gender = 'M'

-- Qtd. Sexo Feminino
SELECT
	COUNT(Gender) AS 'QTD. Funcion�rios Fem.'
FROM
	DimEmployee
WHERE Gender = 'F'

-- Funcion�rio mais antigo - Masculino
SELECT
	TOP(1)FirstName AS 'Nome',
	LastName AS 'Sobrenome',
	EmailAddress AS 'E-mail',
	Gender AS 'G�nero',
	HireDate AS 'Data da Contrata��o'
FROM
	DimEmployee
WHERE Gender = 'M'
ORDER BY HireDate

-- Funcion�ria mais antiga - Feminino
SELECT
	TOP(1)FirstName AS 'Nome',
	LastName AS 'Sobrenome',
	EmailAddress AS 'E-mail',
	Gender AS 'G�nero',
	HireDate AS 'Data da Contrata��o'
FROM
	DimEmployee
WHERE Gender = 'F'
ORDER BY HireDate

------------------------------

/* Exerc�cio 5: 
Agora voc� precisa fazer uma an�lise dos produtos. Ser� necess�rio descobrir as seguintes informa��es: 

a) Quantidade distinta de cores de produtos. 
b) Quantidade distinta de marcas 
c) Quantidade distinta de classes de produto 
Para simplificar, voc� pode fazer isso em uma mesma consulta. */

SELECT * FROM DimProduct

SELECT
	COUNT(DISTINCT BrandName) AS 'QTD. Marcas',
	COUNT(DISTINCT ClassName) AS 'QTD. Classes de Produto',
	COUNT(DISTINCT ColorName) AS 'QTD. Cores'
FROM
	DimProduct
