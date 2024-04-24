-- M�DULO 25 - SQL SERVER - PIVOT TABLE


/* AULA 07-08 - Limita��es de uma Pivot Table e Corrigindo a limita��o da Pivot Table de forma din�mica
Inicialmente, precisamos encontrar uma forma din�mica de pegar os nomes de todos os departamentos da coluna DepartmentName da tabela dimEmployee e armazen�-los em uma vari�vel, em formato de string (texto). Para isso, faremos o seguinte:

- 1. Vamos declarar uma vari�vel que receber� os nomes de todos os departamentos: @NomeColunas do tipo NVARCHAR;
- 2. Depois, faremos um SELECT que retornar� a vari�vel @NomeColunas para que ela v� recebendo departamento distinto por departamento distinto e v� armazenando, um a um, seguido de uma v�rgula concatenada.
- 3. Repare que, aqui, utilizamos uma subquery para retornar os departamentos distintos da coluna DeparmentName da tabela dimEmployee e a utilizamos como a tabela da nossa consulta principal.
- 4. Por fim, vamos retirar a �ltima v�rgula concatenada ap�s o �ltimo departamento armazenado na vari�vel @NomeColunas. Para isso, basta utilizarmos a fun��o LEFT.

- Se fizermos um PRINT a vari�vel @NomeColunas, repare que ser� retornada uma string com os nomes de todos os departamentos entre colchetes, separados por v�rgulas, exatamente como precisamos passar ao operador IN do c�digo PIVOT TABLE. */

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

-- S� que n�o podemos simplesmente pegar a vari�vel @NomeColunas e passar para o operador IN do c�digo da nossa PIVOT TABLE, pois n�o � aceito. Veja que, se executarmos o c�digo dessa forma, ser� retornado um erro.
