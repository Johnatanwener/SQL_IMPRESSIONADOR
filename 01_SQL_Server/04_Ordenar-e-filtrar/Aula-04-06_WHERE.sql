-- M�DULO 04 - SQL SERVER - ORDENAR E FILTRAR


/* AULA 04-06 - WHERE
O comando WHERE � utilizado para filtrar os dados das tabelas.

Filtrando colunas de n�meros
Quantos produtos t�m um pre�o unit�rio maior que $1000? */
SELECT 
	ProductName AS 'Produto',
	UnitPrice AS 'Pre�o'
FROM DimProduct
WHERE UnitPrice >= 1000


-- Filtrando colunas de texto
-- Quais produtos s�o da marca 'Fabrikam'?
SELECT * FROM DimProduct
WHERE BrandName = 'Fabrikam'

-- Quais produtos s�o da cor 'Black'?
SELECT * FROM DimProduct
WHERE ColorName = 'Black'


-- Filtrando colunas de data
-- Quantos clientes nasceram ap�s o dia 31/12/1970 ?
SELECT * FROM DimCustomer
WHERE BirthDate >= '1970-12-31'
ORDER BY BirthDate DESC