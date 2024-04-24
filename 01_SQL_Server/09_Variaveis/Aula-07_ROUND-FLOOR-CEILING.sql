-- M�DULO 09 - SQL SERVER - VARI�VEIS


/* AULA 07 - ROUND, FLOOR e CEILING - FUN��ES DE ARREDONDAMENTO
Existem algumas fun��es muito �teis para arredondamento de valores: ROUND, FLOOR e CEILING.

Essas fun��es s�o bem intuitivas:

- ROUND: Arredonda um valor com uma quantidade de casas decimais.
- FLOOR: Arredonda um valor para baixo, ou seja, para um n�mero inteiro.
- CEILING: Arredonda um valor para cima, ou seja, para um n�mero inteiro acima. 

Obs.: A fun��o ROUND possui uma aplica��o al�m de apenas arredondar um valor de acordo com um n�mero de casas decimais. Na aplica��o 2 (logo abaixo) utilizamos um terceiro argumento (n�mero 1) para informar que o que queremos na verdade n�o � arredondar, mas sim cortar o n�mero na segunda casa decimal. Ent�o em vez do valor ficar 18.74 (arredondado), ele ficar� 18.73. */

-- Opera��es com n�meros
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