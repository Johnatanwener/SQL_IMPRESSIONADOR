-- M�DULO 15 - SQL SERVER - LOOPS NO SQL

/* AULA 05 - CONTINUE - Pulando repeti��es em um loop
O comando CONTINUE pode ser usado para pular repeti��es em um loop. Ou seja, cada vez que uma condi��o mais interna ao loop � atentida o loop n�o � executado, mas continua acontecendo at� que a condi��o do WHILE seja atendida.

No exemplo ao lado, temos um contador que deve contar at� 10 (WHILE @varContador <= 10). Por�m, no meio do c�digo, testamos dois n�meros em particular: 3 e 6. Ou seja, sempre que @varContador for igual a 3 ou @varContador for igual a 6, o comando PRINT � pulado, por�m, a contagem se mant�m funcionando at� que @varContador seja igual a 10.

Fa�a um contador de 1 � 10. 
Obs.: Por�m, os n�meros 3 ou 6 n�o podem ser printados na tela */

DECLARE @varContador4 INT
SET @varContador4 = 0

WHILE @varContador4 < 10
BEGIN
	SET @varContador4 += 1
	IF @varContador4 = 3 OR @varContador4 = 6
	CONTINUE
	PRINT 'O valor da vari�vel �: ' + CONVERT(VARCHAR, @varContador4)
END
