-- M�DULO 25 - SQL SERVER - PIVOT TABLE


/* AULA 09 - Corrigindo a limita��o da PIVOT TABLE de forma din�mica (Parte 2)
Para que o nosso c�digo da PIVOT TABLE funcione, vamos ter que conseguir transformar o pr�prio c�digo (da PIVOT TABLE) em uma string (texto) para poder concaten�-lo com a vari�vel @NomeColunas, e armazenar tudo isso em uma outra vari�vel, que vamos chamar de @SQL. 
Para isso, vamos ter que, inicialmente, declarar essa vari�vel: */

DECLARE @NomeColunas NVARCHAR(MAX) = ''
DECLARE @SQL NVARCHAR(MAX) = ''

SELECT @NomeColunas += QUOTENAME(TRIM(DepartmentName)) + ','
FROM
	(SELECT DISTINCT 
		DepartmentName
	FROM DimEmployee) AS Aux

SET @NomeColunas = LEFT(@NomeColunas, LEN(@NomeColunas) -1)

-- PRINT @NomeColunas

-- Feito isso, precisamos armazenar na vari�vel @SQL essa concatena��o que mencionamos anteriormente. Repare que, colocando o c�digo da PIVOT TABLE entre aspas simples, o concatenamos com a vari�vel @NomeColunas utilizando os sinais de +:

-- Agora, se dermos um PRINT na vari�vel @SQL veremos que o texto retornado na mensagem � exatamente o c�digo que rpecisamos executar para mostrar nossa PIVOT TABLE na tela:

SET @SQL = 
'SELECT * FROM
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
	IN (' + @NomeColunas + ')
		) AS PivotTable
ORDER BY Ano'

-- PRINT @SQL

-- Agora temos o nosso c�digo em formato de texto armazenado dentro da vari�vel @SQL. Para execut�-lo, vamos passar a vari�vel @SQL como par�metro a uma procedure do sistema chamada sp_executesql, dessa forma:

EXECUTE sp_executesql @SQL

-- Executando todo o c�digo (desde a declara��o das vari�veis, at� o EXECUTE da procedure sp_executesql) teremos, finalmente, nossa PIVOT TABLE.

-- Agora nosso c�digo est� totalmente din�mico. Assim, caso seja alterada qualquer informa��o da tabela dimEmployee, seja em sua estrutura, sejam nos dados armazenados, tudo ser� automaticamente atualizado toda vez que executarmos o c�digo que criamos. Dessa forma, teremos nossa PIVOT TABLE sempre atualizada.