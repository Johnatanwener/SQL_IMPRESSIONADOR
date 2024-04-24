-- MÓDULO 04 - SQL SERVER - ORDENAR E FILTRAR


/* AULA 15 - WHERE mais BETWEEN - Filtrando entre valores
O comando BETWEEN seleciona valores em um intervalo. Estes valores podem ser números, textos ou data.
O BETWEEN é inclusivo, ou seja, os valores dos extremos (valor inicial e valor final) também são incluídos no intervalo. */

-- Selecione os produtos onde o preço está entre $50 - $100
SELECT * FROM DimProduct
WHERE UnitPrice BETWEEN 50 AND 100

-- Selecione os produtos onde o preço NÃO está entre $50 - $100
SELECT * FROM DimProduct
WHERE UnitPrice NOT BETWEEN 50 AND 100

-- Selecione os funcionários que têm a data de contratação entre '01-01-2000' e '31-12-2000'.
SELECT * FROM DimEmployee
WHERE HireDate BETWEEN '2000-01-01' AND '2000-12-31'