-- MÓDULO 18 - SQL SERVER - Constraints


-- AULA 04: Criando Constraints para a Tabela dCliente

-- A tabela dCliente deve conter as seguintes colunas:
-- Coluna 1: id_cliente do tipo INT          --> Chave Primária e deve ser auto incrementada
-- Coluna 2: nome_cliente do tipo VARCHAR    --> Não aceita valores nulos
-- Coluna 3: genero VARCHAR                  --> Não aceita valores nulos e devem ser ('M', 'F', 'O', 'PND')
-- Coluna 4: data_nascimento DATE            --> Não aceita valores nulos  
-- Coluna 5: cpf do tipo VARCHAR             --> Não aceita valores duplicados nem valores nulos

CREATE TABLE dCliente(
	id_cliente INT IDENTITY(1, 1),
	nome_cliente VARCHAR(100) NOT NULL,
	genero VARCHAR (100) NOT NULL,
	data_de_nascimento DATE NOT NULL,
	cpf VARCHAR(100) NOT NULL,
	CONSTRAINT dCliente_cliente_pk PRIMARY KEY(id_cliente),
	CONSTRAINT dCliente_genero_ck CHECK(Genero IN ('M', 'F', 'O', 'PND')),
	CONSTRAINT dCliente_cpf_un UNIQUE(cpf)
)

INSERT INTO dCliente(Nome_Cliente, Genero, Data_de_Nascimento, CPF)
VALUES
	('André Martins',  'M',  '12/02/1989', '839.283.190-00'),
	('Bárbara Campos',  'F', '07/05/1992', '351.391.410-02'),
	('Carol Freitas',  'F',  '23/04/1985', '139.274.921-12'),
	('Diego Cardoso',   'M', '11/10/1994', '192.371.081-17'),
	('Eduardo Pereira', 'M', '09/11/1988', '193.174.192-82'),
	('Fabiana Silva',  'F',  '02/09/1989', '231.298.471-98'),
	('Gustavo Barbosa', 'M', '27/06/1993', '240.174.171-76'),
	('Helen Viana',    'F',  '11/02/1990', '193.129.183-01'),
	('Igor Castro',    'M',  '21/08/1989', '184.148.102-29'),
	('Juliana Pires',   'F', '13/01/1991', '416.209.192-47')

SELECT * FROM dCliente