-- MÓDULO 07 - SQL SERVER - JOINs 


/* AULA 01 - Introdução ao Módulo
Nesse módulo vamos aprender a criar relações entre as tabelas do noss banco de dados.

- Por que precisamos de JOIN?
- Chave Primária vs Chave Estrangeira
- Tabela Fato vs Tabela Dimensão
- Tipos de JOIN
- INNER JOIN			- CROSS JOIN
- LEFT JOIN				- Múltiplos JOIN
- RIGHT JOIN			- UNION e UNION ALL
- FULL JOIN
*/

------------------------------

/* AULA 02 - Por que precisamos do JOIN?
A cláusula JOIN em SQL, é uma operação de junção que combina colunas de uma ou mais tabels em um banco de dados relacional. 
Na linguagem SQL, executamos diversas consultas para gerealmente criar relatórios que serão posteriormente utilizados para análise e tomada de decisão, e para criarmos consultas cada vez mais completas e complexas precisaremos utilizar varias tabelas em conjunto e para isso iremos usar os JOINs. */

-- Para descobrir o ChannelName e juntar com as informações da tabela FactSales, precisariamos da cláusula JOIN, pois na tabela FactSales não temos o ChannelName, apenas o ChannelKey.
SELECT TOP (1000) * FROM FactSales
SELECT * FROM DimChannel


SELECT
	ChannelKey,
	SUM(SalesQuantity) AS 'QTD. Vendida'
FROM
	FactSales
Group BY ChannelKey

-- Se quisermos descobrir as informações de um produto vendido precisariamos da cláusula JOIN para extrair as informações da tabela DimProduct e juntar com as informações da tabela FactSales.
SELECT TOP(1000) * FROM FactSales
SELECT * FROM DimProduct

-- Se quisermos descobrir as informações de um determinado cliente a partir de um registro de compra da tabela FactOnlineSales, precisariamos utilizar a cláusula JOIN, para juntar as informações das tabelas factOnlineSales e DimCustomer.
SELECT TOP(1000) * FROM FactOnlineSales
SELECT * FROM DimCustomer

-- Se quisermos identificar o ScenarioName para juntar com as informações da tabela FactStrategyPlan, precisariamos da cláusula JOIN para juntar as tabelas FactStrategyPlan com a tabela DimScenario
SELECT TOP(100) * FROM FactStrategyPlan
SELECT * FROM DimScenario

------------------------------

/* Aula 03 - Por que não criamos logo uma tabela com todas as informações para facilitar?

Quando estamos trabalhando com um banco de dados grande, como por exemplo, o ContosoRetailDW iremos perceber que algumas consultas a determinadas tabelas irão demorar muito mais tempo do que outras, isso por que, cada tabela possui uma quantidade espefica e única de informações porém, algumas tabelas como as tabelas Fatos possuem uma quantidade enorme de informações, e que ao serem consultadas demoram mais tempo para retornar o resultado da consulta.

Agora, imagine se pegassemos as informações de todas as tabelas e unificassemos em uma única tabela, embora parecesse a primeira vista uma excelente idéia ter todos os dados em um único lugar, na prática dificultaria muito na hora de realizarmos uma consulta, pois algumas informações iriam se repetir milhares ou até milhões de vezes sobrecarregando a planilha em questão e atrapalhando nossas consultas.

Por isso que, ao executarmos uma consulta a tabela FactSales perceberemos 2 tipos de informações.
1. Informações monetárias como: UnitCost, UnitPrice, DiscountAmount, TotalCost, SalesAmount, etc...
2. Informações gerais de ID, como SalesKey, ChannelKey, StoreKey, ProductKey, etc...

Isso ocorre pois cada linha é um registro de venda porém, as informações detalhadas de cada coluna geral é mantida em outra tabela para não sobrecarregar a tabela Fato ainda mais. Informações de produtos, lojas, moedas. etc são armazenadas em outras tabelas e se por ventura for necessário alguma dessas informações poderemos acessá-las utilizando a cláusula JOIN. */ 

SELECT TOP(1000) * FROM FactSales
SELECT * FROM DimProduct

------------------------------

