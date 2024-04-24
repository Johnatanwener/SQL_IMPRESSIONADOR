-- MÓDULO 04 - SQL SERVER - ORDENAR E FILTRAR


/* AULA 07-10 - Operadores Lógicos no SQL - WHERE mais (AND, OR e NOT)
O comando WHERE pode ser combinado com osoperadores AND, OR e NOT.
Os operadores AND e OR são usados para filtrar linhas da tabela baseado em mais de uma condição.

- O AND mostra as linhas da tabela se todas as condições forem atendidas.
- O OR mostra as linhas da tabela se pelo menos uma das condições for atendida.
- O NOT simplesmente mostra o oposto do que for considerado no filtro. Ex: mostra todas as linhas que NÃO foram da marca 'Contoso' */

-- WHERE mais AND - Filtrando com mais de uma condição
-- Quais produtos são da marca 'Contoso' e TAMBÉM são da cor 'Silver'?
SELECT * FROM DimProduct
WHERE BrandName = 'Contoso' AND ColorName = 'Silver'

-- Quais produtos são da marca 'Fabrikam' E TAMBÉM são da cor 'Black'?
SELECT * FROM DimProduct
WHERE BrandName = 'Fabrikam' AND ColorName = 'Black'


-- WHERE mais OR - Filtrando com mais de uma condição
-- Quais produtos são da cor 'Blue' OU da cor 'Silver'?
SELECT * FROM DimProduct
WHERE ColorName = 'Blue' OR ColorName = 'Silver'

-- Faça uma consulta que retorne os produtos que são da marca 'Contoso' ou da cor 'Branca'
SELECT * FROM DimProduct
WHERE BrandName = 'Contoso' OR ColorName = 'White'

-- Faça uma consulta que retorne os produtos que são das marcas 'Contoso', 'Fabrikam' ou Litware'.
SELECT * FROM DimProduct
WHERE BrandName = 'Contoso' OR BrandName = 'Fabrikam' OR BrandName = 'Litware'


-- WHERE mais NOT - Negando o filtro utilizado
-- Selecione os produtos que NÃO são da cor 'Blue'
SELECT * FROM DimProduct
WHERE NOT ColorName = 'Blue'

-- Quais funcionários NÃO são do departamento de 'Marketing'?
SELECT * FROM DimEmployee
WHERE NOT DepartmentName = 'Marketing'