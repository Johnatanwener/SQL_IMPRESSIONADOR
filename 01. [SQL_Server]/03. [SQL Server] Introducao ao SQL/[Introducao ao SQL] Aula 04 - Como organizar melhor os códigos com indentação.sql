-- MÓDULO 03 - SQL SERVER - INTRODUCAO AO SQL

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
