-- M�DULO 15 - SQL SERVER - LOOPS NO SQL

/* AULA 01 - Loops no SQL
Nesse m�dulo vamos aprender a criar estruturas de repeti��o no SQL

- WHILE
- BREAK
- CONTINUE 

WHILE LOOPS: Para que servem?
Um loop em uma linguagem de programa��o tem como objetivo excecutar repetidas vezes uma s�rie de comandos.
O While � uma estrutura de repeti��o que tem exatamente esse objetivo. Com ele, conseguimos executar diversas vezes um ou mais comandos, enquanto ume determinada condi��o � satisfeita. E a partir do momento que essa condi��o deixa de ser satisfeita, o loop finaliza. */

-- A Estrura WHILE no SQL � assim:

WHILE condi��o
BEGIN
	comandos

END

-- Ou seja, enquanto uma determinada condi��o � satisfeita, todos os comandos dentro do bloco BEGIN.. END ser�o executados.

------------------------------

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

-- AULA 03 - WHILE - Cuidado com loops infinitos 

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

------------------------------

/* AULA 04 - BREAK - Interrompendo um loop antes do final
Podemos utilizar o comando BREAK para finalizar um Loop assim que uma condi��o intermedi�ria for satisfeita. 

Observe no exemplo abaixo, onde desejamos que o Loop WHILE seja executado enquanto o valor da v�riavel @vContador for menor ou igual a 100. 
Por�m, se criarmos um teste IF para, a cada loop, verificar se o valor de @vContador � igual a 15. Caso seja, o loop � automaticamente interrompido e finalizado.

Fa�a um contador de 1 a 100. 
Obs.: Se o valor do contador for igual a 15, ent�o o loop WHILE deve ser encerrado. */

DECLARE @varContador3 INT
SET @varContador3 = 1

WHILE @varContador3 <= 100
BEGIN
	IF @varContador3 = 15
	BREAK
	PRINT 'O valor do contador �: ' + CONVERT(VARCHAR, @varContador3)
	SET @varContador3 = @varContador3 + 1
END

-- Se eu quiser printar o valor 15 tamb�m, � s� trazer a fun��o IF e BREAK para baixo
WHILE @varContador3 <= 100
BEGIN
	PRINT 'O valor do contador �: ' + CONVERT(VARCHAR, @varContador3)
	IF @varContador3 = 15
	BREAK
	SET @varContador3 = @varContador3 + 1
END
-- No SET para diminuir o comando eu poderia alterar (= @varContador3 + 1) por (+= 1)

------------------------------

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

------------------------------

-- AULA 06 - Explica��o Exerc�cios
-- AULA 07 - Resolu��o Exerc�cio 01
-- AULA 08 - Resolu��o Exerc�cio 02
-- AULA 09 - Resolu��o Exerc�cio 03