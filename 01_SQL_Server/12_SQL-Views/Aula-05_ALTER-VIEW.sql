-- MÓDULO 12 - SQL SERVER - SQL VIEWS


/* AULA 05 - ALTER VIEW
Para alterar uma View criada, usamos o comando ALTER VIEW */

-- 1. Exemplos
-- a) Altere a view abaixo para incluir apenas os clientes do sexto Feminino

SELECT * FROM vwClientes -- Atualmente não possuí a coluna 'Sexo'

GO
ALTER VIEW vwClientes AS
SELECT
	FirstName AS 'Nome',
	EmailAddress AS 'E-mail',
	BirthDate AS 'Data Nascimento',
	Gender AS 'Sexo'
FROM 
	DimCustomer
WHERE Gender = 'F'
GO

SELECT * FROM vwClientes