-- MÓDULO 04 - SQL SERVER - ORDENAR E FILTRAR


/* AULA 13 - WHERE mais IN - Alternativa ao OR com múltiplas condições
O operador IN permite que sejam especificados múltiplos critérios dento do WHERE.
O operador IN é uma alternativa reduzida ao OR. */

-- Exemplo 1: Selecione os produtos que são de quaisquer uma dessas cores: (Silver, Blue, White, Red, Black)
SELECT * FROM DimProduct
WHERE ColorName IN ('Silver', 'Blue', 'White', 'Red', 'Black')

-- Exemplo 2: Selecione os funcionários que são de qualquer um desses 3 departamentos: Production, Marketing, Engineering.
SELECT * FROM DimEmployee
WHERE DepartmentName IN ('Production', 'Marketing', 'Engineering')