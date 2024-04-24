-- MÓDULO 10 - SQL SERVER - Manipulando Strings e Datas


/* AULA 08 - UPPER e LOWER
As funções UPPER e LOWER são bastante intuitivas e nos permitem ajustar as palavras para que fiquem em letras maiúsculas e minúsculas.

UPPER transforma um texto em maiúscula
LOWER transforma um texto em minúscula */

-- Exemplo: Faça uma consulta à tabela DimCustomer e utilize as funções UPPER e LOWER na coluna de FirstName para observar o resultado
SELECT 
	FirstName AS 'Nome',
	UPPER(FirstName) AS 'NOME',
	LOWER(FirstName) AS 'nome',
	EmailAddress AS 'E-mail'
FROM
		DimCustomer
