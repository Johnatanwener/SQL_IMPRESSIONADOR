-- M�DULO 03 - SQL SERVER - INTRODUCAO AO SQL

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