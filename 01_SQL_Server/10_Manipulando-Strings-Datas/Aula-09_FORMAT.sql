-- M�DULO 10 - SQL SERVER - Manipulando Strings e Datas


/* AULA 09 - FORMAT
A fun��o FORMAT � uma fun��o muito �til para realizar formata��es personalizadas em nossas consultas.

Essa fun��o nos pede 2 argumentos:
1. Valor a ser formatado
2. C�digo de formata��o
*/

-- 1. Formata��o de N�mero
-- 5123
SELECT FORMAT(5123, 'G') AS 'Geral' -- Formata��o Geral
SELECT FORMAT(5123, 'N') AS 'N�mero' -- Formata��o N�mero
SELECT FORMAT(5123, 'C') AS 'Moeda' -- Formata��o Moeda

-- 2. Formata��o de Data
-- 01/04/2024
SELECT FORMAT(CAST('01/04/2024' AS DATETIME), 'dd/MM/yyyy') -- Formata��o completa
SELECT FORMAT(CAST('01/04/2024' AS DATETIME), 'dd/MMM/yyyy', 'en-US') -- De acordo com o idioma
SELECT FORMAT(CAST('01/04/2024' AS DATETIME), 'dd') -- dia
SELECT FORMAT(CAST('01/04/2024' AS DATETIME), 'MM') -- m�s
SELECT FORMAT(CAST('01/04/2024' AS DATETIME), 'yy') -- ano

-- 3. Formata��o Personalizada
-- 1234567 --> 12-34-567
SELECT FORMAT(1234567, '##-##-###')

-- Formatar as colunas de Data de Nascimento e Renda Anual da tabela DimCustomer, de acordo com as formata��es aprendidas.
SELECT
	FirstName AS 'Nome',
	BirthDate AS 'Data de Nascimento',
	FORMAT(BirthDate, 'dd/MMMM/yyyy') AS 'Data Formatada',
	YearlyIncome AS 'Renda Anual',
	FORMAT(YearlyIncome, 'C') AS 'Renda Anual Formatada'
FROM
	DimCustomer