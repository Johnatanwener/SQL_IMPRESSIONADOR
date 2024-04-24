-- M�DULO 04 - SQL SERVER - ORDENAR E FILTRAR


-- AULA 11 - Exerc�cios de Fixa��o: WHERE mais AND, OR e NOT
-- Exerc�cio 1: Selecione todas as linhas da tabela dimEmployee de funcion�rios do sexo feminino e do departamento de finan�as.
SELECT * FROM DimEmployee
WHERE Gender = 'F' AND DepartmentName = 'Finance'

-- Exerc�cio 2: Selecione todas as linhas da tabela dimProduct de produtos da marca Contoso e da cor vermelha e que tenham um UnitPrice maior ou igual a $100
SELECT * FROM DimProduct
WHERE BrandName = 'Contoso' AND ColorName = 'Red' AND UnitPrice >= 100

-- Exerc�cio 3: Selecione todas as linhas da tabela dimProduct com produtos da marca Litware OU da marca Frabrikam OU da cor Preta.
SELECT * FROM DimProduct
WHERE BrandName = 'Fabrikam' OR BrandName = 'Litware' OR ColorName = 'Black'

-- Exerc�cio 4: Selecione todas as linhas da tabela dimSalesterritory onde o continente � a Europa mas o pa�s N�O � igual a It�lia.
SELECT * FROM DimSalesTerritory
WHERE SalesTerritoryGroup = 'Europe' AND NOT SalesTerritoryCountry = 'Italy'