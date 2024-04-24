-- M�DULO 04 - SQL SERVER - ORDENAR E FILTRAR


/* AULA 07-10 - Operadores L�gicos no SQL - WHERE mais (AND, OR e NOT)
O comando WHERE pode ser combinado com osoperadores AND, OR e NOT.
Os operadores AND e OR s�o usados para filtrar linhas da tabela baseado em mais de uma condi��o.

- O AND mostra as linhas da tabela se todas as condi��es forem atendidas.
- O OR mostra as linhas da tabela se pelo menos uma das condi��es for atendida.
- O NOT simplesmente mostra o oposto do que for considerado no filtro. Ex: mostra todas as linhas que N�O foram da marca 'Contoso' */

-- WHERE mais AND - Filtrando com mais de uma condi��o
-- Quais produtos s�o da marca 'Contoso' e TAMB�M s�o da cor 'Silver'?
SELECT * FROM DimProduct
WHERE BrandName = 'Contoso' AND ColorName = 'Silver'

-- Quais produtos s�o da marca 'Fabrikam' E TAMB�M s�o da cor 'Black'?
SELECT * FROM DimProduct
WHERE BrandName = 'Fabrikam' AND ColorName = 'Black'


-- WHERE mais OR - Filtrando com mais de uma condi��o
-- Quais produtos s�o da cor 'Blue' OU da cor 'Silver'?
SELECT * FROM DimProduct
WHERE ColorName = 'Blue' OR ColorName = 'Silver'

-- Fa�a uma consulta que retorne os produtos que s�o da marca 'Contoso' ou da cor 'Branca'
SELECT * FROM DimProduct
WHERE BrandName = 'Contoso' OR ColorName = 'White'

-- Fa�a uma consulta que retorne os produtos que s�o das marcas 'Contoso', 'Fabrikam' ou Litware'.
SELECT * FROM DimProduct
WHERE BrandName = 'Contoso' OR BrandName = 'Fabrikam' OR BrandName = 'Litware'


-- WHERE mais NOT - Negando o filtro utilizado
-- Selecione os produtos que N�O s�o da cor 'Blue'
SELECT * FROM DimProduct
WHERE NOT ColorName = 'Blue'

-- Quais funcion�rios N�O s�o do departamento de 'Marketing'?
SELECT * FROM DimEmployee
WHERE NOT DepartmentName = 'Marketing'

------------------------------

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