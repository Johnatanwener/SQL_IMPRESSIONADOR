-- MÓDULO 13 - SQL SERVER - CRUD


/* AULA 14 - ALTER TABLE - Adicionar, deletar ou modificar o tipo de dados de uma coluna
Para adicionar uma nova coluna na tabela, utilizamos o comando ALTER TABLE em conjutndo com o comando ADD.
Em seguida, utilizamos o comando UPDATE em conjunto com o comando WHERE para atualizar os valores dessa coluna. */

-- Adicionar coluna:
ALTER TABLE Funcionarios
ADD cargo varchar(100), bonus decimal(10,2)

UPDATE Funcionarios
SET cargo = 'Analista', bonus = 0.15
WHERE id_funcionario = 1

SELECT * FROM Funcionarios

-- Alterar tipo de dados de uma coluna:
ALTER TABLE Funcionarios
ALTER COLUMN salario int

-- Deletar coluna:
ALTER TABLE Funcionarios
DROP COLUMN cargo, bonus