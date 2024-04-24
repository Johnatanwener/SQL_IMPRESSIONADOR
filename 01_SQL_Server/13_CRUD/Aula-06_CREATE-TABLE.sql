-- MÓDULO 13 - SQL SERVER - CRUD

/* AULA 06 - CREATE TABLE - Criando a primeira tabela
1. Crie uma tabela chamada 'Produtos'
2. Essa abela deve conter 4 colunas: id_produt, nome_produto, data_validade e preco_produto
3. Certifique-se de que o tipo das colunas está correto. */

USE BDImpressionador

CREATE TABLE Produtos(
	id_produto INT,
	nome_produto VARCHAR(MAX),
	data_validade DATETIME,
	preco_produto FLOAT
)

SELECT * FROM Produtos