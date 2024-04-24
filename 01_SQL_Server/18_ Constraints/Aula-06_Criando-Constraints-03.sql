-- MÓDULO 18 - SQL SERVER - Constraints


-- AULA 06: Criando Constraints para a Tabela fContratos

-- A tabela fContratos deve conter as seguintes colunas:
-- Coluna 1: id_contrato do tipo INT           --> Chave Primária e auto incremental
-- Coluna 2: data_assinatura do tipo DATE      --> Valor Padrão (GETDATE) caso não seja preenchida
-- Coluna 3: id_cliente do tipo INT            --> Chave Estrangeira
-- Coluna 4: id_gerente do tipo INT            --> Chave Estrangeira
-- Coluna 5: valor_contrato do tipo FLOAT      --> Não aceita valores nulos e deve ser maior que zero

CREATE TABLE fContratos(
	id_contrato INT IDENTITY(1, 1),
	data_assinatura DATE DEFAULT GETDATE(),
	id_cliente INT,
	id_gerente INT,
	valor_contrato FLOAT,
	CONSTRAINT fContratos_id_contrato_pk PRIMARY KEY(id_contrato),
	CONSTRAINT fContratos_id_cliente_fk FOREIGN KEY(id_cliente) REFERENCES dCliente(id_cliente),
	CONSTRAINT fContratos_id_gerente_fk FOREIGN KEY(id_gerente) REFERENCES dGerente(id_gerente),
	CONSTRAINT fContratos_valor_contrato_ck CHECK(valor_contrato > 0)
)

INSERT INTO fContratos(Data_Assinatura, ID_Cliente, ID_Gerente, Valor_Contrato)
VALUES
	('12/01/2019', 8, 1, 23000),
	('10/02/2019', 3, 2, 15500),
	('07/03/2019', 7, 2, 6500),
	('15/03/2019', 1, 3, 33000),
	('21/03/2019', 5, 4, 11100),
	('23/03/2019', 4, 2, 5500),
	('28/03/2019', 9, 3, 55000),
	('04/04/2019', 2, 1, 31000),
	('05/04/2019', 10, 4, 3400),
	('05/04/2019', 6, 2, 9200)


SELECT * FROM fContratos