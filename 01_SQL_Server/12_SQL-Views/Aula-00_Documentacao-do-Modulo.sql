-- M�DULO 12 - SQL SERVER - SQL VIEWS

/* AULA 01 - Introdu��o ao M�dulo
Nesso m�dulo vamos aprender a criar Views no SQL

- O que � uma View?
- CREATE VIEW
- ALTER VIEW
- DROP VIEW

- O que � uma View? Uma VIEW � uma tabela virtual criada a partir de uma consulta a uma ou mais tabelas (ou at� mesmo de outras VIEWS) no banco de dados. Ela cont�m linhas e colunas assim como uma tabela real. Nela podemos utilizar comandos como o JOIN, WHERE e outras fun��es. Sempre mostra resultados atualizados dos dados, ou seja, uma vez criada, caso haja alguma altera��o no Banco de Dados, as Views ser�o atualizadas automaticamente. Caso o servidor seja desligado (ou o SSMS fechado), a View continuar� armazenada no sistema. Atrav�s de uma View, conseguimos armazenar o resultado de um SELECT e acessar sempre que precisarmos, como se fosse uma tabela, sem a necessidade de re-escrever a consulta novamente do zero.

- Por que criar uma View? S�o muitas as vantagens de criar uma View, como por exemplo:
Reutiliza��o: Sempre que necess�rio, podemos consultar aquela View, pois ela fica armazenada no sistema.
Seguran�a: Ao criar uma View, estamos ocultando linhas ou colunas da tabela original do banco de dados. Desta forma, apenas algumas informa��es relevantes ser�o visualizadas na View.
Ganho de Tempo: Quando criamos Views, estamos poupando o tempo de recriar v�rios SELECTs, o que aumenta a produtividade. */

------------------------------

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

------------------------------

-- AULA 04 - USE Database - Como especificar o banco de dados usado
-- Sempre que for selecionar uma tabela que esta em outro banco de dados sempre utilize a instru��o USE
USE Teste
SELECT * FROM Produtos

USE ContosoRetailDW
SELECT * FROM DimProduct

------------------------------

/* AULA 05 - ALTER VIEW
Para alterar uma View criada, usamos o comando ALTER VIEW */

-- 1. Exemplos
-- a) Altere a view abaixo para incluir apenas os clientes do sexto Feminino

SELECT * FROM vwClientes -- Atualmente n�o possu� a coluna 'Sexo'

GO
ALTER VIEW vwClientes AS
SELECT
	FirstName AS 'Nome',
	EmailAddress AS 'E-mail',
	BirthDate AS 'Data Nascimento',
	Gender AS 'Sexo'
FROM 
	DimCustomer
WHERE Gender = 'F'
GO

SELECT * FROM vwClientes

------------------------------

/* AULA 06 - DROP VIEW
Para excluir uma View criada, usamod o comando DROP VIEW. */

-- Exemplo: Exclua as views vwClientes e vwProdutos
DROP VIEW vwProdutos
DROP VIEW vwClientes

------------------------------

-- AULA 07 - Explica��o Exerc�cios
-- AULA 08 - Resolu��o Exerc�cios 01
-- AULA 09 - Resolu��o Exerc�cios 02
-- AULA 10 - Resolu��o Exerc�cios 03
-- AULA 11 - Resolu��o Exerc�cios 04
-- AULA 12 - Resolu��o Exerc�cios 05
-- AULA 13 - Resolu��o Exerc�cios 06