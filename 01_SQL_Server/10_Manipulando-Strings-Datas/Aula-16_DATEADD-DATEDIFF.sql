-- M�DULO 10 - SQL SERVER - Manipulando Strings e Datas


/* AULA 16 - DATEADD e DATEDIFF
AS fun��es DATEADD e DATEDIFF s�o fun��es que nos permitem realizar c�lculos com datas.

A fun��o DATEADD adiciona ou subtrai uma determinada quantidade de dias, meses ou anos de uma data. Essa fun��o nos pede 3 argumentos.
1. Intervalo de tempo que queremos considerar (dia, m�s, ano).
2. Quantidade de intervalos que queremos considerar.
3. Data na qual vamos adicionar ou subtrair os intervalos.

J� a fun��o DATEDIFF permite o c�lculo da diferen�a entre duas datas. Essa fun��o nos pede 3 argumentos.
1. Intervalo de tempo que queremos subtrair (dia, m�s, ano)
2. Data 1 a ser considerada no c�lculo)
3. Data 2 a ser considerada no c�lculo)
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