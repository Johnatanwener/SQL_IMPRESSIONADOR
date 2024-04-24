-- MÓDULO 09 - SQL SERVER - VARIÁVEIS


/* AULA 07 - ROUND, FLOOR e CEILING - FUNÇÕES DE ARREDONDAMENTO
Existem algumas funções muito úteis para arredondamento de valores: ROUND, FLOOR e CEILING.

Essas funções são bem intuitivas:

- ROUND: Arredonda um valor com uma quantidade de casas decimais.
- FLOOR: Arredonda um valor para baixo, ou seja, para um número inteiro.
- CEILING: Arredonda um valor para cima, ou seja, para um número inteiro acima. 

Obs.: A função ROUND possui uma aplicação além de apenas arredondar um valor de acordo com um número de casas decimais. Na aplicação 2 (logo abaixo) utilizamos um terceiro argumento (número 1) para informar que o que queremos na verdade não é arredondar, mas sim cortar o número na segunda casa decimal. Então em vez do valor ficar 18.74 (arredondado), ele ficará 18.73. */

-- Operações com números
SELECT 10+20
SELECT 20-5
SELECT 31*40
SELECT 431.0/23

-- ROUND
SELECT ROUND(18.739130, 2)

-- ROUND (Truncar)
SELECT ROUND(18.739130, 2, 1)

-- FLOOR
SELECT FLOOR(18.739130)

-- CEILING
SELECT CEILING(18.739130)