-- MÓDULO 17 - SQL SERVER - Regex - Regular Expressions


-- AULA 09: LIKE - Identificando Caracteres especiais

USE BD_Collation
CREATE TABLE Textos(
ID INT,
Texto VARCHAR(100) COLLATE SQL_Latin1_General_CP1_CS_AS)

INSERT INTO Textos(ID, Texto)
VALUES
	(1, 'Marcos'), (2, 'Excel'), (3, 'leandro'), (4, 'K'), (5, 'X7'), (6, 'l9'), (7, '#M'), (8, '@9'), (9, 'M'), (10, 'RT')

-- Identificando caracteres especiais
SELECT *
FROM Textos
WHERE Texto LIKE '%[^A-z0-9]%'