/* AULA 04 - Chave Primária VS. Chave Estrangeira
Uma CHAVE PRIMÁRIA é uma coluna que identifica as informações distintas em uma tabela. Geralmente é uma coluna de ID. Toda tabela terá uma, e somente uma, Chave Primária. Essa chave é utilizada como identificador único da tabela, sendo representada por uma coluna que não receberá valores repetidos.

Uma CHAVE ESTRANGEIRA é uma coluna que permite relacionar as linhas de uma segunda tabela com a Chave Primária de uma primeira tabela.

Como será possível identificar, cada tabela de um banco de dados irá possui uma coluna chamada ID, com valores que não se repetem, geralmente será a coluna1. Essa coluna será a Chave Primária, exemplo (Col1_Tab1). Essa mesma coluna poderá ser vinculada em outra tabela que também terá a sua própria Chave Primária, exemplo (Col1_Tab2), e ao ser vinculada em outra tabela, essa Chave Primária (Col1_Tab1), passará a ser uma Chave Estrangeira na (Tabela 2), pois pertence originalmente a outra tabela (Tabela 1).
*/

------------------------------

/* AULA 05 - Tabela Fato VS. Tabela Dimensão
Uma TABELA DIMENSÃO é uma tabela que contém características de um determinado elemento: lojas, produtos, funcionários, clientes, etc. Nesta tabela, nenhum dos elementos principais irão se repetir. É onde vamos encontrar nossas chaves primárias.

Uma TBELA FATO é uma tabela que vai registrar os fatos ou acontecimentos de uma empresa/negócio em determinados períodos de tempo (vendas, devoluções, aberturas de chamados, receitas, despesas, etc...). Geralmente é uma tabela com milhares de informações e composta essencialmente por colunas de ID usadas para buscar as informações complementares de uma tabela dimensão, conhecidas como chaves estrangeiras.

Obs.: Não necessariamente uma relação acontece entre uma tabela Fato e uma tabela Dimensão. Uma relação pode ocorrer entre 2 ou mais tabelas Dimensão.

Geralmente em um banco de dados, as tabelas Dimensão terão seu nome começando com Dim, exemplo: DimProduct, DimCustomer, DimEmployee, DimDate, DimCalendar, etc.
Por outro lado, as tabelas Fatos terão seu nome iniciando com Fact/Fatos, exemplo: FactSales, FactOnlineSales
*/

------------------------------

/* AULA 06 - Tipos de JOIN - Explicação
Vimos que existem dois tipos de tabelas: Dimensão e Fato. Essas tabelas podem ser relacionadas através de uma coluna na tabela Dimensão, que identificamos como Chave Primária, e que será relacionada com a chave Estrangeira da tabela Fato.

Essas relações serão criadas por meio das cláusulas JOINs. OS JOINs vão nos permitir juntar/unir as nossas tabelas Fato e Dimensão de forma a complementar as informações umas das outras.

Existem diversos tipos de JOINs no SQL: 
- LEFT (OUTER) JOIN
	O LEFT JOIN permite relacionar duas tabelas e criar uma nova tabela. A tabela resultante desse JOIN terá todas as linhas exclusivas da tabela A, mais as linhas que são a interseção entre a tabela A e a tabela B. Nenhuma linha presente apenas na tabela B será incluída na tabela resultante desse JOIN.

- RIGHT (OUTER) JOIN 
	O RIGHT JOIN permite relacionar duas tabelas e criar uma nova tabela. A tabela resultante desse JOIN terá todas as linhas exclusivas da tabela B, mais as linhas que são a interseção entre a tabela A e a tabela B. Nenhuma linha presente apenas na tabela A será incluída na tabela resultante desse JOIN.

- INNER JOIN 
	O INNER JOIN permite relacionar duas tabelas e criar uma nova tabela. A tabela resultante desse JOIN terá apenas as linhas que são a interseção entre a tabela A e a tabela B.

- FULL (OUTER) JOIN 
	O FULL JOIN permite relacionar duas tabelas e criar uma nova tabela. A tabela resultante desse JOIN terá todas as linhas da tabela A e todas as linhas da tabela B.

- LEFT ANTI JOIN 
	O LEFT ANTI JOIN permite relacionar duas tabelas e criar uma nova tabela. A tabela resultande desse JOIN terá apenas as linhas que só existem na tabela A

- RIGHT ANTI JOIN 
	O RIGHT ANTI JOIN permite relacionar duas tabelas e criar uma nova tabela. A tabela resultande desse JOIN terá apenas as linhas que só existem na tabela B

- FULL ANTI JOIN
	O FULL ANTI JOIN permite relacionar duas tabelas e criar uma nova tabela. A tabela resultande desse JOIN terá apenas as linhas que só existem na tabela A ou na tabela B.
*/

