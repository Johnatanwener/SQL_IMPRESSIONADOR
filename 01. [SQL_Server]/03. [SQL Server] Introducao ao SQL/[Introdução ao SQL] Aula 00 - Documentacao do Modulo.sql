-- MÓDULO 03 - SQL SERVER - INTRODUCAO AO SQL


/* AULA 01 - INTRODUÇÃO AO MÓDULO
Nesse módulo vamos aprender os principais comandos básicos do SQL, que vão permitir ter os primeiros contados com os dados do BD.

- SELECT							- SELECT ... DISTINCT
- SELECT *							- Comentando o código
- SELECT ... TOP e TOP PERCENT		- Renomeando colunas (Alias)
- Exercícios
*/

------------------------------

-- AULA 02 - Criando uma Nova Consulta usando SELECT FROM
-- O SELECT é um comando para selecionar dados de uma tabela. 
-- O comando SELECT * permite selecionar TODAS as colunas de uma determinada tabela. Não é muito recomendável para tabelas muito grnades. O objetivo deste comando é ter uma rápida visualização de toda a tabela.

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
-- 1. Para salvar é necessário seguir o caminho: --> Arquivo > Salvar SQLQuery1.sql ou Ctrl + S
-- 2. Antes de executar os códigos, garanta que o banco de dados correto está selecionado no canto superior esquerdo: banco de dados ContosoRetailDW
-- 3. Sempre que executar um código, selecione todo ele para não ter problemas.

------------------------------

/* AULA 04 - Como organizar melhor os códigos com indentação
Obs.: Para organizar melhor os seus códigos, pule linhas. Abaixo temos dois exemplos de códigos que chegam no mesmo resultado, só que na versão 1, não utilizamos a indentação, e na versão 2, usamos. Observe que fica muito mais organizado. */

-- Exemplo 1: Selecionando todas as linhas e colunas da tabela DimStore
-- Versão 1
SELECT * FROM DimStore

-- Versão 2
SELECT 
	* 
FROM 
	DimStore

-- Exemplo 2: Selecionando todas as linhas da tabela DimCustomer, especificamente as colunas StoreKey, StoreName, StorePhone
-- Versão 1
SELECT StoreKey, StoreName, StorePhone FROM DimStore

-- Versão 2
SELECT 
	StoreKey, 
	StoreName, 
	StorePhone 
FROM 
	DimStore

------------------------------

-- AULA 05 - Criando comentários em SQL
-- Comentários em códigos têm 3 grandes finalidades:

-- 1. Criar uma frase que explica o funcionamento de um determinado código
-- Este código seleciona as colunas de ID do produto e nome do produto da tabela de produto
SELECT
	ProductKey,
	ProductName
FROM
	DimProduct

-- 2. Comentar apenas parte de um código (para não apagar) e executar o restante
SELECT
	-- StoreKey,
	StoreName,
	StorePhone
FROM
	DimStore

-- 3. Comentar todo o trecho de um código utilizando o /* ... */
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
-- Exemplo 1: Crie um código que retorna as 10 primeiras linhas da tabela de Produtos.
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
-- Obs: O 'AS' será responsável por renomear uma coluna. Não é obrigatório colocar aspas no nome que dar para a tabela porém, é super recomendado e obrigatório se forem mais de 1 palavra
SELECT
	ProductName AS 'Produto',
	BrandName AS 'Marca',
	ColorName AS 'Cor'
FROM 
	DimProduct

------------------------------

-- AULA 09 - Resumo do Módulo
-- AULA 10 - Explicação Exercícios
-- AULA 11 - Resolução Exercício 01
-- AULA 12 - Resolução Exercício 02
-- AULA 13 - Resolução Exercício 03
-- AULA 14 - Resolução Exercício 04
-- AULA 15 - Resolução Exercício 05
