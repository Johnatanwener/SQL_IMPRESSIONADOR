-- MODULO 20 - SQL SERVER - TRANSACTIONS


/* EXERCÍCIO 01
Crie uma tabela chamada Carro com os dados abaixo. 
Obs: não se preocupe com constraints, pode criar uma tabela simples. */

CREATE TABLE Carro(
	id_carro INT IDENTITY(1, 1),
	placa VARCHAR(100) NOT NULL,
	modelo VARCHAR(100) NOT NULL,
	tipo VARCHAR(100) NOT NULL,
	CONSTRAINT Carro_id_carro_pk PRIMARY KEY(id_Carro),
	CONSTRAINT Carro_placa_un UNIQUE(placa),
	CONSTRAINT Carro_tipo_ck CHECK(tipo IN('Hatch', 'Sedan', 'SUV'))
)

INSERT INTO Carro (placa, modelo, tipo) VALUES
	('DAS-1412', 'Hyundai HB20', 'Hatch'),
	('JHG-3902', 'Fiat Cronos', 'Sedan'),
	('IPW-9018', 'Citroen C4 Cactus', 'SUV'),
	('JKR-8891', 'Nissan Kicks', 'SUV'),
	('TRF-5904', 'Chevrolet Onix', 'Sedan')

SELECT * FROM Carro

------------------------------

/* EXERCÍCIO 02
Execute as seguintes transações no banco de dados, sempre na tabela Carro. Lembre-se de dar um COMMIT para efetivar cada uma das transações. 

a) Inserir uma nova linha com os seguintes valores: 
id_carro = 6 
placa = CDR-0090 
modelo = Fiat Argo 
t ipo = Hatch */

BEGIN TRANSACTION
INSERT INTO Carro(placa, modelo, tipo) VALUES
	('CDR-0090', 'Fiat Argo', 'Hatch')
COMMIT

SELECT * FROM Carro

/* b) Atualizar o tipo do carro de id = 1 de Hatch para Sedan. */

BEGIN TRANSACTION
UPDATE Carro
SET tipo = 'Sedan'
WHERE id_carro = 1
COMMIT

SELECT * FROM Carro


/* c) Deletar a linha referente ao carro de id = 6. */

BEGIN TRANSACTION
DELETE FROM Carro
WHERE id_carro = 6
COMMIT

SELECT * FROM Carro
