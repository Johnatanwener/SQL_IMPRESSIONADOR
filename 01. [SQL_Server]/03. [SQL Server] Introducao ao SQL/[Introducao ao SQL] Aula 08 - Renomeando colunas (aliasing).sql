-- MÓDULO 03 - SQL SERVER - INTRODUCAO AO SQL

-- AULA 08 Renomeando colunas (aliasing)

-- Selecione as 3 colunas da tabela DimProduct: ProductName, BrandName e ColorName
-- Obs: O 'AS' será responsável por renomear uma coluna. Não é obrigatório colocar aspas no nome que dar para a tabela porém, é super recomendado e obrigatório se forem mais de 1 palavra
SELECT
	ProductName AS 'Produto',
	BrandName AS 'Marca',
	ColorName AS 'Cor'
FROM 
	DimProduct