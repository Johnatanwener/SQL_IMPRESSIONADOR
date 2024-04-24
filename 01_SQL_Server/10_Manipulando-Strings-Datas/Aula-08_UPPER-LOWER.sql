-- M�DULO 10 - SQL SERVER - Manipulando Strings e Datas


/* AULA 08 - UPPER e LOWER
As fun��es UPPER e LOWER s�o bastante intuitivas e nos permitem ajustar as palavras para que fiquem em letras mai�sculas e min�sculas.

UPPER transforma um texto em mai�scula
LOWER transforma um texto em min�scula */

-- Exemplo: Fa�a uma consulta � tabela DimCustomer e utilize as fun��es UPPER e LOWER na coluna de FirstName para observar o resultado
SELECT 
	FirstName AS 'Nome',
	UPPER(FirstName) AS 'NOME',
	LOWER(FirstName) AS 'nome',
	EmailAddress AS 'E-mail'
FROM
		DimCustomer
