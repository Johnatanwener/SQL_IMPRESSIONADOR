-- M�dulo 06 - SQL SERVER - AGRUPAMENTOS NO SQL


/* AULA 01 - Introdu��o ao M�dulo
Nesse m�dulo vamos aprender sobre f�rmulas de agrega��o e como criar agrupamentos.

- GROUP BY
- GROUP BY + ORDER BY
- GROUP BY + WHERE
- HAVING
- HAVING vs WHERE
*/

------------------------------

/* AULA 02-03 - Group BY
O comando GROUP BY permite agrupar valores de acordo com uma coluna, por exemplo, 'total de funcion�rios de acordo com o depertamento'.
O GROUP BY � usado junto com fun��es de agrega��o COUNT(), MAX(), MIM(), SUM() e AVG() para agrupar valores de acordo com uma ou mais colunas.

Fa�a uma consulta que retorne a quantidade total de produtos e agrupe por marcas; */
SELECT * FROM DimProduct

SELECT
	BrandName AS 'Nome da Marca',
	COUNT(*) AS 'QTD. Total'
FROM
	DimProduct
GROUP BY BrandName


-- Consulta 1: Fa�a uma consulta que retorne a quantidade total de funcion�rios e agrupe por tipo de loja.
SELECT * FROM DimStore

SELECT
	StoreType,
	SUM(EmployeeCount) AS 'Qtd. Total Funcion�rios'
FROM
	DimStore
GROUP BY StoreType


-- Consulta 2: Fa�a uma consulta que retorne o custo m�dio dos produtos e agrupe por Marca
SELECT * FROM DimProduct

SELECT
	BrandName,
	AVG(UnitCost) AS 'Custo M�dio'
FROM
	DimProduct
GROUP BY BrandName


-- Consulta 3: Fa�a uma consulta que retorne o pre�o m�ximo de um produto e agrupe por Classe
SELECT * FROM DimProduct

SELECT
	ClassName AS 'Classe do Produto',
	MAX(UnitPrice) AS 'M�ximo Pre�o'
FROM
	DimProduct
GROUP BY ClassName

------------------------------

/* AULA 04 - GROUP BY mais ORDER BY
Fa�a uma consulta que retorne a soma da quantidade de funcionarios por tipo de loja e filtre por quantidade. */
SELECT * FROM DimStore

SELECT
	StoreType,
	SUM(EmployeeCount) AS 'Qtd. Total Funcion�rios'
FROM
	DimStore
GROUP BY StoreType
ORDER BY SUM(EmployeeCount) DESC

------------------------------

/* AULA 05 - GROUP BY mais WHERE
O comando GROUP BY combinado com o WHERE permite que a tabela principal seja filtrada antes de o agrupamento ser criado.

Fa�a uma consulta que retorne a CONTAGEM do total de produtos por COR, FILTRE os valores pela marca 'Contoso' e fa�a uma ordena��o */
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
O comando GROUP BY combinado com o HAVING permite que a tabela agrupada seja filtrada e que apenas os valores totais que atendam ao crit�rio do HAVING sejam considerados.

Fa�a uma consulta que retorne a quantidade de produtos por MARCA e posteriormente realize um filtro nos dados agrupados para mostrar apenas as marcas com mais de 200 produtos. */
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
� muito importante que fique claro a diferen�a entre os comandos WHERE e HAVING.

Para entender a diferen�a entre os dois, vale lembrar que o GROUP BY permite que a gente crie um agrupamento a partir de uma tabela principal.

O comando WHERE ser� utilizado para filtrar a tabela principal antes de criar o agrupamento.
O comando HAVING ser� utilizado para filtrar a tabela ap�s o agrupamento.

Portanto, podemos entender que:

- O WHERE ser� utilizado antes do agrupamento feito;
- O HAVING ser� um filtro utilizado ap�s o agrupamento feito.

Diferen�as entre WHERE e HAVING na filtragem de tabelas. */
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

-- AULA 08 - Explica��o Exerc�cios
-- AULA 09 - Resolu��o Exerc�cio 01
-- AULA 10 - Resolu��o Exerc�cio 02
-- AULA 11 - Resolu��o Exerc�cio 03
-- AULA 12 - Resolu��o Exerc�cio 04
-- AULA 13 - Resolu��o Exerc�cio 05
-- AULA 14 - Resolu��o Exerc�cio 06
-- AULA 15 - Resolu��o Exerc�cio 07
-- AULA 16 - Resolu��o Exerc�cio 08
-- AULA 17 - Resolu��o Exerc�cio 09
-- AULA 18 - Resolu��o Exerc�cio 10