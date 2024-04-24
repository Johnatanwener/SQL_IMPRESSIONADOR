-- M�DULO 13 - SQL SERVER - CRUD


/* AULA 08 - INSERT INTO - Adicionando novos valores na tabela
Uutilize o comando INSERT INTO para aicionar novos valores � tabela.

Obs.: N�o faz diferen�a a ordem em que os valores s�o adicionados dentro do comando VALUES, desde que, essa ordem respeite a ordem das colunas dentro do par�nteses, logo ap�s o nome da tabela. */

INSERT INTO Produtos(id_produto, nome_produto, data_validade, preco_produto)
VALUES
	(1, 'Arroz', '31/12/2021', 22.50),
	(2, 'Feij�o', '20/11/2022', 8.99)

SELECT * FROM Produtos

------------------------------

-- AULA 09 - Ordem correta para adicionar dados com o INSERT
-- Pergunta: Ser� que faz diferen�a adicionar um novo dado com a ordem das colunas invertida?
-- Resposta: N�o haver� problema desde que, na hora de informar os valores eu respeite a ordem que foi colocada no comando INSERT
-- 1. Ordem utilizada anteriorment: (id_produto, nome_produto, data_validade, preco_produto)
-- 2. Ordem que ser� utilizada: (data_validade, id_produto, preco_produto)
INSERT INTO Produtos(data_validade, id_produto, preco_produto)
VALUES
	('31/05/2023', 3, 33.99)

-- Obs.: Uma nova linha foi adicionada de forma correta por�m, como n�o foi informada a informa��o de 'nome do produto', esse valor ser� interpretado como NULL

SELECT * FROM Produtos
