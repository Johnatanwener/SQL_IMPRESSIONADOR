-- MÓDULO 17 - SQL SERVER - Regex - Regular Expressions


-- AULA 10: LIKE - Aplicações com Números
USE BD_Collation
CREATE TABLE Numeros(
Numero DECIMAL(20, 2))

INSERT INTO Numeros(Numero)
VALUES
	(50), (30.23), (9), (100.54), (15.9), (6.5), (10), (501.76), (1000.56), (31)

SELECT * FROM Numeros

-- Retornando os números que possuem 2 dígitos na parte inteira
SELECT *
FROM Numeros
WHERE Numero LIKE '[0-9][0-9].[0][0]'

-- Retornando linhas que:
-- 1. Possuem 3 dígitos na parte inteira, sendo o primeiro dígito igual a 5
-- 2. O primeiro número da parte decimal seja 7.
-- 3. O segundo número da parte decimal seja um número entre 0 e 9.

SELECT *
FROM Numeros
WHERE Numero LIKE '[5]__.[7][0-9]'