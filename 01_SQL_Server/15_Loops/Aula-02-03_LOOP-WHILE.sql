-- MÓDULO 15 - SQL SERVER - LOOPS NO SQL

/* AULA 02 - LOOP WHILE - Estrutura Básica
Imagine que a gente queira criar um contador, de 1 até 10, que printasse na tela a seguinte mensagem: 
'O valor do contador é: ...'

Poderiamos criar uma estrutura em Loop para executar o comando repetidas vezes, da forma como fizemos no exemplo abaixo. Iniciamos com uma varivável chamada @vContador = 1, e a nossa condição WHILE é executar o PRINT enquanto o valor de @vContador for menor ou igual a 10.
Observe que criamos uma linha para incrementar esta variável cada vez que finalizamos um Loop (SET @vContador = @vContador + 1)
Desta forma, em algum momento, a condição @vContador não será mais satisfeita e consequentemente o WHILE será finalizado.

Crie um contador que faça uma contagem de 1 até 10 utilizando a estrutura de repetição WHILE */
DECLARE @varContador INT
SET @varContador = 1

WHILE @varContador <= 10
BEGIN
	PRINT 'O valor do contador é: ' + CONVERT(VARCHAR, @varContador)
	SET @varContador = @varContador + 1
END

------------------------------

-- AULA 03 - LOOP WHILE - Cuidado com loops infinitos 

DECLARE @varContador2 INT
SET @varContador2 = 1

/*WHILE @varContador2 <= 5
BEGIN
	PRINT 'Alguém pare esse contador!!!'
END */

WHILE @varContador2 <= 5
BEGIN
	PRINT @varContador2
	SET @varContador2 = @varContador2 + 1
END