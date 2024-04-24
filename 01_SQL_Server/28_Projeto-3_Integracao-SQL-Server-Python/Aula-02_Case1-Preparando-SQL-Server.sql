-- MÓDULO 28 - SQL SERVER - INTEGRAÇÃO SQL SERVER - PYTHON

/* AULA 02 - Case 1 (Escrita) - Preparando o SQL Server antes da integração
Inicialmente, precisamos searar preparar o SQL Server para receber os dados que serão inseridos no banco de dados por meio do Jupyter Notebook. 

Passo 1: Criar um novo banco de dados chamado PythonSQL
Passo 2: Criar uma tabela chamada Vendas com seis colunas (id_venda, data_venda, cliente, produto, preco, quantidade) que receberá os dados. 
Passo 3: Adicione o primeiro registro nesta tabela via SSMS para testar se está tudo certo.	*/

CREATE DATABASE PythonSQL
USE PythonSQL

CREATE TABLE Vendas(
	id_venda INT,
	data_venda DATE,
	cliente VARCHAR(100),
	produto VARCHAR(100),
	preco DECIMAL(10, 2),
	quantidade INT
)

INSERT INTO Vendas(id_venda, data_venda, cliente, produto, preco, quantidade) VALUES
	(1, '22/04/2022', 'Ana', 'Celular', 2000, 1)

SELECT * FROM Vendas -- 1 resgitro = Tudo certo, OK!

-- Agora vamos para o Jupyter para a 2ª etapa do nosso projeto.
