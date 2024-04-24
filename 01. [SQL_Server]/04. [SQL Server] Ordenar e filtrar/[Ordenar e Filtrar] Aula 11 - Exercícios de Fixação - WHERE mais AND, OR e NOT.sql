-- MÓDULO 04 - SQL SERVER - ORDENAR E FILTRAR


-- AULA 11 - Exercícios de Fixação: WHERE mais AND, OR e NOT
-- Exercício 1: Selecione todas as linhas da tabela dimEmployee de funcionários do sexo feminino e do departamento de finanças.
SELECT * FROM DimEmployee
WHERE Gender = 'F' AND DepartmentName = 'Finance'

-- Exercício 2: Selecione todas as linhas da tabela dimProduct de produtos da marca Contoso e da cor vermelha e que tenham um UnitPrice maior ou igual a $100
SELECT * FROM DimProduct
WHERE BrandName = 'Contoso' AND ColorName = 'Red' AND UnitPrice >= 100

-- Exercício 3: Selecione todas as linhas da tabela dimProduct com produtos da marca Litware OU da marca Frabrikam OU da cor Preta.
SELECT * FROM DimProduct
WHERE BrandName = 'Fabrikam' OR BrandName = 'Litware' OR ColorName = 'Black'

-- Exercício 4: Selecione todas as linhas da tabela dimSalesterritory onde o continente é a Europa mas o país NÃO é igual a Itália.
SELECT * FROM DimSalesTerritory
WHERE SalesTerritoryGroup = 'Europe' AND NOT SalesTerritoryCountry = 'Italy'