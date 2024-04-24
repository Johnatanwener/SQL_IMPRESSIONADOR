-- M�DULO 25 - SQL SERVER - PIVOT TABLE


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