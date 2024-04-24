-- MÓDULO 10 - SQL SERVER - Manipulando Strings e Datas


/* AULA 14 - DAY, MONTH, YEAR e DATEFROMPARTS
As funções DAY, MONTH e YEAR são funções que nos permitem descobrir o dia, mês e o ano de uma data. 
A função DATEFROMPARTS é uma função que nos permite retornar uma data completa a partir das informações separadas de dia, mês e ano.	  */

-- Utilize as funções DAY, MONTH e YEAR para descobrir o dia, mês e ano da data: 18/05/2020
DECLARE @varData DATETIME
SET @varData = '23/02/2020'

SELECT
	DAY(@varData) AS 'Dia',
	MONTH(@varData) AS 'Mês',
	YEAR(@varData) AS 'Ano'


-- Utilize a função DATEFROMPARTS para obter uma data a partir das informações de dia, mês e ano
DECLARE @varDia INT, @varMes INT, @varAno INT
SET @varDia = 30
SET @varMes = 08
SET @varAno = 2022

SELECT
	DATEFROMPARTS(@varAno, @varMes, @varDia) AS 'Data'