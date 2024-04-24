-- MÓDULO 04 - SQL SERVER - ORDENAR E FILTRAR


/* AULA 04-06 - WHERE
O comando WHERE é utilizado para filtrar os dados das tabelas.

Filtrando colunas de números
Quantos produtos têm um preço unitário maior que $1000? */
SELECT 
	ProductName AS 'Produto',
	UnitPrice AS 'Preço'
FROM DimProduct
WHERE UnitPrice >= 1000


-- Filtrando colunas de texto
-- Quais produtos são da marca 'Fabrikam'?
SELECT * FROM DimProduct
WHERE BrandName = 'Fabrikam'

-- Quais produtos são da cor 'Black'?
SELECT * FROM DimProduct
WHERE ColorName = 'Black'


-- Filtrando colunas de data
-- Quantos clientes nasceram após o dia 31/12/1970 ?
SELECT * FROM DimCustomer
WHERE BirthDate >= '1970-12-31'
ORDER BY BirthDate DESC