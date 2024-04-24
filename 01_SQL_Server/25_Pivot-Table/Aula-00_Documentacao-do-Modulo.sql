-- MÓDULO 25 - SQL SERVER - PIVOT TABLE

/* AULA 01 - Introdução
Nesse módulo vamos aprender sobre Pivot Table no SQL

- O que é uma Pivot Table
- Criando uma Pivot Table
- Grupos de Linhas em Pivot Tables
- Grupos de Linhas e Colunas em Pivot Tables
- Limitações de uma Pivot Table
- Corrigindo Limitações de uma Pivot Table		*/

------------------------------

/* AULA 02 - O que são Pivot Tables

 A PIVOT TABLE é uma tabela criada apartir da inversão de uma outra tabela.

 Basicamente, com o uso do operador PIVOT, conseguimos transformar o que eram linhas de uma tabela em colunas da PIVOT TABLE, ao passo que as colunas de outra tabela se transformam nas linhas da PIVOT TABLE. */

------------------------------

/* AULA 03 - Criando uma Pivot Table
Para conseguir criar uma PIVOT TABLE das colunas BrandName e Contagem de Produtos da tabela DimProduct precisamos primeiro efetuar uma consulta à tabela DimProduct */

SELECT
	BrandName,
	COUNT(ProductKey) AS Total_Produtos
FROM
	DimProduct
GROUP BY BrandName

/* Depois, para criarmos a PIVOT TABLE, precisamos executar o código abaixo:

Repare que, precisamos de uma subquery para ser utilizada como tabela da nossa consulta principal. Nesta subquery: 
- 1. Fazemos uma consulta às colunas dos dados que queremos ver na PIVOT TABLE: BrandName e ProductKey.
- 2. Incluímos o operador PIVOT e passamos as informações necessárias para ele, que são:
- 3. O cálculo que desejamos efetuar (uma contagem da quantidade de produtos): COUNT(ProductKey);
- 4. Para qual coluna devemos agrupar nossa PIVOT TABLE: Neste caso, se queremos uma contagem da quantidade de produtos por marca, devemos agrupar pela coluna BrandName. Então, incluímos a linha FOR BrandName.
- 5. Para o operador IN, passamos os nomes de todas as marcas (BrandName) que servirão de colunas para a nossa PIVOT TABLE. Repare que cada marca precisa estar entre colchetes [], separados por vírgulas. */

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

-- 1º) O primeiro passo é selecionar os dados que serão usados como base para criação da Pivot Table
-- 2º) Como não conseguimos aplicar o Pivot diretamente nos dados acima, precisaremos fazer isso indiretamente
-- 3º) Agora sim podemos aplicar o Pivot, incluindo o cálculo desejado e os nomes das colunas a serem consideradas

------------------------------

/* AULA 04 - Adicionando Grupos de Linha à Pivot Table
Para conseguir criar uma PIVOT TABLE das colunas DepartmentName e Contagem de funcionarios da tabela DimEmployee precisamos primeiro efetuar uma consulta à tabela DimEmployee */

-- Calculando o total de funcionários por departamento
SELECT
	DepartmentName,
	COUNT(EmployeeKey) Total_Funcionarios
FROM DimEmployee
GROUP BY DepartmentName

/* Depois, para criarmos a PIVOT TABLE, precisamos executar o código abaixo:

Repare que, precisamos de uma subquery para ser utilizada como tabela da nossa consulta principal. Nesta subquery: 
- 1. Fazemos uma consulta às colunas dos dados que queremos ver na PIVOT TABLE: EmployeeKey e DepartmentNamey.
- 2. Incluímos o operador PIVOT e passamos as informações necessárias para ele, que são:
- 3. O cálculo que desejamos efetuar (uma contagem da quantidade de funcionários): COUNT(EmployeeKey);
- 4. Para qual coluna devemos agrupar nossa PIVOT TABLE: Neste caso, se queremos uma contagem da quantidade de funcionários por departamento, devemos agrupar pela coluna DepartmentName. Então, incluímos a linha FOR DepartmentName.
- 5. Para o operador IN, passamos os nomes de todas os departamentos (DepartmentName) que servirão de colunas para a nossa PIVOT TABLE. Repare que cada marca precisa estar entre colchetes [], separados por vírgulas. */ 

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

/* - Para não precisarmos digitar departamento por departamento nesta parte, existem algumas formas de conseguir obtê-los diretamente da coluna DepartmentName.

Exemplo: Fazendo o SELECT abaixo, obteremos o nome de todos os departamentos, concatenados com vírgulas e dentro de colchetes [] a partir da função QUOTENAME, e utilizamos a função TRIM para que os nomes dos departamentos estejam sem espaços no início ou no fim. Desse modo, nosso resultado já vem praticamente pronto, pois é exatamente o que precisamos passar para o operador IN no nosso PIVOT. Basta selecionarmos toda a tabela, copiar e colar o resultado dentro dos parênteses do operador IN. E então apenas remover a vírgula que aparece na frente do primeiro departamento. */

SELECT DISTINCT ',' + QUOTENAME(TRIM(DepartmentName)) FROM DimEmployee

------------------------------

/* AULA 05 - Adicionando e Ordenando Linhas e Colunas de uma Pivot Table
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

------------------------------

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

-- Só que não podemos simplesmente pegar a variável @NomeColunas e passar para o operador IN do código da nossa PIVOT TABLE, pois não é aceito. Veja que, se executarmos o código dessa forma, será retornado um erro.

------------------------------

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