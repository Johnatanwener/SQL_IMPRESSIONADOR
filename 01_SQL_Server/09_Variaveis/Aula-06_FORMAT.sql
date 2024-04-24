-- MÓDULO 09 - SQL SERVER - VARIÁVEIS


/* AULA 06 - FORMAT - FORMATAÇÃO DE DADOS PERSONALIZADA
A função FORMAT nos permite formatar um valor a partir de um determinado código de formatação. */

-- Estrtura FORMAT: SELECT FORMAT(valor, formato)

-- a) Numéricos:
SELECT FORMAT(1000, 'N') -- É retornado o valor númerico 1.000.00 com o separador/formatação de milhar e decimal.
SELECT FORMAT(1000, 'G') -- È retornado o valor geral, sem o separador

-- b) Personalizados:
SELECT FORMAT(123456789, '###-##-####')

-- c) Data:
SELECT FORMAT('21/03/2021', 'dd/MM/yyy') -- O 'MM' tem que obrigatoriamente está em maiúsculo para o SQL entender que se trata de mês porém, neste caso ocorrerá um erro pois o SQL está reconhecendo a 'data' como um VARCHAR e não DATETIME
SELECT FORMAT(CAST('21/03/2021' AS DATETIME), 'dd/MM/yyyy')
SELECT FORMAT(CAST('21/03/2021' AS DATETIME), 'dd/MMM/yyyy') -- Se acrescentar mais 1 'M' o SQL retornará as três primeiras letras do mês
SELECT FORMAT(CAST('21/03/2021' AS DATETIME), 'dd/MMMM/yyyy') -- Se acrescentar mais um 'M' o SQL retornará o nome do mês

SELECT FORMAT(CAST('21/03/2021' AS DATETIME), 'ddd') -- Será retornado o dia da semana abreviado e acrescentando mais um 'd' será retornado o nome inteiro.

-- Exercício 3: Crie uma consulta juntando o texto 'A data de validade do produto é: ' com a data 17/abr/2022. obs: Você deverá usar o CAST para garantir que a data é entendida com o tipo DATETIME

SELECT 'A data de validade do produto é: ' + FORMAT(CAST('17/04/2022' AS DATETIME), 'dd/MMM/yyyy')