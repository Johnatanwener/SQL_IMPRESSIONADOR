-- M�DULO 03 - SQL SERVER - INTRODUCAO AO SQL

-- AULA 08 Renomeando colunas (aliasing)

-- Selecione as 3 colunas da tabela DimProduct: ProductName, BrandName e ColorName
-- Obs: O 'AS' ser� respons�vel por renomear uma coluna. N�o � obrigat�rio colocar aspas no nome que dar para a tabela por�m, � super recomendado e obrigat�rio se forem mais de 1 palavra
SELECT
	ProductName AS 'Produto',
	BrandName AS 'Marca',
	ColorName AS 'Cor'
FROM 
	DimProduct