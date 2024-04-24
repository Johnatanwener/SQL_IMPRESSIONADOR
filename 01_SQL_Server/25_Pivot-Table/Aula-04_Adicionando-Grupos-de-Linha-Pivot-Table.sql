-- MÓDULO 25 - SQL SERVER - PIVOT TABLE


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