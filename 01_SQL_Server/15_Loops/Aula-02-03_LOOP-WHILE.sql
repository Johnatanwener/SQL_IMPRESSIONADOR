-- M�DULO 15 - SQL SERVER - LOOPS NO SQL

/* AULA 02 - LOOP WHILE - Estrutura B�sica
Imagine que a gente queira criar um contador, de 1 at� 10, que printasse na tela a seguinte mensagem: 
'O valor do contador �: ...'

Poderiamos criar uma estrutura em Loop para executar o comando repetidas vezes, da forma como fizemos no exemplo abaixo. Iniciamos com uma variv�vel chamada @vContador = 1, e a nossa condi��o WHILE � executar o PRINT enquanto o valor de @vContador for menor ou igual a 10.
Observe que criamos uma linha para incrementar esta vari�vel cada vez que finalizamos um Loop (SET @vContador = @vContador + 1)
Desta forma, em algum momento, a condi��o @vContador n�o ser� mais satisfeita e consequentemente o WHILE ser� finalizado.

Crie um contador que fa�a uma contagem de 1 at� 10 utilizando a estrutura de repeti��o WHILE */
DECLARE @varContador INT
SET @varContador = 1

WHILE @varContador <= 10
BEGIN
	PRINT 'O valor do contador �: ' + CONVERT(VARCHAR, @varContador)
	SET @varContador = @varContador + 1
END

------------------------------

-- AULA 03 - LOOP WHILE - Cuidado com loops infinitos 

DECLARE @varContador2 INT
SET @varContador2 = 1

/*WHILE @varContador2 <= 5
BEGIN
	PRINT 'Algu�m pare esse contador!!!'
END */

WHILE @varContador2 <= 5
BEGIN
	PRINT @varContador2
	SET @varContador2 = @varContador2 + 1
END