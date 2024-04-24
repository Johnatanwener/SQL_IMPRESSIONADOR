-- M�DULO 04 - SQL SERVER - ORDENAR E FILTRAR


/* AULA 13 - WHERE mais IN - Alternativa ao OR com m�ltiplas condi��es
O operador IN permite que sejam especificados m�ltiplos crit�rios dento do WHERE.
O operador IN � uma alternativa reduzida ao OR. */

-- Exemplo 1: Selecione os produtos que s�o de quaisquer uma dessas cores: (Silver, Blue, White, Red, Black)
SELECT * FROM DimProduct
WHERE ColorName IN ('Silver', 'Blue', 'White', 'Red', 'Black')

-- Exemplo 2: Selecione os funcion�rios que s�o de qualquer um desses 3 departamentos: Production, Marketing, Engineering.
SELECT * FROM DimEmployee
WHERE DepartmentName IN ('Production', 'Marketing', 'Engineering')