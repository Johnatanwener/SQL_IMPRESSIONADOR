-- MÓDULO 19 - SQL SERVER - SEQUENCES


-- AULA 06 - Resolução de Exercícios

/* EXERCÍCIO 1
Crie o Banco de Dados AlugaFacil, onde serão criadas as sequences e tabelas dos exercícios. */
CREATE DATABASE AlugaFacil
USE AlugaFacil

------------------------------

/* EXERCÍCIO 2
Vamos criar Sequences que serão utilizadas nas tabelas: Carro, Cliente e Locacoes. 
Essas sequences serão chamadas de: cliente_seq, carro_seq e locaçoes_seq. 
Todas essas sequences devem começar pelo número 1, incrementar de 1 em 1 e não terem valor máximo. */
CREATE SEQUENCE cliente_seq
AS INT
START WITH 1
INCREMENT BY 1
NO MAXVALUE

CREATE SEQUENCE carro_seq
AS INT
START WITH 1
INCREMENT BY 1
NO MAXVALUE

CREATE SEQUENCE lacacoes_seq
AS INT
START WITH 1
INCREMENT BY 1
NO MAXVALUE

------------------------------

/* EXERCÍCIO 3
Utilize as sequences nas 3 tabelas: Carro, Cliente e Locacoes. Você deve excluir as tabelas existentes e recriá-las. Lembre-se que não é necessário utilizar a constraint IDENTITY nas colunas de chave primária uma vez que nelas serão usadas as Sequences.  

Tabela 1: Cliente - id_cliente - nome_cliente - cnh - cartao 

A tabela Cliente possui 4 colunas.  
A coluna id_cliente deve ser a chave primária da tabela. 
As colunas nome_cliente, cnh e cartao não podem aceitar valores nulos, ou seja, para todo cliente estes campos devem necessariamente ser preenchidos. 
Por fim, a coluna cnh não pode aceitar valores duplicados. */
CREATE TABLE Cliente (
	id_cliente INT,
	nome_cliente VARCHAR(100) NOT NULL,
	cnh VARCHAR(100) NOT NULL,
	cartao VARCHAR(100) NOT NULL,
	CONSTRAINT Cliente_id_cliente_pk PRIMARY KEY(id_cliente),
	CONSTRAINT Cliente_cnh_un UNIQUE(cnh)
)

/* Tabela 2: Carro - id_carro - placa - modelo - tipo 

A tabela Carro possui 3 colunas. 
A coluna id_carro deve ser a chave primária da tabela. 
As colunas modelo, tipo e placa não podem aceitar valores nulos. 
Os tipos de carros cadastrados devem ser: Hatch, Sedan, SUV. 
Por fim, a coluna placa não pode aceitar valores duplicados. */
CREATE TABLE Carro(
	id_carro INT,
	placa VARCHAR(100) NOT NULL,
	modelo VARCHAR(100) NOT NULL,
	tipo VARCHAR(100) NOT NULL,
	CONSTRAINT Carro_id_carro_pk PRIMARY KEY(id_carro),
	CONSTRAINT Carro_placa_un UNIQUE(placa),
	CONSTRAINT Carro_modelo_ck CHECK(tipo IN ('Hatch', 'Sedan', 'SUV'))
)

/* Tabela 3: Locacoes - id_locacao - data_locacao - data_devolucao - id_carro - id_cliente 

A tabela Locacoes possui 5 colunas. 
A coluna id_locacao deve ser a chave primária da tabela. 
Nenhuma das demais colunas devem aceitar valores nulos. 
As colunas id_carro e id_cliente são chaves estrangeiras que permitirão a relação da tabela 
Locacoes com as tabelas Carro e Cliente. */
CREATE TABLE Locacoes(
	id_locacao INT,
	data_locacao DATE NOT NULL,
	data_devolucao DATE NOT NULL,
	id_carro INT NOT NULL,
	id_cliente INT NOT NULL,
	CONSTRAINT Locacoes_id_locacao_pk PRIMARY KEY(id_locacao),
	CONSTRAINT Locacoes_id_carro_fk FOREIGN KEY(id_carro) REFERENCES Carro(id_carro),
	CONSTRAINT Locacoes_id_cliente_fk FOREIGN KEY(id_cliente) REFERENCES Cliente(id_cliente)
)

SELECT * FROM Cliente

INSERT INTO Cliente(id_cliente, nome_cliente, cnh, cartao) VALUES
	(NEXT VALUE FOR cliente_seq, 'Ana', '111111', '0147-0258-0369-0159'),
	(NEXT VALUE FOR cliente_seq, 'Bruno', '222222', '7410-8520-9630-9510'),
	(NEXT VALUE FOR cliente_seq, 'Carla', '333333', '0369-0258-0147-0951')

------------------------------

/* EXERCÍCIO 4
Exclua as sequences criadas. */
DROP SEQUENCE cliente_seq
DROP SEQUENCE carro_seq
DROP SEQUENCE lacacoes_seq