-- MÓDULO 17 - SQL SERVER - Regex - Regular Expressions


-- AULA 05: LIKE - Case Sensitive

CREATE TABLE Nomes(
ID INT,
Nome VARCHAR(100) COLLATE SQL_Latin1_General_CP1_CS_AS)

INSERT INTO Nomes(ID, Nome)
VALUES
	(1, 'Matheus'), (2, 'Marcela'), (3, 'marcos'), (4, 'MAuricio'), (5, 'Marta'), (6, 'Miranda'), (7, 'Melissa'), (8, 'Lucas'), (9, 'luisa'), (10, 'Pedro')

SELECT * FROM Nomes

-- Case Sensitive (diferenciando maiúsculas de minúsculas)
-- LIKE padrão como aprendemos até agora:
SELECT *
FROM Nomes
--WHERE Nome LIKE 'mar%'
WHERE Nome LIKE 'Mar%'

-- Retorna as linhas onde a primeira letra seja 'm', a segunda seja 'a' e a terceira seja 'r'
SELECT *
FROM Nomes
WHERE Nome LIKE '[m][a][r]%'

-- Retorna as linhas onde a primeira letra seja [M], a segunda seja 'a' e a terceira seja 'r'
SELECT *
FROM Nomes
WHERE Nome LIKE '[M][a][r]%'

-- Retorna as linhas onde a primeira letra seja 'M' ou 'm', e a segunda seja 'A' ou 'a'
SELECT *
FROM Nomes
WHERE Nome LIKE '[M-m][A-a]%'
