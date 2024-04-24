-- M�DULO 09 - SQL SERVER - VARI�VEIS


/* AULA 06 - FORMAT - FORMATA��O DE DADOS PERSONALIZADA
A fun��o FORMAT nos permite formatar um valor a partir de um determinado c�digo de formata��o. */

-- Estrtura FORMAT: SELECT FORMAT(valor, formato)

-- a) Num�ricos:
SELECT FORMAT(1000, 'N') -- � retornado o valor n�merico 1.000.00 com o separador/formata��o de milhar e decimal.
SELECT FORMAT(1000, 'G') -- � retornado o valor geral, sem o separador

-- b) Personalizados:
SELECT FORMAT(123456789, '###-##-####')

-- c) Data:
SELECT FORMAT('21/03/2021', 'dd/MM/yyy') -- O 'MM' tem que obrigatoriamente est� em mai�sculo para o SQL entender que se trata de m�s por�m, neste caso ocorrer� um erro pois o SQL est� reconhecendo a 'data' como um VARCHAR e n�o DATETIME
SELECT FORMAT(CAST('21/03/2021' AS DATETIME), 'dd/MM/yyyy')
SELECT FORMAT(CAST('21/03/2021' AS DATETIME), 'dd/MMM/yyyy') -- Se acrescentar mais 1 'M' o SQL retornar� as tr�s primeiras letras do m�s
SELECT FORMAT(CAST('21/03/2021' AS DATETIME), 'dd/MMMM/yyyy') -- Se acrescentar mais um 'M' o SQL retornar� o nome do m�s

SELECT FORMAT(CAST('21/03/2021' AS DATETIME), 'ddd') -- Ser� retornado o dia da semana abreviado e acrescentando mais um 'd' ser� retornado o nome inteiro.

-- Exerc�cio 3: Crie uma consulta juntando o texto 'A data de validade do produto �: ' com a data 17/abr/2022. obs: Voc� dever� usar o CAST para garantir que a data � entendida com o tipo DATETIME

SELECT 'A data de validade do produto �: ' + FORMAT(CAST('17/04/2022' AS DATETIME), 'dd/MMM/yyyy')