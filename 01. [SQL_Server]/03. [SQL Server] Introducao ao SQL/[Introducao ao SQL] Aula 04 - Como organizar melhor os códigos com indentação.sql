-- M�DULO 03 - SQL SERVER - INTRODUCAO AO SQL

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