------------------------------

/* AULA 07 - LEFT (OUTER) JOIN - Explicação
O LEFT JOIN permite relacionar duas tabelas e criar uma nova tabela. A tabela resultante desse JOIN terá todas as linhas exclusivas da tabela A, mais as linhas que são a interseção entre a tabela A e a tabela B. Nenhuma linha presente apenas na tabela B será incluída na tabela resultante desse JOIN. */

SELECT * FROM DimProduct
SELECT * FROM DimProductSubcategory

SELECT
	DimProduct.ProductKey,
	DimProduct.ProductName,
	DimProduct.ProductSubcategoryKey,
	DimProductSubcategory.ProductSubcategoryName
FROM
	DimProduct
LEFT JOIN DimProductSubcategory
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey

------------------------------

/* AULA 08 - RIGHT (OUTER) JOIN - Explicação
O RIGHT JOIN permite relacionar duas tabelas e criar uma nova tabela. A tabela resultante desse JOIN terá todas as linhas exclusivas da tabela B, mais as linhas que são a interseção entre a tabela A e a tabela B. Nenhuma linha presente apenas na tabela A será incluída na tabela resultante desse JOIN. */

SELECT * FROM DimProduct
SELECT * FROM DimProductSubcategory

SELECT
	DimProduct.ProductKey,
	DimProduct.ProductName,
	DimProduct.ProductSubcategoryKey,
	DimProductSubcategory.ProductSubcategoryName
FROM
	DimProduct
RIGHT JOIN DimProductSubcategory
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey

------------------------------

/* AULA 09 - INNER JOIN - Explicação
O INNER JOIN permite relacionar duas tabelas e criar uma nova tabela. A tabela resultante desse JOIN terá apenas as linhas que são a interseção entre a tabela A e a tabela B. */

SELECT * FROM DimProduct
SELECT * FROM DimProductSubcategory

SELECT
	DimProduct.ProductKey,
	DimProduct.ProductName,
	DimProduct.ProductSubcategoryKey,
	DimProductSubcategory.ProductSubcategoryName
FROM
	DimProduct
INNER JOIN DimProductSubcategory
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey


------------------------------

/* AULA 10 - FULL (OUTER) JOIN - Explicação
O FULL JOIN permite relacionar duas tabelas e criar uma nova tabela. A tabela resultante desse JOIN terá todas as linhas da tabela A e todas as linhas da tabela B. */

SELECT * FROM DimProduct
SELECT * FROM DimProductSubcategory

SELECT
	DimProduct.ProductKey,
	DimProduct.ProductName,
	DimProduct.ProductSubcategoryKey,
	DimProductSubcategory.ProductSubcategoryName
FROM
	DimProduct
FULL JOIN DimProductSubcategory
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey

------------------------------

/* AULA 11 - LEFT, RIGHT e FULL ANTI JOIN - Explicação
O LEFT ANTI JOIN permite relacionar duas tabelas e criar uma nova tabela.
A tabela resultande desse JOIN terá apenas as linhas que só existem na tabela A */

SELECT * FROM DimProduct
SELECT * FROM DimProductSubcategory

SELECT
	DimProduct.ProductKey,
	DimProduct.ProductName,
	DimProduct.ProductSubcategoryKey,
	DimProductSubcategory.ProductSubcategoryName
FROM
	DimProduct
LEFT JOIN DimProductSubcategory
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
-- WHERE nome_subcategoria IS NULL


/* O RIGHT ANTI JOIN permite relacionar duas tabelas e criar uma nova tabela.
A tabela resultande desse JOIN terá apenas as linhas que só existem na tabela B */

SELECT * FROM DimProduct
SELECT * FROM DimProductSubcategory

SELECT
	DimProduct.ProductKey,
	DimProduct.ProductName,
	DimProduct.ProductSubcategoryKey,
	DimProductSubcategory.ProductSubcategoryName
FROM
	DimProduct
RIGHT JOIN DimProductSubcategory
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
-- WHERE id_pruduto IS NULL


/* O FULL ANTI JOIN permite relacionar duas tabelas e criar uma nova tabela.
A tabela resultande desse JOIN terá apenas as linhas que só existem na tabela A ou na tabela B. */

SELECT * FROM DimProduct
SELECT * FROM DimProductSubcategory

SELECT
	DimProduct.ProductKey,
	DimProduct.ProductName,
	DimProduct.ProductSubcategoryKey,
	DimProductSubcategory.ProductSubcategoryName
