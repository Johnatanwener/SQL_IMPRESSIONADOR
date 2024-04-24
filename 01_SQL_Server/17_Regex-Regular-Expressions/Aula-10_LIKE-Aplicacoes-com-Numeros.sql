-- M�DULO 17 - SQL SERVER - Regex - Regular Expressions


-- AULA 10: LIKE - Aplica��es com N�meros
USE BD_Collation
CREATE TABLE Numeros(
Numero DECIMAL(20, 2))

INSERT INTO Numeros(Numero)
VALUES
	(50), (30.23), (9), (100.54), (15.9), (6.5), (10), (501.76), (1000.56), (31)

SELECT * FROM Numeros

-- Retornando os n�meros que possuem 2 d�gitos na parte inteira
SELECT *
FROM Numeros
WHERE Numero LIKE '[0-9][0-9].[0][0]'

-- Retornando linhas que:
-- 1. Possuem 3 d�gitos na parte inteira, sendo o primeiro d�gito igual a 5
-- 2. O primeiro n�mero da parte decimal seja 7.
-- 3. O segundo n�mero da parte decimal seja um n�mero entre 0 e 9.

SELECT *
FROM Numeros
WHERE Numero LIKE '[5]__.[7][0-9]'