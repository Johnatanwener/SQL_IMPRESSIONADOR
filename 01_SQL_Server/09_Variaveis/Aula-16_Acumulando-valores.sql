-- MÓDULO 09 - SQL SERVER - VARIÁVEIS


/* AULA 16 - ACUMULANDO VALORES DENTRO DE UMA VARIÁVEL
Variáveis também podem acumular mais de um valor de uma vez.

Exemplo 1: Retorne uma lista com os nomes das funcionárias do departamento de Marketing. */

-- Maneira mais simples
SELECT
	FirstName,
	DepartmentName
FROM
	DimEmployee
WHERE DepartmentName = 'Marketing' AND Gender = 'F'

-- E se eu quisesse printar na aba de Mensagens qual é o nome das funcionárias do departamento de Marketing?
DECLARE @varListaNomes VARCHAR(MAX)
SET @varListaNomes = ''

SELECT
	@varListaNomes = @varListaNomes + FirstName + ', ' + CHAR(10)
FROM
	DimEmployee
WHERE DepartmentName = 'Marketing' AND Gender = 'F'

PRINT LEFT(@varListaNomes, DATALENGTH(@varListaNomes) - 3)


