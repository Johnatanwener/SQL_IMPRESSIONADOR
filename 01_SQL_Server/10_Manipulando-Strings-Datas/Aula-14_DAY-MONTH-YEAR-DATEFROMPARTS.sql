-- M�DULO 10 - SQL SERVER - Manipulando Strings e Datas


/* AULA 14 - DAY, MONTH, YEAR e DATEFROMPARTS
As fun��es DAY, MONTH e YEAR s�o fun��es que nos permitem descobrir o dia, m�s e o ano de uma data. 
A fun��o DATEFROMPARTS � uma fun��o que nos permite retornar uma data completa a partir das informa��es separadas de dia, m�s e ano.	  */

-- Utilize as fun��es DAY, MONTH e YEAR para descobrir o dia, m�s e ano da data: 18/05/2020
DECLARE @varData DATETIME
SET @varData = '23/02/2020'

SELECT
	DAY(@varData) AS 'Dia',
	MONTH(@varData) AS 'M�s',
	YEAR(@varData) AS 'Ano'


-- Utilize a fun��o DATEFROMPARTS para obter uma data a partir das informa��es de dia, m�s e ano
DECLARE @varDia INT, @varMes INT, @varAno INT
SET @varDia = 30
SET @varMes = 08
SET @varAno = 2022

SELECT
	DATEFROMPARTS(@varAno, @varMes, @varDia) AS 'Data'