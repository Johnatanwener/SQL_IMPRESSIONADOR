-- M�DULO 10 - SQL SERVER - Manipulando Strings e Datas


/* AULA 03 - CONCAT
A fun��o CONCAT permite juntar dois ou mais textos em um s�. 

Exemplo: Fa�a uma consulta � tabela DimCustomer onde seja poss�vel visualizar o nome completo de cada cliente. */
SELECT * FROM DimCustomer -- N�o temos uma coluna com o nome completo dos clientes.

SELECT
	FirstName AS 'Nome',
	LastName AS 'Sobrenome',
	CONCAT(FirstName, ' ', LastName) AS 'Nome Completo',
	EmailAddress AS 'E-mail'
FROM
	DimCustomer

-- OBS: Para separar os textos � obrigat�rio acrescentar um espa�o entre aspas simples;
