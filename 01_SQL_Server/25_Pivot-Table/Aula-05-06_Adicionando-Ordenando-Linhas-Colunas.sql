-- M�DULO 25 - SQL SERVER - PIVOT TABLE


/* AULA 05 - Ordenando Linhas e Colunas de uma Pivot Table
Imagine agora que queremos acrescentar � nossa PIVOT TABLE a coluna Ano, para detalhar melhor quando os funcion�rios de cada departamento foram contratados. Para isso, vamos precisar fazer algumas pequenas altera��es em nosso c�digo.

- 1. Primeiramente, vamos ter que acrescentar na subquery que utilizamos como tabela a nova coluna: Ano (extra�da da coluna HireDate por meio da fun��o YEAR);
- 2. Ao final do c�digo, podemos tamb�m acrescentar um ORDER BY pelas novas colunas (Ano e Mes), para que nossa PIVOT TABLE fique ordenada por ordem de ANO de contrata��o. */

SELECT * FROM
(SELECT
	EmployeeKey,
	YEAR(HireDate) AS Ano,
	DepartmentName
FROM DimEmployee) AS Dados
PIVOT (
		COUNT(EmployeeKey)
		FOR DepartmentName
		IN([Document Control]
			,[Engineering]
			,[Executive]
			,[Facilities and Maintenance]
			,[Finance]
			,['Human Resources Contral]
			,[Human Resources]
			,[Information Services]
			,[Marketing]
			,[Production Control]
			,[Production]
			,[Purchasing]
			,[Quality Assurance]
			,[Research and Development]
			,[Sales]
			,[Shipping and Receiving]
			,[Tool Design])
) AS PivotTable
ORDER BY Ano

-- Lembra-se que, utilizamos o c�digo abaixo para conseguir retornar os nomes dos departamentos que quer�amos ver em nossa PIVOT TABLE. E que esta era uma forma manual de fazer a extra��o dos dados da coluna. 
SELECT DISTINCT ',' + QUOTENAME(TRIM(DepartmentName)) FROM DimEmployee


-- Obtendo os dados desta forma, por n�o ser din�mica, caso ocorra alguma altera��o na tabela original, essa mudan�a n�o ser� repassada � PIVOT TABLE que criamos. Portanto, � importante que consigamos fazer essa obten��o de forma mais autom�tica e otimizada, para que a nossa PIVOT TABLE n�o fique limitada aos dados extra�dos no momento da cria��o de seu c�digo.

------------------------------

/* AULA 06 - Adicionando mais linhas aos grupos
Imagine agora que queremos acrescentar � nossa PIVOT TABLE tamb�m a coluna Mes, para detalhar melhor quando os funcion�rios de cada departamento foram contratados. Para isso, vamos precisar fazer algumas pequenas altera��es em nosso c�digo.

- 1. Primeiramente, vamos ter que acrescentar na subquery que utilizamos como tabela a nova coluna: Mes (extra�da da coluna HireDate por meio da fun��o MONTH);
- 2. Ao final do c�digo, podemos tamb�m acrescentar um ORDER BY pelas novas colunas (Ano e Mes), para que nossa PIVOT TABLE fique ordenada por ordem de ANO/Mes de contrata��o. */

SELECT * FROM
	(SELECT
		EmployeeKey,
		YEAR(HireDate) AS Ano,
		MONTH(HireDate) AS Mes,
		DATENAME(MM, HIREDATE) AS Mes,
		DepartmentName
	FROM DimEmployee) AS Dados
PIVOT(
	COUNT(EmployeeKey)
	FOR DepartmentName
	IN([Tool Design]
		,[Shipping and Receiving]
		,[Sales]
		,[Research and Development]
		,[Quality Assurance]
		,[Purchasing]
		,[Production]
		,[Production Control]
		,[Marketing]
		,[Information Services]
		,[Human Resources]
		,['Human Resources Contral]
		,[Finance]
		,[Facilities and Maintenance]
		,[Executive]
		,[Engineering]
		,[Document Control])

) AS PivotTable
ORDER BY Ano, Mes

-- Lembra-se que, utilizamos o c�digo abaixo para conseguir retornar os nomes dos departamentos que quer�amos ver em nossa PIVOT TABLE. E que esta era uma forma manual de fazer a extra��o dos dados da coluna. 
SELECT DISTINCT ',' + QUOTENAME(TRIM(DepartmentName)) FROM DimEmployee ORDER BY ',' + QUOTENAME(TRIM(DepartmentName))

-- Obtendo os dados desta forma, por n�o ser din�mica, caso ocorra alguma altera��o na tabela original, essa mudan�a n�o ser� repassada � PIVOT TABLE que criamos. Portanto, � importante que consigamos fazer essa obten��o de forma mais autom�tica e otimizada, para que a nossa PIVOT TABLE n�o fique limitada aos dados extra�dos no momento da cria��o de seu c�digo.