-- MÓDULO 10 - SQL SERVER - Manipulando Strings e Datas


/* AULA 09 - FORMAT
A função FORMAT é uma função muito útil para realizar formatações personalizadas em nossas consultas.

Essa função nos pede 2 argumentos:
1. Valor a ser formatado
2. Código de formatação
*/

-- 1. Formatação de Número
-- 5123
SELECT FORMAT(5123, 'G') AS 'Geral' -- Formatação Geral
SELECT FORMAT(5123, 'N') AS 'Número' -- Formatação Número
SELECT FORMAT(5123, 'C') AS 'Moeda' -- Formatação Moeda

-- 2. Formatação de Data
-- 01/04/2024
SELECT FORMAT(CAST('01/04/2024' AS DATETIME), 'dd/MM/yyyy') -- Formatação completa
SELECT FORMAT(CAST('01/04/2024' AS DATETIME), 'dd/MMM/yyyy', 'en-US') -- De acordo com o idioma
SELECT FORMAT(CAST('01/04/2024' AS DATETIME), 'dd') -- dia
SELECT FORMAT(CAST('01/04/2024' AS DATETIME), 'MM') -- mês
SELECT FORMAT(CAST('01/04/2024' AS DATETIME), 'yy') -- ano

-- 3. Formatação Personalizada
-- 1234567 --> 12-34-567
SELECT FORMAT(1234567, '##-##-###')

-- Formatar as colunas de Data de Nascimento e Renda Anual da tabela DimCustomer, de acordo com as formatações aprendidas.
SELECT
	FirstName AS 'Nome',
	BirthDate AS 'Data de Nascimento',
	FORMAT(BirthDate, 'dd/MMMM/yyyy') AS 'Data Formatada',
	YearlyIncome AS 'Renda Anual',
	FORMAT(YearlyIncome, 'C') AS 'Renda Anual Formatada'
FROM
	DimCustomer