-- MÓDULO 15 - SQL SERVER - LOOPS NO SQL

/* AULA 01 - Loops no SQL
Nesse módulo vamos aprender a criar estruturas de repetição no SQL

- WHILE
- BREAK
- CONTINUE 

WHILE LOOPS: Para que servem?
Um loop em uma linguagem de programação tem como objetivo excecutar repetidas vezes uma série de comandos.
O While é uma estrutura de repetição que tem exatamente esse objetivo. Com ele, conseguimos executar diversas vezes um ou mais comandos, enquanto ume determinada condição é satisfeita. E a partir do momento que essa condição deixa de ser satisfeita, o loop finaliza. */

-- A Estrura WHILE no SQL é assim:

WHILE condição
BEGIN
	comandos

END

-- Ou seja, enquanto uma determinada condição é satisfeita, todos os comandos dentro do bloco BEGIN.. END serão executados.

------------------------------

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

-- AULA 03 - WHILE - Cuidado com loops infinitos 

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

------------------------------

/* AULA 04 - BREAK - Interrompendo um loop antes do final
Podemos utilizar o comando BREAK para finalizar um Loop assim que uma condição intermediária for satisfeita. 

Observe no exemplo abaixo, onde desejamos que o Loop WHILE seja executado enquanto o valor da váriavel @vContador for menor ou igual a 100. 
Porém, se criarmos um teste IF para, a cada loop, verificar se o valor de @vContador é igual a 15. Caso seja, o loop é automaticamente interrompido e finalizado.

Faça um contador de 1 a 100. 
Obs.: Se o valor do contador for igual a 15, então o loop WHILE deve ser encerrado. */

DECLARE @varContador3 INT
SET @varContador3 = 1

WHILE @varContador3 <= 100
BEGIN
	IF @varContador3 = 15
	BREAK
	PRINT 'O valor do contador é: ' + CONVERT(VARCHAR, @varContador3)
	SET @varContador3 = @varContador3 + 1
END

-- Se eu quiser printar o valor 15 também, é só trazer a função IF e BREAK para baixo
WHILE @varContador3 <= 100
BEGIN
	PRINT 'O valor do contador é: ' + CONVERT(VARCHAR, @varContador3)
	IF @varContador3 = 15
	BREAK
	SET @varContador3 = @varContador3 + 1
END
-- No SET para diminuir o comando eu poderia alterar (= @varContador3 + 1) por (+= 1)

------------------------------

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

------------------------------

-- AULA 06 - Explicação Exercícios
-- AULA 07 - Resolução Exercício 01
-- AULA 08 - Resolução Exercício 02
-- AULA 09 - Resolução Exercício 03