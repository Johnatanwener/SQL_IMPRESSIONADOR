-- MÓDULO 10 - SQL SERVER - Manipulando Strings e Datas


/* AULA 15 - GETDATE, SYSDATETIME, DATEPART e DATENAME
As funções GETDATE e SYSDATETIME nos permitem retornar a data e hora atual do sistema. A diferença entre elas é que a SYSDATETIME tem uma maior precisão em relação à GETDATE.

GETDATE: Retorna a data/hora atual do sistema
SYSDATETIME: Retorna a data/hora atual do sistema (mais preciso que a GETDATE)

As funções DATENAME e DATEPART nos retornam informações de uma data, como o dia, mês, ano, trimestre, e assim vai. As duas são usadas da mesma forma, com 2 argumentos:
1. Informação que queremos da data
2. Data
*/

SELECT GETDATE()
SELECT SYSDATETIME()

-- DATENAME: Retorna o resultado em formato de TEXTO
DECLARE @varData0 DATETIME
SET @varData0 = GETDATE()
SELECT
	DATENAME(DAY, @varData0) AS 'Dia',
	DATENAME(MONTH, @varData0) AS 'Mês',
	DATENAME(YEAR, @varData0) AS 'Ano',
	DATENAME(DW, @varData0) AS 'Dia da Semana',
	DATENAME(DAYOFYEAR, @varData0) AS 'Dia do ano'

-- DATEPART: Retorna o resultado em formato de NÚMERO
SELECT
	DATEPART(DAY, @varData0) AS 'Dia',
	DATEPART(MONTH, @varData0) AS 'Mês',
	DATEPART(YEAR, @varData0) AS 'Ano',
	DATEPART(DAYOFYEAR, @varData0) AS 'Dia do ano'

SELECT
	SQL_VARIANT_PROPERTY(DATENAME(DAY, @varData0), 'BaseType'),
	SQL_VARIANT_PROPERTY(DATEPART(DAY, @varData0), 'BaseType')