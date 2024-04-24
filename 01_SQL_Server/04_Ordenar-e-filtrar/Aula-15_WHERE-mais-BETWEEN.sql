-- M�DULO 04 - SQL SERVER - ORDENAR E FILTRAR


/* AULA 15 - WHERE mais BETWEEN - Filtrando entre valores
O comando BETWEEN seleciona valores em um intervalo. Estes valores podem ser n�meros, textos ou data.
O BETWEEN � inclusivo, ou seja, os valores dos extremos (valor inicial e valor final) tamb�m s�o inclu�dos no intervalo. */

-- Selecione os produtos onde o pre�o est� entre $50 - $100
SELECT * FROM DimProduct
WHERE UnitPrice BETWEEN 50 AND 100

-- Selecione os produtos onde o pre�o N�O est� entre $50 - $100
SELECT * FROM DimProduct
WHERE UnitPrice NOT BETWEEN 50 AND 100

-- Selecione os funcion�rios que t�m a data de contrata��o entre '01-01-2000' e '31-12-2000'.
SELECT * FROM DimEmployee
WHERE HireDate BETWEEN '2000-01-01' AND '2000-12-31'