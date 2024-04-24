-- M�DULO 09 - SQL SERVER - VARI�VEIS


/* AULA 16 - ACUMULANDO VALORES DENTRO DE UMA VARI�VEL
Vari�veis tamb�m podem acumular mais de um valor de uma vez.

Exemplo 1: Retorne uma lista com os nomes das funcion�rias do departamento de Marketing. */

-- Maneira mais simples
SELECT
	FirstName,
	DepartmentName
FROM
	DimEmployee
WHERE DepartmentName = 'Marketing' AND Gender = 'F'

-- E se eu quisesse printar na aba de Mensagens qual � o nome das funcion�rias do departamento de Marketing?
DECLARE @varListaNomes VARCHAR(MAX)
SET @varListaNomes = ''

SELECT
	@varListaNomes = @varListaNomes + FirstName + ', ' + CHAR(10)
FROM
	DimEmployee
WHERE DepartmentName = 'Marketing' AND Gender = 'F'

PRINT LEFT(@varListaNomes, DATALENGTH(@varListaNomes) - 3)


