-- MÓDULO 15 - SQL SERVER - LOOPS NO SQL

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