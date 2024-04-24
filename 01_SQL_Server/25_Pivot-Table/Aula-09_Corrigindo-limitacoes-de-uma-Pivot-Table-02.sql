-- MÓDULO 25 - SQL SERVER - PIVOT TABLE


/* AULA 09 - Corrigindo a limitação da PIVOT TABLE de forma dinâmica (Parte 2)
Para que o nosso código da PIVOT TABLE funcione, vamos ter que conseguir transformar o próprio código (da PIVOT TABLE) em uma string (texto) para poder concatená-lo com a variável @NomeColunas, e armazenar tudo isso em uma outra variável, que vamos chamar de @SQL. 
Para isso, vamos ter que, inicialmente, declarar essa variável: */

DECLARE @NomeColunas NVARCHAR(MAX) = ''
DECLARE @SQL NVARCHAR(MAX) = ''

SELECT @NomeColunas += QUOTENAME(TRIM(DepartmentName)) + ','
FROM
	(SELECT DISTINCT 
		DepartmentName
	FROM DimEmployee) AS Aux

SET @NomeColunas = LEFT(@NomeColunas, LEN(@NomeColunas) -1)

-- PRINT @NomeColunas

-- Feito isso, precisamos armazenar na variável @SQL essa concatenação que mencionamos anteriormente. Repare que, colocando o código da PIVOT TABLE entre aspas simples, o concatenamos com a variável @NomeColunas utilizando os sinais de +:

-- Agora, se dermos um PRINT na variável @SQL veremos que o texto retornado na mensagem é exatamente o código que rpecisamos executar para mostrar nossa PIVOT TABLE na tela:

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

-- Agora temos o nosso código em formato de texto armazenado dentro da variável @SQL. Para executá-lo, vamos passar a variável @SQL como parâmetro a uma procedure do sistema chamada sp_executesql, dessa forma:

EXECUTE sp_executesql @SQL

-- Executando todo o código (desde a declaração das variáveis, até o EXECUTE da procedure sp_executesql) teremos, finalmente, nossa PIVOT TABLE.

-- Agora nosso código está totalmente dinâmico. Assim, caso seja alterada qualquer informação da tabela dimEmployee, seja em sua estrutura, sejam nos dados armazenados, tudo será automaticamente atualizado toda vez que executarmos o código que criamos. Dessa forma, teremos nossa PIVOT TABLE sempre atualizada.