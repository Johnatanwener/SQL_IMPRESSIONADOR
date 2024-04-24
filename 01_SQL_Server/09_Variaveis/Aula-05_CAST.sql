-- MÓDULO 09 - SQL SERVER - VARIÁVEIS


/* AULA 05 - CAST - ESPECIFICANDO O TIPO DE UM DADO
A função CAST nos permite especificar o tipo de um dado.

1) CAST: Função para especificar o tipo dos valores.
int: inteiro, float: decimal, varchar: string/texto, datetime: data e hora */

SELECT SQL_VARIANT_PROPERTY('31/05/2014', 'BaseType')
SELECT SQL_VARIANT_PROPERTY(CAST('31/05/2014' AS DATETIME), 'BaseType') -- Força o SQL a converter o valor no tipo de dado que deseja.


SELECT CAST(21.45 AS INT)

SELECT CAST(21.45 AS FLOAT)

SELECT CAST(18.7 AS VARCHAR)

SELECT CAST('15.6' AS FLOAT)

SELECT CAST('31/05/2014' AS DATETIME)

-- Exercício 1: Crie uma consulta juntanto o texto 'O preço do PASTEL é: ' com o valor 30.99

SELECT 'O preço do PASTEL é 30.99'
SELECT 'O preço do PASTEL: ' + 30.99 -- Desta forma será retornado um erro, pois estou tentando juntar um texto com um número.
SELECT 'O preço do PASTEL: ' + CAST(30.99 AS VARCHAR(50)) -- Desta forma eu estarei forçando o SQL a entender o valor 30.99 como um VARCHAR, assim não será retornado o erro anterior.

-- Exercício 2: Adicione 1 dia à data '20/06/2021'

SELECT '20/06/2021' + 1 -- Será retornado um erro pois desta forma o SQL entende a 'data' como um texto VARCHAR.
SELECT CAST('20/06/2021' AS DATETIME) + 1 -- Desta forma eu estou forçando o SQL entender a 'data' como um DATETIME e desta forma não será retornado o erro anterior.
