-- MÓDULO 17 - SQL SERVER - Regex - Regular Expressions


-- AULA 06: LIKE - Filtrando os primeiros caracteres + Case Sensitive

USE BD_Collation
CREATE TABLE Textos(
ID INT,
Texto VARCHAR(100) COLLATE SQL_Latin1_General_CP1_CS_AS)

INSERT INTO Textos(ID, Texto)
VALUES
	(1, 'Marcos'), (2, 'Excel'), (3, 'leandro'), (4, 'K'), (5, 'X7'), (6, 'l9'), (7, '#M'), (8, '@9'), (9, 'M'), (10, 'RT')

SELECT * FROM Textos

-- Retornando nomes que começam com a letra 'M', 'E' ou 'K'
SELECT *
FROM Textos
WHERE Texto LIKE '[MEK]%'

-- Retornando nomes que possuem apenas 1 caracteres
SELECT *
FROM Textos
WHERE Texto LIKE '[A-z]'

-- Retornando nomes que possuem apenas 2 caracteres
SELECT *
FROM Textos
WHERE Texto LIKE '[A-z][A-z]'

-- Retornando nomes que possuem apenas 2 caracteres: o primeiro uma letra, o segundo um número
SELECT *
FROM Textos
WHERE Texto LIKE '[A-z][0-9]'