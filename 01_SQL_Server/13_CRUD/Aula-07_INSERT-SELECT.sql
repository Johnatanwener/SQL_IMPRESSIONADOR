-- M�DULO 13 - SQL SERVER - CRUD


/* AULA 07 - INSERT SELECT - Adicionando dados de outra tabela
Com o comando INSERT INTO SELECT � poss�vel adicionar dados de um outro banco de dados � nossa tabela rec�m criada. */

-- Adicionando valores de outra tabela.
INSERT INTO Produtos(id_produto, nome_produto, data_validade, preco_produto)
SELECT
	ProductKey,
	ProductName,
	AvailableForSaleDate,
	UnitPrice
FROM
	ContosoRetailDW.dbo.DimProduct

SELECT * FROM Produtos