FROM
	DimProduct
FULL JOIN DimProductSubcategory
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
-- WHERE id_produto IS NULL OR nome_subtagoria IS NULL

------------------------------

/*AULA 12 - LEFT, RIGHT, INNER JOIN e ANTI JOIN - Exemplos
A estrutura de um LEFT JOIN, RIGHT JOIN OU INNER JOIN é muito semelhante, apenas trocamos o JOIN. 

Lembrando que: 
Um LEFT JOIN retorna todas as linhas da tabela A (esquerda) mais as linhas que são a interseção entre a Tabela A e a Tabela B.

Um RIGHT JOIN retorna todas as linhas da tabela B (direita) mais as linhas que são a interseção entre a Tabela A e a Tabela B.

Um INNER JOIN retorna somente as linhas que são a interseção entre as tabelas A e B.

Um LEFT ANTI JOIN não existe como cláusula pois necessita ser usado com o WHERE, onde consideramos os valores NULL

Um RIGHT ANTI JOIN não existe como cláusula pois necessita ser usado com o WHERE, onde consideramos os valores NULL

Um FULL ANTI JOIN não existe como cláusula pois necessita ser usado com o WHERE, onde consideramos os valores NULL

Na prática, os JOINs (ANTI) sempre serão uma combinação entre JOINs 'normais' com o WHERE, onde consideramos os  valores nulos.
*/
SELECT ProductKey, ProductName, ProductSubcategoryKey FROM DimProduct
SELECT ProductSubcategoryKey, ProductSubcategoryName FROM DimProductSubcategory

SELECT
	ProductKey,
	ProductName,
	DimProduct.ProductSubcategoryKey,
	ProductSubcategoryName
FROM
	DimProduct
INNER JOIN DimProductSubcategory -- LEFT JOIN e RIGHT JOIN
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
	-- WHERE DimProductSubcategoryKey IS NULL

------------------------------

-- AULA 13 - Como definir quem é a LEFT TABLE e quem é a RIGHT TABLE
-- 1. LEFT JOIN para completar informações da tabela produtos (LEFT) de acordo com a tabela de categoria (RIGHT)
SELECT
	DimProduct.ProductKey,
	DimProduct.ProductName,
	DimProduct.ProductSubcategoryKey,
	DimProductSubcategory.ProductSubcategoryName
FROM
	DimProduct
LEFT JOIN DimProductSubcategory
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey

-- 2. Obtendo o LEFT JOIN do caso 1 usando um RIGHT JOIN e invertendo as tabelas de lado
SELECT
	DimProduct.ProductKey,
	DimProduct.ProductName,
	DimProduct.ProductSubcategoryKey,
	DimProductSubcategory.ProductSubcategoryName
FROM
	DimProductSubcategory -- Era DimProduct alterou para DimProductSubcategory
RIGHT JOIN DimProduct -- Era LEFT JOIN DimProductSubcategory e alterou para RIGHT JOIN DimProduct
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey

-- OBS: O mais comum é utilizar a primeira estrutura com o LEFT JOIN pois assim será mais fácil e intuitivo de ler porém, nada impede de usar a segunda estrutura, só tomar o cuidado de se quiser visualizar as informações a partir da tabela B ou direita, utilizar o RIGHT JOIN.

------------------------------

/* AULA 14 - INNER JOIN ou LEFT JOIN - Qual usar?
O LEFT e o INNER são os JOINs mais utilizados dentre todos os que são possíveis utilizar. E a dúvida de qual utilizar vai depender do resultado final que quer obter.
Lembrando que, o LEFT JOIN vai retornar todas as linhas da tabela A independente se alguma linha não está na tabela B.
O INNER JOIN só irá retornar as linhas que contém informações em ambas as tabelas, ou seja, nenhuma informação NULL será apresentada. 

Situação 1:
Se a Tabela A (esquerda) possui os produtos de 1 à 10, e na Tabela B (deireita) também temos os produtos de 1 à 10, se fizermos um INNER JOIN ou um LEFT JOIN, teremos o mesmo resultado, visto que, não há em nenhum produto que exista em uma tabela porém, não exista em outra.

Situação 2:
Se a Tabela A (esquerda) possui os produtos de 1 à 11, e na Tabela B (direita) temos apenas os produtos de 1 à 10, isso quer dizer que existe um produto na Tabela A que não existe na Tabela B, logo: Se usarmos o LEFT JOIN, a tabela resultante terá um produto a mais (o que existe apenas na Tabela A (esquerda)), enquanto o INNER JOIN retornará apenas os produtos que estão presentes em ambas as tabelas, portanto não incluirá na tabela resultante o produto que só existe da Tabela A (esquerda)
*/

