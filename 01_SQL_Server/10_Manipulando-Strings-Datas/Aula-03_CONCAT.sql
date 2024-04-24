-- MÓDULO 10 - SQL SERVER - Manipulando Strings e Datas


/* AULA 03 - CONCAT
A função CONCAT permite juntar dois ou mais textos em um só. 

Exemplo: Faça uma consulta à tabela DimCustomer onde seja possível visualizar o nome completo de cada cliente. */
SELECT * FROM DimCustomer -- Não temos uma coluna com o nome completo dos clientes.

SELECT
	FirstName AS 'Nome',
	LastName AS 'Sobrenome',
	CONCAT(FirstName, ' ', LastName) AS 'Nome Completo',
	EmailAddress AS 'E-mail'
FROM
	DimCustomer

-- OBS: Para separar os textos é obrigatório acrescentar um espaço entre aspas simples;
