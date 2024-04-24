-- MÓDULO 15 - SQL SERVER - LOOPS NO SQL

/* AULA 05 - CONTINUE - Pulando repetições em um loop
O comando CONTINUE pode ser usado para pular repetições em um loop. Ou seja, cada vez que uma condição mais interna ao loop é atentida o loop não é executado, mas continua acontecendo até que a condição do WHILE seja atendida.

No exemplo ao lado, temos um contador que deve contar até 10 (WHILE @varContador <= 10). Porém, no meio do código, testamos dois números em particular: 3 e 6. Ou seja, sempre que @varContador for igual a 3 ou @varContador for igual a 6, o comando PRINT é pulado, porém, a contagem se mantém funcionando até que @varContador seja igual a 10.

Faça um contador de 1 à 10. 
Obs.: Porém, os números 3 ou 6 não podem ser printados na tela */

DECLARE @varContador4 INT
SET @varContador4 = 0

WHILE @varContador4 < 10
BEGIN
	SET @varContador4 += 1
	IF @varContador4 = 3 OR @varContador4 = 6
	CONTINUE
	PRINT 'O valor da variável é: ' + CONVERT(VARCHAR, @varContador4)
END
