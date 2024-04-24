-- MÓDULO 03 - SQL SERVER - INTRODUCAO AO SQL

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