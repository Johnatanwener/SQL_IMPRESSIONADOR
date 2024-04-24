-- M�DULO 12 - SQL SERVER - SQL VIEWS


/* AULA 02-03 - CREATE VIEW
Para criar uma View, utilizamos o comando CREATE VIEW. 

CREATE VIEW nome_da_view AS
SELECT
	Coluna1,
	Coluna2,
	Coluna3
FROM
	Tabela

Uma vez criada, a View ficar� armazenada no banco de dados, na pasta de Exibi��es. E para selecionar essa View, utilizamos o comando SELECT. */


-- a) Crie uma view contendo as seguintes informa��es da tabela DimCustomer: FirstName, EmailAddress e BirthDate. Chame essa view de vwClientes

CREATE VIEW vwClientes AS
SELECT
	FirstName AS 'Nome',
	EmailAddress AS 'E-mail',
	BirthDate AS 'Data Nascimento'
FROM 
	DimCustomer

SELECT * FROM vwClientes


-- b) Crie uma View contendo as seguintes informa��es da tabela DimProduct: ProductKey, ProductName, BrandName e UnitPrice. Chame essa view de vwProdutos
CREATE VIEW vwProdutos AS
SELECT
	ProductKey AS 'ID Produto',
	ProductName AS 'Nome do Produto',
	ProductSubcategoryKey AS 'ID Subcategoria',
	BrandName AS 'Marca',
	UnitPrice AS 'Pre�o Unit�rio'
FROM DimProduct

SELECT * FROM vwProdutos

/* Quando criamos nossas Views, poder� ocorrer um 'erro de Sintaxe Incorreta' onde o comando CREATE VIEW ficar� sublinhado, como se identificasse um erro. Esse 'erro' ocorre quando temos outras consultas antes ou depois do comando CREATE VIEW e para que esse sublinhado desapare�a ser� necess�rio acrescentar a fun��o GO antes da fun��o CREATE VIEW e depois da fun��o CREATE VIEW (no final da consulta) 

Exemplo:	*/

GO
CREATE VIEW nome_da_view AS
SELECT
	Coluna1,
	Coluna2,
	Coluna3
FROM 
	Tabela
GO