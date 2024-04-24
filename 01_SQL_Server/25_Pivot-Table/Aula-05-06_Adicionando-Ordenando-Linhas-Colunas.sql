-- MÓDULO 25 - SQL SERVER - PIVOT TABLE


/* AULA 05 - Ordenando Linhas e Colunas de uma Pivot Table
Imagine agora que queremos acrescentar à nossa PIVOT TABLE a coluna Ano, para detalhar melhor quando os funcionários de cada departamento foram contratados. Para isso, vamos precisar fazer algumas pequenas alterações em nosso código.

- 1. Primeiramente, vamos ter que acrescentar na subquery que utilizamos como tabela a nova coluna: Ano (extraída da coluna HireDate por meio da função YEAR);
- 2. Ao final do código, podemos também acrescentar um ORDER BY pelas novas colunas (Ano e Mes), para que nossa PIVOT TABLE fique ordenada por ordem de ANO de contratação. */

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

-- Lembra-se que, utilizamos o código abaixo para conseguir retornar os nomes dos departamentos que queríamos ver em nossa PIVOT TABLE. E que esta era uma forma manual de fazer a extração dos dados da coluna. 
SELECT DISTINCT ',' + QUOTENAME(TRIM(DepartmentName)) FROM DimEmployee


-- Obtendo os dados desta forma, por não ser dinâmica, caso ocorra alguma alteração na tabela original, essa mudança não será repassada à PIVOT TABLE que criamos. Portanto, é importante que consigamos fazer essa obtenção de forma mais automática e otimizada, para que a nossa PIVOT TABLE não fique limitada aos dados extraídos no momento da criação de seu código.

------------------------------

/* AULA 06 - Adicionando mais linhas aos grupos
Imagine agora que queremos acrescentar à nossa PIVOT TABLE também a coluna Mes, para detalhar melhor quando os funcionários de cada departamento foram contratados. Para isso, vamos precisar fazer algumas pequenas alterações em nosso código.

- 1. Primeiramente, vamos ter que acrescentar na subquery que utilizamos como tabela a nova coluna: Mes (extraída da coluna HireDate por meio da função MONTH);
- 2. Ao final do código, podemos também acrescentar um ORDER BY pelas novas colunas (Ano e Mes), para que nossa PIVOT TABLE fique ordenada por ordem de ANO/Mes de contratação. */

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

-- Lembra-se que, utilizamos o código abaixo para conseguir retornar os nomes dos departamentos que queríamos ver em nossa PIVOT TABLE. E que esta era uma forma manual de fazer a extração dos dados da coluna. 
SELECT DISTINCT ',' + QUOTENAME(TRIM(DepartmentName)) FROM DimEmployee ORDER BY ',' + QUOTENAME(TRIM(DepartmentName))

-- Obtendo os dados desta forma, por não ser dinâmica, caso ocorra alguma alteração na tabela original, essa mudança não será repassada à PIVOT TABLE que criamos. Portanto, é importante que consigamos fazer essa obtenção de forma mais automática e otimizada, para que a nossa PIVOT TABLE não fique limitada aos dados extraídos no momento da criação de seu código.