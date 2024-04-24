-- MÓDULO 09 - SQL SERVER - VARIÁVEIS


-- AULA 03 - OPERAÇÕES BÁSICAS 
SELECT 10 AS 'Número'
SELECT 'Johnatan' AS 'Nome'
SELECT '27/03/2024' AS 'Data'

-- Operações com Números
SELECT 10+20 AS 'Soma'
SELECT 20-5 AS 'Subtração'
SELECT 31*40 AS 'Multiplicação'
SELECT 431/23 AS 'Divisão INTEIRA' -- Retorna somente a parte inteira da divisão
SELECT 431.0/23 AS 'Divisão ' -- Retorna a divisão completa (INT + FLOAT)

-- Operações com Texto
SELECT 'SQL' + ' ' + 'Impressionador' AS 'Curso',
'Johnatan' + ' ' + 'Wener' AS 'Aluno'

-- Operações com Datas
SELECT '20/06/2021' + 1 -- Neste caso ocorrerá um erro pois o SQL entenderá a 'data' como um VARCHAR (caractere) e não como Data