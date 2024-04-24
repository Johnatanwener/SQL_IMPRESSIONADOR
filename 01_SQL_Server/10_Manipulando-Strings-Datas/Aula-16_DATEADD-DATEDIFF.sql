-- MÓDULO 10 - SQL SERVER - Manipulando Strings e Datas


/* AULA 16 - DATEADD e DATEDIFF
AS funções DATEADD e DATEDIFF são funções que nos permitem realizar cálculos com datas.

A função DATEADD adiciona ou subtrai uma determinada quantidade de dias, meses ou anos de uma data. Essa função nos pede 3 argumentos.
1. Intervalo de tempo que queremos considerar (dia, mês, ano).
2. Quantidade de intervalos que queremos considerar.
3. Data na qual vamos adicionar ou subtrair os intervalos.

Já a função DATEDIFF permite o cálculo da diferença entre duas datas. Essa função nos pede 3 argumentos.
1. Intervalo de tempo que queremos subtrair (dia, mês, ano)
2. Data 1 a ser considerada no cálculo)
3. Data 2 a ser considerada no cálculo)
*/

DECLARE @varData1 DATETIME, @varData2 DATETIME, @varData3 DATETIME
SET @varData1 = '10/07/2020'
SET @varData2 = '05/03/2020'
SET @varData3 = '14/11/2021'

-- DATEADD
SELECT
	DATEADD(DAY, 30, @varData1),
	DATEADD(QUARTER, 1, @varData1),
	DATEADD(MONTH, -1, @varData1)

-- DATEDIFF
SELECT
	DATEDIFF(DAY, @varData2, @varData3),
	DATEDIFF(WEEK, @varData2, @varData3),
	DATEDIFF(MONTH, @varData2, @varData3),
	DATEDIFF(YEAR, @varData2, @varData3)