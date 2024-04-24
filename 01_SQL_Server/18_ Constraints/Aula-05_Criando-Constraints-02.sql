-- MÓDULO 18 - SQL SERVER - Constraints


-- AULA 05: Criando Constraints para a Tabela dGerente

-- A tabela dGerente deve conter as seguintes colunas:
-- Coluna 1: id_gerente do tipo INT            --> Chave Primária e auto incrementada
-- Coluna 2: nome_gerente do tipo VARCHAR      --> Não aceita valores nulos
-- Coluna 3: data_contratacao VARCHAR          --> Não aceita valores nulos
-- Coluna 4: salario do tipo FLOAT             --> Não aceita valores nulos nem abaixo de zero

CREATE TABLE dGerente(
	id_gerente INT IDENTITY(1, 1),
	nome_gerente VARCHAR(100) NOT NULL,
	data_contratacao VARCHAR(100) NOT NULL,
	salario FLOAT NOT NULL,
	CONSTRAINT dGerente_id_derente_pk PRIMARY KEY(id_gerente),
	CONSTRAINT dGerente_salario_ck CHECK(salario > 0)
)

INSERT INTO dGerente(Nome_Gerente, Data_Contratacao, Salario)
VALUES
	('Lucas Sampaio',   '21/03/2015', 6700),
	('Mariana Padilha', '10/01/2011', 9900),
	('Nathália Santos', '03/10/2018', 7200),
	('Otávio Costa',    '18/04/2017', 11000)

SELECT * FROM dGerente