------------------------------

/* AULA 15 - CROSS JOIN
Um outro JOIN que pode ser útil é o CROSS JOIN.

Com este JOIN, conseguimos criar uma tabela que é a combinação de TODOS os valores entre duas colunas.

A combinação resultante desse JOIN é conhecida como produto cartesiano, uma combinação um a um de todos os valores de duas ou mais colunas.
*/

SELECT DISTINCT BrandName FROM DimProduct 
SELECT * FROM DimProductCategory

SELECT DISTINCT
	BrandName,
	ProductCategoryName
FROM DimProduct CROSS JOIN DimProductCategory

------------------------------

/* AULA 16 - MÚLTIPLOS JOINs
Em algumas situações precisaremos utilizar múltiplos JOINs para conseguir criar nossa tabela com as informações que necessitados.

Por exemplo: No banco de dados ContosoRetailDW, temos uma tabela chamada DimProduct, que contém as informações dos produtos. 
Porém, essa tabela não possui informações das categorias desses produtos, apenas as informações de IDs das subcategorias.
Portanto, sabemos apenas de forma indireta qual é a categoria do produto. 
De acordo com o ID da subcategoria, conseguimos descobrir qual é o nome da categoria do produto. Para isso, teremos que fazer um JOIN entre a tabela DimProduct com a tabela DimProductSubcategory e depois outro JOIN da tabela DimProductSubcategory com a tabela DimProductCategory. */


SELECT ProductKey, ProductName, ProductSubcategoryKey FROM DimProduct
SELECT ProductSubcategoryKey, ProductSubcategoryName, ProductCategoryKey FROM DimProductSubcategory
SELECT ProductCategoryKey, ProductCategoryName FROM DimProductCategory

SELECT
	ProductKey,
	ProductName,
	DimProduct.ProductSubcategoryKey,
	ProductCategoryName
FROM
	DimProduct
INNER JOIN DimProductSubcategory
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
		INNER JOIN DimProductCategory
			ON DimProductSubcategory.ProductCategoryKey = DimProductCategory.ProductCategoryKey

------------------------------

/* AULA 17 - UNION e UNION ALL
Existem outros dois comandos que usamos para junção de tabelas: UNION e UNION ALL. Estes dois permitem a junção de duas ou mais tabelas, como se estivéssemos empilhando as tabelas uma sobre a outra, ou seja, coloando uma tabela em cima da outra.*/

-- Se você tiver duas colunas com exatamente as mesmas informações e que você gostaria de unificar em uma única tabela, poderá utilizar o UNION, exemplo se a tabela DimCustomer estivesse separada em duas tabelas (Masculino e Feminino)
-- UNION
SELECT * FROM DimCustomer WHERE Gender = 'F'
UNION -- Entre as consultas incluíra o UNION
SELECT * FROM DimCustomer WHERE Gender = 'M'

-- UNION ALL
-- Se fosse utilizar o UNION teriamos linhas excluídas pois o UNION excluí informações duplicadas e nesse caso teriamos pessoas do sexo M e F com o mesmo primeiro nome e mesmo dia de aniversário
SELECT FirstName, BirthDate FROM DimCustomer WHERE Gender = 'F'
UNION ALL -- Entre as consultas incluíra o UNION ALL
SELECT FirstName, BirthDate FROM DimCustomer WHERE Gender = 'M'

-- UNION juntará as tabelas mas removerá as linhas duplicadas.
-- UNION ALL juntará as tabelas porém, manterá todas as informações de ambas as tabelas.

------------------------------

-- AULA 18 - Explicação Exercícios
-- AULA 19 - Resolução Exercício 01
-- AULA 20 - Resolução Exercício 02
-- AULA 21 - Resolução Exercício 03
-- AULA 22 - Resolução Exercício 04
-- AULA 23 - Resolução Exercício 05
-- AULA 24 - Resolução Exercício 06
-- AULA 25 - Resolução Exercício 07
-- AULA 26 - Resolução Exercício 08
-- AULA 27 - Resolução Exercício 09
-- AULA 28 - Resolução Exercício 10
