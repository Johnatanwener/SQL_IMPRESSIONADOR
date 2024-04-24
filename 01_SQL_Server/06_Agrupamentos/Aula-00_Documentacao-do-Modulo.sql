-- Módulo 06 - SQL SERVER - AGRUPAMENTOS NO SQL


/* AULA 01 - Introdução ao Módulo
Nesse módulo vamos aprender sobre fórmulas de agregação e como criar agrupamentos.

- GROUP BY
- GROUP BY + ORDER BY
- GROUP BY + WHERE
- HAVING
- HAVING vs WHERE
*/

------------------------------

/* AULA 02-03 - Group BY
O comando GROUP BY permite agrupar valores de acordo com uma coluna, por exemplo, 'total de funcionários de acordo com o depertamento'.
O GROUP BY é usado junto com funções de agregação COUNT(), MAX(), MIM(), SUM() e AVG() para agrupar valores de acordo com uma ou mais colunas.

Faça uma consulta que retorne a quantidade total de produtos e agrupe por marcas; */
SELECT * FROM DimProduct

SELECT
	BrandName AS 'Nome da Marca',
	COUNT(*) AS 'QTD. Total'
FROM
	DimProduct
GROUP BY BrandName


-- Consulta 1: Faça uma consulta que retorne a quantidade total de funcionários e agrupe por tipo de loja.
SELECT * FROM DimStore

SELECT
	StoreType,
	SUM(EmployeeCount) AS 'Qtd. Total Funcionários'
FROM
	DimStore
GROUP BY StoreType


-- Consulta 2: Faça uma consulta que retorne o custo médio dos produtos e agrupe por Marca
SELECT * FROM DimProduct

SELECT
	BrandName,
	AVG(UnitCost) AS 'Custo Médio'
FROM
	DimProduct
GROUP BY BrandName


-- Consulta 3: Faça uma consulta que retorne o preço máximo de um produto e agrupe por Classe
SELECT * FROM DimProduct

SELECT
	ClassName AS 'Classe do Produto',
	MAX(UnitPrice) AS 'Máximo Preço'
FROM
	DimProduct
GROUP BY ClassName

------------------------------

/* AULA 04 - GROUP BY mais ORDER BY
Faça uma consulta que retorne a soma da quantidade de funcionarios por tipo de loja e filtre por quantidade. */
SELECT * FROM DimStore

SELECT
	StoreType,
	SUM(EmployeeCount) AS 'Qtd. Total Funcionários'
FROM
	DimStore
GROUP BY StoreType
ORDER BY SUM(EmployeeCount) DESC

------------------------------

/* AULA 05 - GROUP BY mais WHERE
O comando GROUP BY combinado com o WHERE permite que a tabela principal seja filtrada antes de o agrupamento ser criado.

Faça uma consulta que retorne a CONTAGEM do total de produtos por COR, FILTRE os valores pela marca 'Contoso' e faça uma ordenação */
SELECT * FROM DimProduct

SELECT
	ColorName AS 'Cor do Produto',
	COUNT(*) AS 'Total de Produtos'
FROM
	DimProduct
WHERE BrandName = 'Contoso'
GROUP BY ColorName
ORDER BY [Total de Produtos] DESC

------------------------------

/* AULA 06 - GROUP BY mais HAVING
O comando GROUP BY combinado com o HAVING permite que a tabela agrupada seja filtrada e que apenas os valores totais que atendam ao critério do HAVING sejam considerados.

Faça uma consulta que retorne a quantidade de produtos por MARCA e posteriormente realize um filtro nos dados agrupados para mostrar apenas as marcas com mais de 200 produtos. */
SELECT * FROM DimProduct

SELECT
	BrandName AS 'Marca',
	COUNT(BrandName) AS 'Total por Marca'
FROM
	DimProduct
GROUP BY BrandName
HAVING COUNT(BrandName) >= 200

------------------------------

/* AULA 07 - WHERE VS HAVING
É muito importante que fique claro a diferença entre os comandos WHERE e HAVING.

Para entender a diferença entre os dois, vale lembrar que o GROUP BY permite que a gente crie um agrupamento a partir de uma tabela principal.

O comando WHERE será utilizado para filtrar a tabela principal antes de criar o agrupamento.
O comando HAVING será utilizado para filtrar a tabela após o agrupamento.

Portanto, podemos entender que:

- O WHERE será utilizado antes do agrupamento feito;
- O HAVING será um filtro utilizado após o agrupamento feito.

Diferenças entre WHERE e HAVING na filtragem de tabelas. */
SELECT * FROM DimProduct

SELECT
	BrandName AS 'Marca',
	COUNT(BrandName) AS 'Total por Marca'
FROM
	DimProduct
WHERE ClassName = 'Economy'	   -- Filtra a tabela original, antes do agrupamento.
GROUP BY BrandName
HAVING COUNT(BrandName) >= 200 -- Filtra a tabela depois de agrupada.

------------------------------

-- AULA 08 - Explicação Exercícios
-- AULA 09 - Resolução Exercício 01
-- AULA 10 - Resolução Exercício 02
-- AULA 11 - Resolução Exercício 03
-- AULA 12 - Resolução Exercício 04
-- AULA 13 - Resolução Exercício 05
-- AULA 14 - Resolução Exercício 06
-- AULA 15 - Resolução Exercício 07
-- AULA 16 - Resolução Exercício 08
-- AULA 17 - Resolução Exercício 09
-- AULA 18 - Resolução Exercício 10