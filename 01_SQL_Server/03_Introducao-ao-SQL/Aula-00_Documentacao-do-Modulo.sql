-- M�DULO 03 - SQL SERVER - INTRODUCAO AO SQL


/* AULA 01 - INTRODU��O AO M�DULO
Nesse m�dulo vamos aprender os principais comandos b�sicos do SQL, que v�o permitir ter os primeiros contados com os dados do BD.

- SELECT							- SELECT ... DISTINCT
- SELECT *							- Comentando o c�digo
- SELECT ... TOP e TOP PERCENT		- Renomeando colunas (Alias)
- Exerc�cios
*/

------------------------------

-- AULA 02 - Criando uma Nova Consulta usando SELECT FROM
-- O SELECT � um comando para selecionar dados de uma tabela. 
-- O comando SELECT * permite selecionar TODAS as colunas de uma determinada tabela. N�o � muito recomend�vel para tabelas muito grnades. O objetivo deste comando � ter uma r�pida visualiza��o de toda a tabela.

-- Exemplo 1: Selecionando todas as linhas e colunas da tabela DimCustomer
SELECT * FROM DimCustomer

-- Exemplo 2: Selecionando todas as linhas e colunas da tabela DimStore
SELECT * FROM DimStore

-- Exemplo 3: Selecionando todas as linhas da tabela DimCustomer, especificamente as colunas StoreKey, StoreName, StorePhone
SELECT StoreKey, StoreName, StorePhone FROM DimStore

-- Exemplo 4: Selecionando todas as linhas e colunas da tabela DimProduct
SELECT * FROM DimProduct

-- Exemplo 5: Selecionando todas as linhasda tabela DimProduct, especificamente as colunas ProductName, BrandName
SELECT ProductName, BrandName FROM DimProduct

------------------------------

-- AULA 03 - Salvando a primeira consulta e resolvendo 2 problemas
-- 1. Para salvar � necess�rio seguir o caminho: --> Arquivo > Salvar SQLQuery1.sql ou Ctrl + S
-- 2. Antes de executar os c�digos, garanta que o banco de dados correto est� selecionado no canto superior esquerdo: banco de dados ContosoRetailDW
-- 3. Sempre que executar um c�digo, selecione todo ele para n�o ter problemas.

------------------------------

/* AULA 04 - Como organizar melhor os c�digos com indenta��o
Obs.: Para organizar melhor os seus c�digos, pule linhas. Abaixo temos dois exemplos de c�digos que chegam no mesmo resultado, s� que na vers�o 1, n�o utilizamos a indenta��o, e na vers�o 2, usamos. Observe que fica muito mais organizado. */

-- Exemplo 1: Selecionando todas as linhas e colunas da tabela DimStore
-- Vers�o 1
SELECT * FROM DimStore

-- Vers�o 2
SELECT 
	* 
FROM 
	DimStore

-- Exemplo 2: Selecionando todas as linhas da tabela DimCustomer, especificamente as colunas StoreKey, StoreName, StorePhone
-- Vers�o 1
SELECT StoreKey, StoreName, StorePhone FROM DimStore

-- Vers�o 2
SELECT 
	StoreKey, 
	StoreName, 
	StorePhone 
FROM 
	DimStore

------------------------------

-- AULA 05 - Criando coment�rios em SQL
-- Coment�rios em c�digos t�m 3 grandes finalidades:

-- 1. Criar uma frase que explica o funcionamento de um determinado c�digo
-- Este c�digo seleciona as colunas de ID do produto e nome do produto da tabela de produto
SELECT
	ProductKey,
	ProductName
FROM
	DimProduct

-- 2. Comentar apenas parte de um c�digo (para n�o apagar) e executar o restante
SELECT
	-- StoreKey,
	StoreName,
	StorePhone
FROM
	DimStore

-- 3. Comentar todo o trecho de um c�digo utilizando o /* ... */
/*
SELECT
	StoreKey,
	StoreName,
	StorePhone
FROM
	DimStore
*/

SELECT * FROM DimProduct

------------------------------

-- AULA 06 - SELECT TOP e TOP PERCENT
-- O Comando SELECT ... FROM: Retorna todas as linhas da tabela, independente das colunas selecionadas.

SELECT * FROM DimEmployee
SELECT FirstName, EmailAddress FROM DimEmployee

-- Os comandos SELECT TOP(N) e TOP(N) PERCENT: Retorna as N primeiras linhas
-- Exemplo 1: Crie um c�digo que retorna as 10 primeiras linhas da tabela de Produtos.
SELECT TOP(10) * FROM DimProduct

-- Exemplo 2: Retorna as 10% primeiras linhas da tabela de Clientes
SELECT TOP(10) PERCENT * FROM DimCustomer

-- Exemplo 3: Crie uma consulta que retorne as N 1000 linhas da tabela FactSales
SELECT TOP(1000) * FROM FacSales

------------------------------

-- AULA 07 - SELECT DISTINCT
-- Comando SELECT DISTINCT: Retorna os valores distintos de 1 ou mais colunas de uma tabela

-- Retorne todas as linhas da tabela DimProduct
SELECT * FROM DimProduct

-- Retorne os valores distintos da coluna ColorName da tabela DimProduct
SELECT DISTINCT ColorName FROM DimProduct

-- Retorne todas as linhas da tabela DimEmployee
SELECT * FROM DimEmployee

-- Retorne os valores distintos da coluna DepartmentName da tabela DimEmployee
SELECT
	DISTINCT DepartmentName
FROM DimEmployee

------------------------------

-- AULA 08 Renomeando colunas (aliasing)

-- Selecione as 3 colunas da tabela DimProduct: ProductName, BrandName e ColorName
-- Obs: O 'AS' ser� respons�vel por renomear uma coluna. N�o � obrigat�rio colocar aspas no nome que dar para a tabela por�m, � super recomendado e obrigat�rio se forem mais de 1 palavra
SELECT
	ProductName AS 'Produto',
	BrandName AS 'Marca',
	ColorName AS 'Cor'
FROM 
	DimProduct

------------------------------

-- AULA 09 - Resumo do M�dulo
-- AULA 10 - Explica��o Exerc�cios
-- AULA 11 - Resolu��o Exerc�cio 01
-- AULA 12 - Resolu��o Exerc�cio 02
-- AULA 13 - Resolu��o Exerc�cio 03
-- AULA 14 - Resolu��o Exerc�cio 04
-- AULA 15 - Resolu��o Exerc�cio 05
