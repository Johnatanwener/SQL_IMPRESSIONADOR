-- MÓDULO 04 - SQL SERVER - ORDENAR E FILTRAR


/* AULA 02-03 - ORDER BY
O ORDER BY é usado para ordenar os valores de uma tabela em ordem crescente ou decrescente.
Por padrão, o ORDER BY ordena os dados em ordem crescente (ASC). Para ordenar de forma descrescente, usamos o DESC.

Selecionando as TOP 100 linhas da tabela DimStore, ordenando pela coluna EmployeeCount de forma decrescente. */
SELECT TOP (100) * FROM DimStore
ORDER BY EmployeeCount DESC

-- Exemplo 1: Selecione as 100 primeiras linhas das colunas StoreName e EmployeeCount da tabela DimStore, e ordene de acordo com a coluna de quantidade de funcionarios.
SELECT TOP(100)
	StoreName,
	EmployeeCount
FROM DimStore
ORDER BY EmployeeCount -- Ordenando de forma crescente
-- ORDER BY EmployeeCount DESC


-- Exemplo 2: Selecione as 100 primeiras linhas da tabela DimStore e ordene de acordo com a coluna de StoreName.
SELECT TOP(100)
	StoreKey,
	StoreName
FROM DimStore
ORDER BY StoreName -- Ordenando de forma crescente
-- ORDER BY StoreName DESC


-- Exemplo 3: Selecione as 100 primeiras linhas da tabela DimProduct, e ordene de acordo com as colunas UnitCost (DESC) e Weight (DESC)
SELECT * FROM DimProduct

SELECT TOP (10) 
	ProductName,
	Weight,
	UnitCost	
FROM DimProduct
ORDER BY 
	UnitCost DESC, 
	Weight DESC