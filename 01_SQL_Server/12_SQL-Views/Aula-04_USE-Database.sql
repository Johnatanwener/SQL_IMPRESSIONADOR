-- M�DULO 12 - SQL SERVER - SQL VIEWS

-- AULA 04 - USE Database - Como especificar o banco de dados usado
-- Sempre que for selecionar uma tabela que esta em outro banco de dados sempre utilize a instru��o USE
USE Teste
SELECT * FROM Produtos

USE ContosoRetailDW
SELECT * FROM DimProduct