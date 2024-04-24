-- MÓDULO 09 - SQL SERVER - VARIÁVEIS


/* AULA 04 - SQL_VARIANT_PROPERTY - IDENTIFICANDO O TIPO DE DADO
O comando SQL_VARIANT_PROPERTY é muito útil para se descobrir o tipo dos dados. 
Essa função nos pede dois argumentos: o primeiro argumento é o dado que queremos descobrir o tipo, e o segundo argumento é a informação que queremos: BaseType, ou seja, o tipo do dado. */

SELECT 10 AS 'Número'
SELECT 49.50 AS 'Decimal'
SELECT 'Marcus' AS 'Nome'
SELECT '20/06/2021' AS 'Data'

SELECT SQL_VARIANT_PROPERTY(10, 'BaseType')
SELECT SQL_VARIANT_PROPERTY(49.50, 'BaseType')
SELECT SQL_VARIANT_PROPERTY('Johnatan', 'BaseType')
SELECT SQL_VARIANT_PROPERTY('20/06/2021', 'BaseType') -- Quando declaramos uma data neste formato e entre aspas simples o SQL entenderá que isto é um texto.