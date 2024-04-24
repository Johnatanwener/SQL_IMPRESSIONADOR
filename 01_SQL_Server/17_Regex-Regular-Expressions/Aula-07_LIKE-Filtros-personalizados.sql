-- MÓDULO 17 - SQL SERVER - Regex - Regular Expressions

-- AULA 07: LIKE - Aplicando filtros mais personalizados
CREATE TABLE Nomes(
ID INT,
Nome VARCHAR(100) COLLATE SQL_Latin1_General_CP1_CS_AS)

INSERT INTO Nomes(ID, Nome)
VALUES
	(1, 'Matheus'), (2, 'Marcela'), (3, 'marcos'), (4, 'MAuricio'), (5, 'Marta'), (6, 'Miranda'), (7, 'Melissa'), (8, 'Lucas'), (9, 'luisa'), (10, 'Pedro')

SELECT * FROM Nomes

-- Retorna os nomes que:
-- 1. Começam com a letra 'M' ou 'm'
-- 2. O segundo caractere pode ser qualquer coisa ('_' é um curinga)
-- 3. O terceiro caractere pode ser a letra 'R' ou a letra 'r'
-- 4. Possui uma quantidade qualquer de caracteres depois do terceiro (por conta do '%')

SELECT *
FROM Nomes
WHERE Nome LIKE '[Mm]_[Rr]%'