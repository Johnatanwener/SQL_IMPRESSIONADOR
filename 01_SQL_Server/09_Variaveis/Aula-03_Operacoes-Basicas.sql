-- M�DULO 09 - SQL SERVER - VARI�VEIS


-- AULA 03 - OPERA��ES B�SICAS 
SELECT 10 AS 'N�mero'
SELECT 'Johnatan' AS 'Nome'
SELECT '27/03/2024' AS 'Data'

-- Opera��es com N�meros
SELECT 10+20 AS 'Soma'
SELECT 20-5 AS 'Subtra��o'
SELECT 31*40 AS 'Multiplica��o'
SELECT 431/23 AS 'Divis�o INTEIRA' -- Retorna somente a parte inteira da divis�o
SELECT 431.0/23 AS 'Divis�o ' -- Retorna a divis�o completa (INT + FLOAT)

-- Opera��es com Texto
SELECT 'SQL' + ' ' + 'Impressionador' AS 'Curso',
'Johnatan' + ' ' + 'Wener' AS 'Aluno'

-- Opera��es com Datas
SELECT '20/06/2021' + 1 -- Neste caso ocorrer� um erro pois o SQL entender� a 'data' como um VARCHAR (caractere) e n�o como Data