-- MÓDULO 17 - SQL SERVER - Regex - Regular Expressions

-- AULA 08: LIKE - Utilizando o operador de negação
CREATE TABLE Nomes(
ID INT,
Nome VARCHAR(100) COLLATE SQL_Latin1_General_CP1_CS_AS)

INSERT INTO Nomes(ID, Nome)
VALUES
	(1, 'Matheus'), (2, 'Marcela'), (3, 'marcos'), (4, 'MAuricio'), (5, 'Marta'), (6, 'Miranda'), (7, 'Melissa'), (8, 'Lucas'), (9, 'luisa'), (10, 'Pedro')

-- Retorna nomes que não começa com as letras 'L' ou 'l'
SELECT *
FROM Nomes
WHERE Nome LIKE '[^Ll]%'

-- Retorna nomes que começa com qualquer caractere (caractere curinga) e a segunda letra não é um 'E' ou 'e'
SELECT *
FROM Nomes
WHERE Nome LIKE '_[^Ee]%'