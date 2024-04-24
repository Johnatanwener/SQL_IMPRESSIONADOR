-- M�DULO 25 - SQL SERVER - PIVOT TABLE

/* AULA 01 - Introdu��o
Nesse m�dulo vamos aprender sobre Pivot Table no SQL

- O que � uma Pivot Table
- Criando uma Pivot Table
- Grupos de Linhas em Pivot Tables
- Grupos de Linhas e Colunas em Pivot Tables
- Limita��es de uma Pivot Table
- Corrigindo Limita��es de uma Pivot Table		*/

------------------------------

/* AULA 02 - O que s�o Pivot Tables

 A PIVOT TABLE � uma tabela criada apartir da invers�o de uma outra tabela.

 Basicamente, com o uso do operador PIVOT, conseguimos transformar o que eram linhas de uma tabela em colunas da PIVOT TABLE, ao passo que as colunas de outra tabela se transformam nas linhas da PIVOT TABLE. */

------------------------------

/* AULA 03 - Criando uma Pivot Table
Para conseguir criar uma PIVOT TABLE das colunas BrandName e Contagem de Produtos da tabela DimProduct precisamos primeiro efetuar uma consulta � tabela DimProduct */

SELECT
	BrandName,
	COUNT(ProductKey) AS Total_Produtos
FROM
	DimProduct
GROUP BY BrandName

/* Depois, para criarmos a PIVOT TABLE, precisamos executar o c�digo abaixo:

Repare que, precisamos de uma subquery para ser utilizada como tabela da nossa consulta principal. Nesta subquery: 
- 1. Fazemos uma consulta �s colunas dos dados que queremos ver na PIVOT TABLE: BrandName e ProductKey.
- 2. Inclu�mos o operador PIVOT e passamos as informa��es necess�rias para ele, que s�o:
- 3. O c�lculo que desejamos efetuar (uma contagem da quantidade de produtos): COUNT(ProductKey);
- 4. Para qual coluna devemos agrupar nossa PIVOT TABLE: Neste caso, se queremos uma contagem da quantidade de produtos por marca, devemos agrupar pela coluna BrandName. Ent�o, inclu�mos a linha FOR BrandName.
- 5. Para o operador IN, passamos os nomes de todas as marcas (BrandName) que servir�o de colunas para a nossa PIVOT TABLE. Repare que cada marca precisa estar entre colchetes [], separados por v�rgulas. */

SELECT * FROM
(SELECT
	ProductKey,
	BrandName
FROM DimProduct) AS Daddos
PIVOT(
	COUNT(ProductKey)
	FOR BrandName
	IN ([Northwind Traders]
		,[Contoso]
		,[Tailspin Toys]
		,[Adventure Works]
		,[Southridge Video]
		,[Wide World Importers]
		,[The Phone Company]
		,[Fabrikam]
		,[Litware]
		,[A. Datum]
		,[Proseware]
	)
) AS PivotTable

SELECT DISTINCT ',[' + TRIM(BrandName) + ']' FROM DimProduct

-- 1�) O primeiro passo � selecionar os dados que ser�o usados como base para cria��o da Pivot Table
-- 2�) Como n�o conseguimos aplicar o Pivot diretamente nos dados acima, precisaremos fazer isso indiretamente
-- 3�) Agora sim podemos aplicar o Pivot, incluindo o c�lculo desejado e os nomes das colunas a serem consideradas

------------------------------

/* AULA 04 - Adicionando Grupos de Linha � Pivot Table
Para conseguir criar uma PIVOT TABLE das colunas DepartmentName e Contagem de funcionarios da tabela DimEmployee precisamos primeiro efetuar uma consulta � tabela DimEmployee */

-- Calculando o total de funcion�rios por departamento
SELECT
	DepartmentName,
	COUNT(EmployeeKey) Total_Funcionarios
FROM DimEmployee
GROUP BY DepartmentName

/* Depois, para criarmos a PIVOT TABLE, precisamos executar o c�digo abaixo:

Repare que, precisamos de uma subquery para ser utilizada como tabela da nossa consulta principal. Nesta subquery: 
- 1. Fazemos uma consulta �s colunas dos dados que queremos ver na PIVOT TABLE: EmployeeKey e DepartmentNamey.
- 2. Inclu�mos o operador PIVOT e passamos as informa��es necess�rias para ele, que s�o:
- 3. O c�lculo que desejamos efetuar (uma contagem da quantidade de funcion�rios): COUNT(EmployeeKey);
- 4. Para qual coluna devemos agrupar nossa PIVOT TABLE: Neste caso, se queremos uma contagem da quantidade de funcion�rios por departamento, devemos agrupar pela coluna DepartmentName. Ent�o, inclu�mos a linha FOR DepartmentName.
- 5. Para o operador IN, passamos os nomes de todas os departamentos (DepartmentName) que servir�o de colunas para a nossa PIVOT TABLE. Repare que cada marca precisa estar entre colchetes [], separados por v�rgulas. */ 

SELECT * FROM
(SELECT
	EmployeeKey,
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

/* - Para n�o precisarmos digitar departamento por departamento nesta parte, existem algumas formas de conseguir obt�-los diretamente da coluna DepartmentName.

Exemplo: Fazendo o SELECT abaixo, obteremos o nome de todos os departamentos, concatenados com v�rgulas e dentro de colchetes [] a partir da fun��o QUOTENAME, e utilizamos a fun��o TRIM para que os nomes dos departamentos estejam sem espa�os no in�cio ou no fim. Desse modo, nosso resultado j� vem praticamente pronto, pois � exatamente o que precisamos passar para o operador IN no nosso PIVOT. Basta selecionarmos toda a tabela, copiar e colar o resultado dentro dos par�nteses do operador IN. E ent�o apenas remover a v�rgula que aparece na frente do primeiro departamento. */

SELECT DISTINCT ',' + QUOTENAME(TRIM(DepartmentName)) FROM DimEmployee

------------------------------

/* AULA 05 - Adicionando e Ordenando Linhas e Colunas de uma Pivot Table
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

------------------------------

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
		MONTH(HireDate) AS Mes,
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

------------------------------

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