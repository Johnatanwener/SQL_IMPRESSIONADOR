-- MÓDULO 25 - SQL SERVER - PIVOT TABLE


/* AULA 07-08 - Limitações de uma Pivot Table e Corrigindo a limitação da Pivot Table de forma dinâmica
Inicialmente, precisamos encontrar uma forma dinâmica de pegar os nomes de todos os departamentos da coluna DepartmentName da tabela dimEmployee e armazená-los em uma variável, em formato de string (texto). Para isso, faremos o seguinte:

- 1. Vamos declarar uma variável que receberá os nomes de todos os departamentos: @NomeColunas do tipo NVARCHAR;
- 2. Depois, faremos um SELECT que retornará a variável @NomeColunas para que ela vá recebendo departamento distinto por departamento distinto e vá armazenando, um a um, seguido de uma vírgula concatenada.
- 3. Repare que, aqui, utilizamos uma subquery para retornar os departamentos distintos da coluna DeparmentName da tabela dimEmployee e a utilizamos como a tabela da nossa consulta principal.
- 4. Por fim, vamos retirar a última vírgula concatenada após o último departamento armazenado na variável @NomeColunas. Para isso, basta utilizarmos a função LEFT.

- Se fizermos um PRINT a variável @NomeColunas, repare que será retornada uma string com os nomes de todos os departamentos entre colchetes, separados por vírgulas, exatamente como precisamos passar ao operador IN do código PIVOT TABLE. */

DECLARE @NomeColunas NVARCHAR(MAX) = ''

SELECT @NomeColunas += QUOTENAME(TRIM(DepartmentName)) + ','
FROM
	(SELECT DISTINCT 
		DepartmentName
	FROM DimEmployee) AS Aux

SET @NomeColunas = LEFT(@NomeColunas, LEN(@NomeColunas) -1)

-- PRINT @NomeColunas

SELECT * FROM
	(SELECT
		EmployeeKey,
		YEAR(HireDate) AS Ano,
		DATENAME(MM, HireDate) AS Mes,
		DepartmentName
	FROM
		DimEmployee) AS Dados
PIVOT (
	COUNT(EmployeeKey)
	FOR DepartmentName
	IN (@NomeColunas)
		) AS PivotTable
ORDER BY Ano, Mes

-- Só que não podemos simplesmente pegar a variável @NomeColunas e passar para o operador IN do código da nossa PIVOT TABLE, pois não é aceito. Veja que, se executarmos o código dessa forma, será retornado um erro.
