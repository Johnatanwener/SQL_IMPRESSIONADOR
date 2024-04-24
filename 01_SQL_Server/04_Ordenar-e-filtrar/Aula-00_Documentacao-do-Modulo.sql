-- MÓDULO 04 - SQL SERVER - ORDENAR E FILTRAR

/* AULA 01 - Introdução ao Módulo
Nesse módulo vamos aprender como vamos utilizar os comandos SQL para ordenação e filtragem das tabelas.

- ORDER BY				- WHERE ... IN
- WHERE					- WHERE ... (NOT) BETWEEN
- WHERE ... LIKE		- WHERE ... IS (NOT) NULL
- WHERE ... OR/AND
*/

------------------------------

/* AULA 02-03 - ORDER BY
O ORDER BY é usado para ordenar os valores de uma tabela em ordem crescente ou decrescente.
Por padrão, o ORDER BY ordena os dados em ordem crescente (ASC). Para ordenar de forma descrescente, usamos o DESC.

Selecionando as TOP 100 linhas da tabela DimStore, ordenando pela coluna EmployeeCount de forma decrescente. */
SELECT TOP (100) * FROM DimStore
ORDER BY EmployeeCount DESC

-- Exemplo 1: Selecione as 100 primeiras linhas das colunas StoreName e EmployeeCount da tabela DimStore, e ordene de acordo com a coluna de quantidade de funcionarios.
SELECT TOP(100)
	StoreName,
	EmployeeCount
FROM DimStore
ORDER BY EmployeeCount -- Ordenando de forma crescente
-- ORDER BY EmployeeCount DESC


-- Exemplo 2: Selecione as 100 primeiras linhas da tabela DimStore e ordene de acordo com a coluna de StoreName.
SELECT TOP(100)
	StoreKey,
	StoreName
FROM DimStore
ORDER BY StoreName -- Ordenando de forma crescente
-- ORDER BY StoreName DESC


-- Exemplo 3: Selecione as 100 primeiras linhas da tabela DimProduct, e ordene de acordo com as colunas UnitCost (DESC) e Weight (DESC)
SELECT * FROM DimProduct

SELECT TOP (10) 
	ProductName,
	Weight,
	UnitCost	
FROM DimProduct
ORDER BY 
	UnitCost DESC, 
	Weight DESC

------------------------------

/* AULA 04-06 - WHERE
O comando WHERE é utilizado para filtrar os dados das tabelas.

Filtrando colunas de números
Quantos produtos têm um preço unitário maior que $1000? */
SELECT 
	ProductName AS 'Produto',
	UnitPrice AS 'Preço'
FROM DimProduct
WHERE UnitPrice >= 1000


-- Filtrando colunas de texto
-- Quais produtos são da marca 'Fabrikam'?
SELECT * FROM DimProduct
WHERE BrandName = 'Fabrikam'

-- Quais produtos são da cor 'Black'?
SELECT * FROM DimProduct
WHERE ColorName = 'Black'


-- Filtrando colunas de data
-- Quantos clientes nasceram após o dia 31/12/1970 ?
SELECT * FROM DimCustomer
WHERE BirthDate >= '1970-12-31'
ORDER BY BirthDate DESC

------------------------------

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

------------------------------

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

------------------------------

-- AULA 12 - Cuidados ao utilizar o AND em conjunto com o OR

-- Exemplo: Selecione todas as linhas da tabela dimProduct onde a cor do Produto pode ser igual a Preto OU vermelho, MAS a marca deve ser obrigatoriamente igual a Fabrikam.
SELECT * FROM DimProduct
WHERE (ColorName = 'Black' OR ColorName = 'Red') AND BrandName = 'Fabrikam'

-- Obs: Lembre-se de incluir parênteses para agrupar os testes lógicos que você deseja fazer ao mesmo tempo, para assim chegar no resultado que você espera.

------------------------------

/* AULA 13 - WHERE mais IN - Alternativa ao OR com múltiplas condições
O operador IN permite que sejam especificados múltiplos critérios dento do WHERE.
O operador IN é uma alternativa reduzida ao OR. */

-- Exemplo 1: Selecione os produtos que são de quaisquer uma dessas cores: (Silver, Blue, White, Red, Black)
SELECT * FROM DimProduct
WHERE ColorName IN ('Silver', 'Blue', 'White', 'Red', 'Black')

-- Exemplo 2: Selecione os funcionários que são de qualquer um desses 3 departamentos: Production, Marketing, Engineering.
SELECT * FROM DimEmployee
WHERE DepartmentName IN ('Production', 'Marketing', 'Engineering')

------------------------------

/* AULA 14 - WHERE mais LIKE - Filtro especial para textos
O comando LIKE é usado em conjunto com o WHERE para procurar por um determinado padrão em uma coluna.

Existem 2 caracteres especiais usados em conjunto com o LIKE.

1. O sinal de porcentagem (%) representa zero, um ou múltiplos caracteres.
2. O underline (_) representa um único caractere.

Aplicação do LIKE							Descrição
WHERE CustomerName LIKE 'a%'	>	Encontra qualquer valor que começa com 'a'
WHERE CustomerName LIKE '%a'	>	Encontra qualquer valor que termina com 'a'
WHERE CustomerName LIKE '%or%'	>	Encontra qualquer valor que tenha 'or' em qualquer posição da palavra
WHERE CustomerName LIKE '_r%'	>	Encontra qualquer valor que tenha 'r' a partir do segundo caractere
WHERE CustomerName LIKE 'a_%'	>	Encontra qualquer valor que comece com 'a' e tenha pelo menos 2 caracteres		
WHERE CustomerName LIKE 'a__%'	>	Encontra qualquer valor que comece com 'a' e tenha pelo menos 3 caracteres
WHERE CustomerName LIKE 'a%0'	>	Encontra qualquer valor que comece com 'a' e termine com 'o'

-- 1. Selecione todos os produtos que possuem o texto 'MP3 Player' contido na nome do produto. */
SELECT * FROM DimProduct
WHERE ProductName LIKE '%MP3 Player%' 

-- 2. Selecione todos os produtos que têm a descrição do nome começando por 'Type'.
SELECT * FROM DimProduct
WHERE ProductDescription LIKE '%Type%'

-- 3. Selecione todos os produtos que têm a descrição do nome terminando em 'WMA'.
SELECT * FROM DimProduct
WHERE ProductDescription LIKE '%WMA'

------------------------------

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

------------------------------

/* AULA 16 - WHERE mais IS NULL e IS NOT NULL - Filtrando valores nulos
Podemos encontrar valores nulos (em branco) em uma tabela. Para filtrar esses valores, podemos usar os comandos IS NULL ou IS NOT NULL. */

-- 1. Selecione os clientes que são pessoa física.
SELECT * FROM DimCustomer
WHERE CompanyName IS NULL

-- 2. Selecione os clientes que são pessoa jurídica.
SELECT * FROM DimCustomer
WHERE CompanyName IS NOT NULL

------------------------------

-- AULA 17 - Explicação Exercícios
-- AULA 18 - Resolução Exercício 01
-- AULA 19 - Resolução Exercício 02
-- AULA 20 - Resolução Exercício 03
-- AULA 21 - Resolução Exercício 04
-- AULA 22 - Resolução Exercício 05
-- AULA 23 - Resolução Exercício 06
-- AULA 24 - Resolução Exercício 07
-- AULA 25 - Resolução Exercício 08
-- AULA 26 - Resolução Exercício 09
-- AULA 27 - Resolução Exercício 10