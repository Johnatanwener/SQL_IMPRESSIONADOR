-- M�DULO 07 - SQL SERVER - JOINs 


/* AULA 01 - Introdu��o ao M�dulo
Nesse m�dulo vamos aprender a criar rela��es entre as tabelas do noss banco de dados.

- Por que precisamos de JOIN?
- Chave Prim�ria vs Chave Estrangeira
- Tabela Fato vs Tabela Dimens�o
- Tipos de JOIN
- INNER JOIN			- CROSS JOIN
- LEFT JOIN				- M�ltiplos JOIN
- RIGHT JOIN			- UNION e UNION ALL
- FULL JOIN
*/

------------------------------

/* AULA 02 - Por que precisamos do JOIN?
A cl�usula JOIN em SQL, � uma opera��o de jun��o que combina colunas de uma ou mais tabels em um banco de dados relacional. 
Na linguagem SQL, executamos diversas consultas para gerealmente criar relat�rios que ser�o posteriormente utilizados para an�lise e tomada de decis�o, e para criarmos consultas cada vez mais completas e complexas precisaremos utilizar varias tabelas em conjunto e para isso iremos usar os JOINs. */

-- Para descobrir o ChannelName e juntar com as informa��es da tabela FactSales, precisariamos da cl�usula JOIN, pois na tabela FactSales n�o temos o ChannelName, apenas o ChannelKey.
SELECT TOP (1000) * FROM FactSales
SELECT * FROM DimChannel


SELECT
	ChannelKey,
	SUM(SalesQuantity) AS 'QTD. Vendida'
FROM
	FactSales
Group BY ChannelKey

-- Se quisermos descobrir as informa��es de um produto vendido precisariamos da cl�usula JOIN para extrair as informa��es da tabela DimProduct e juntar com as informa��es da tabela FactSales.
SELECT TOP(1000) * FROM FactSales
SELECT * FROM DimProduct

-- Se quisermos descobrir as informa��es de um determinado cliente a partir de um registro de compra da tabela FactOnlineSales, precisariamos utilizar a cl�usula JOIN, para juntar as informa��es das tabelas factOnlineSales e DimCustomer.
SELECT TOP(1000) * FROM FactOnlineSales
SELECT * FROM DimCustomer

-- Se quisermos identificar o ScenarioName para juntar com as informa��es da tabela FactStrategyPlan, precisariamos da cl�usula JOIN para juntar as tabelas FactStrategyPlan com a tabela DimScenario
SELECT TOP(100) * FROM FactStrategyPlan
SELECT * FROM DimScenario

------------------------------

/* Aula 03 - Por que n�o criamos logo uma tabela com todas as informa��es para facilitar?

Quando estamos trabalhando com um banco de dados grande, como por exemplo, o ContosoRetailDW iremos perceber que algumas consultas a determinadas tabelas ir�o demorar muito mais tempo do que outras, isso por que, cada tabela possui uma quantidade espefica e �nica de informa��es por�m, algumas tabelas como as tabelas Fatos possuem uma quantidade enorme de informa��es, e que ao serem consultadas demoram mais tempo para retornar o resultado da consulta.

Agora, imagine se pegassemos as informa��es de todas as tabelas e unificassemos em uma �nica tabela, embora parecesse a primeira vista uma excelente id�ia ter todos os dados em um �nico lugar, na pr�tica dificultaria muito na hora de realizarmos uma consulta, pois algumas informa��es iriam se repetir milhares ou at� milh�es de vezes sobrecarregando a planilha em quest�o e atrapalhando nossas consultas.

Por isso que, ao executarmos uma consulta a tabela FactSales perceberemos 2 tipos de informa��es.
1. Informa��es monet�rias como: UnitCost, UnitPrice, DiscountAmount, TotalCost, SalesAmount, etc...
2. Informa��es gerais de ID, como SalesKey, ChannelKey, StoreKey, ProductKey, etc...

Isso ocorre pois cada linha � um registro de venda por�m, as informa��es detalhadas de cada coluna geral � mantida em outra tabela para n�o sobrecarregar a tabela Fato ainda mais. Informa��es de produtos, lojas, moedas. etc s�o armazenadas em outras tabelas e se por ventura for necess�rio alguma dessas informa��es poderemos acess�-las utilizando a cl�usula JOIN. */ 

SELECT TOP(1000) * FROM FactSales
SELECT * FROM DimProduct

------------------------------

/* AULA 04 - Chave Prim�ria VS. Chave Estrangeira
Uma CHAVE PRIM�RIA � uma coluna que identifica as informa��es distintas em uma tabela. Geralmente � uma coluna de ID. Toda tabela ter� uma, e somente uma, Chave Prim�ria. Essa chave � utilizada como identificador �nico da tabela, sendo representada por uma coluna que n�o receber� valores repetidos.

Uma CHAVE ESTRANGEIRA � uma coluna que permite relacionar as linhas de uma segunda tabela com a Chave Prim�ria de uma primeira tabela.

Como ser� poss�vel identificar, cada tabela de um banco de dados ir� possui uma coluna chamada ID, com valores que n�o se repetem, geralmente ser� a coluna1. Essa coluna ser� a Chave Prim�ria, exemplo (Col1_Tab1). Essa mesma coluna poder� ser vinculada em outra tabela que tamb�m ter� a sua pr�pria Chave Prim�ria, exemplo (Col1_Tab2), e ao ser vinculada em outra tabela, essa Chave Prim�ria (Col1_Tab1), passar� a ser uma Chave Estrangeira na (Tabela 2), pois pertence originalmente a outra tabela (Tabela 1).
*/

------------------------------

/* AULA 05 - Tabela Fato VS. Tabela Dimens�o
Uma TABELA DIMENS�O � uma tabela que cont�m caracter�sticas de um determinado elemento: lojas, produtos, funcion�rios, clientes, etc. Nesta tabela, nenhum dos elementos principais ir�o se repetir. � onde vamos encontrar nossas chaves prim�rias.

Uma TBELA FATO � uma tabela que vai registrar os fatos ou acontecimentos de uma empresa/neg�cio em determinados per�odos de tempo (vendas, devolu��es, aberturas de chamados, receitas, despesas, etc...). Geralmente � uma tabela com milhares de informa��es e composta essencialmente por colunas de ID usadas para buscar as informa��es complementares de uma tabela dimens�o, conhecidas como chaves estrangeiras.

Obs.: N�o necessariamente uma rela��o acontece entre uma tabela Fato e uma tabela Dimens�o. Uma rela��o pode ocorrer entre 2 ou mais tabelas Dimens�o.

Geralmente em um banco de dados, as tabelas Dimens�o ter�o seu nome come�ando com Dim, exemplo: DimProduct, DimCustomer, DimEmployee, DimDate, DimCalendar, etc.
Por outro lado, as tabelas Fatos ter�o seu nome iniciando com Fact/Fatos, exemplo: FactSales, FactOnlineSales
*/

------------------------------

/* AULA 06 - Tipos de JOIN - Explica��o
Vimos que existem dois tipos de tabelas: Dimens�o e Fato. Essas tabelas podem ser relacionadas atrav�s de uma coluna na tabela Dimens�o, que identificamos como Chave Prim�ria, e que ser� relacionada com a chave Estrangeira da tabela Fato.

Essas rela��es ser�o criadas por meio das cl�usulas JOINs. OS JOINs v�o nos permitir juntar/unir as nossas tabelas Fato e Dimens�o de forma a complementar as informa��es umas das outras.

Existem diversos tipos de JOINs no SQL: 
- LEFT (OUTER) JOIN
	O LEFT JOIN permite relacionar duas tabelas e criar uma nova tabela. A tabela resultante desse JOIN ter� todas as linhas exclusivas da tabela A, mais as linhas que s�o a interse��o entre a tabela A e a tabela B. Nenhuma linha presente apenas na tabela B ser� inclu�da na tabela resultante desse JOIN.

- RIGHT (OUTER) JOIN 
	O RIGHT JOIN permite relacionar duas tabelas e criar uma nova tabela. A tabela resultante desse JOIN ter� todas as linhas exclusivas da tabela B, mais as linhas que s�o a interse��o entre a tabela A e a tabela B. Nenhuma linha presente apenas na tabela A ser� inclu�da na tabela resultante desse JOIN.

- INNER JOIN 
	O INNER JOIN permite relacionar duas tabelas e criar uma nova tabela. A tabela resultante desse JOIN ter� apenas as linhas que s�o a interse��o entre a tabela A e a tabela B.

- FULL (OUTER) JOIN 
	O FULL JOIN permite relacionar duas tabelas e criar uma nova tabela. A tabela resultante desse JOIN ter� todas as linhas da tabela A e todas as linhas da tabela B.

- LEFT ANTI JOIN 
	O LEFT ANTI JOIN permite relacionar duas tabelas e criar uma nova tabela. A tabela resultande desse JOIN ter� apenas as linhas que s� existem na tabela A

- RIGHT ANTI JOIN 
	O RIGHT ANTI JOIN permite relacionar duas tabelas e criar uma nova tabela. A tabela resultande desse JOIN ter� apenas as linhas que s� existem na tabela B

- FULL ANTI JOIN
	O FULL ANTI JOIN permite relacionar duas tabelas e criar uma nova tabela. A tabela resultande desse JOIN ter� apenas as linhas que s� existem na tabela A ou na tabela B.
*/

------------------------------

/* AULA 07 - LEFT (OUTER) JOIN - Explica��o
O LEFT JOIN permite relacionar duas tabelas e criar uma nova tabela. A tabela resultante desse JOIN ter� todas as linhas exclusivas da tabela A, mais as linhas que s�o a interse��o entre a tabela A e a tabela B. Nenhuma linha presente apenas na tabela B ser� inclu�da na tabela resultante desse JOIN. */

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

/* AULA 08 - RIGHT (OUTER) JOIN - Explica��o
O RIGHT JOIN permite relacionar duas tabelas e criar uma nova tabela. A tabela resultante desse JOIN ter� todas as linhas exclusivas da tabela B, mais as linhas que s�o a interse��o entre a tabela A e a tabela B. Nenhuma linha presente apenas na tabela A ser� inclu�da na tabela resultante desse JOIN. */

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

/* AULA 09 - INNER JOIN - Explica��o
O INNER JOIN permite relacionar duas tabelas e criar uma nova tabela. A tabela resultante desse JOIN ter� apenas as linhas que s�o a interse��o entre a tabela A e a tabela B. */

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

/* AULA 10 - FULL (OUTER) JOIN - Explica��o
O FULL JOIN permite relacionar duas tabelas e criar uma nova tabela. A tabela resultante desse JOIN ter� todas as linhas da tabela A e todas as linhas da tabela B. */

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

/* AULA 11 - LEFT, RIGHT e FULL ANTI JOIN - Explica��o
O LEFT ANTI JOIN permite relacionar duas tabelas e criar uma nova tabela.
A tabela resultande desse JOIN ter� apenas as linhas que s� existem na tabela A */

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
A tabela resultande desse JOIN ter� apenas as linhas que s� existem na tabela B */

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
A tabela resultande desse JOIN ter� apenas as linhas que s� existem na tabela A ou na tabela B. */

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
A estrutura de um LEFT JOIN, RIGHT JOIN OU INNER JOIN � muito semelhante, apenas trocamos o JOIN. 

Lembrando que: 
Um LEFT JOIN retorna todas as linhas da tabela A (esquerda) mais as linhas que s�o a interse��o entre a Tabela A e a Tabela B.

Um RIGHT JOIN retorna todas as linhas da tabela B (direita) mais as linhas que s�o a interse��o entre a Tabela A e a Tabela B.

Um INNER JOIN retorna somente as linhas que s�o a interse��o entre as tabelas A e B.

Um LEFT ANTI JOIN n�o existe como cl�usula pois necessita ser usado com o WHERE, onde consideramos os valores NULL

Um RIGHT ANTI JOIN n�o existe como cl�usula pois necessita ser usado com o WHERE, onde consideramos os valores NULL

Um FULL ANTI JOIN n�o existe como cl�usula pois necessita ser usado com o WHERE, onde consideramos os valores NULL

Na pr�tica, os JOINs (ANTI) sempre ser�o uma combina��o entre JOINs 'normais' com o WHERE, onde consideramos os  valores nulos.
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

-- AULA 13 - Como definir quem � a LEFT TABLE e quem � a RIGHT TABLE
-- 1. LEFT JOIN para completar informa��es da tabela produtos (LEFT) de acordo com a tabela de categoria (RIGHT)
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

-- OBS: O mais comum � utilizar a primeira estrutura com o LEFT JOIN pois assim ser� mais f�cil e intuitivo de ler por�m, nada impede de usar a segunda estrutura, s� tomar o cuidado de se quiser visualizar as informa��es a partir da tabela B ou direita, utilizar o RIGHT JOIN.

------------------------------

/* AULA 14 - INNER JOIN ou LEFT JOIN - Qual usar?
O LEFT e o INNER s�o os JOINs mais utilizados dentre todos os que s�o poss�veis utilizar. E a d�vida de qual utilizar vai depender do resultado final que quer obter.
Lembrando que, o LEFT JOIN vai retornar todas as linhas da tabela A independente se alguma linha n�o est� na tabela B.
O INNER JOIN s� ir� retornar as linhas que cont�m informa��es em ambas as tabelas, ou seja, nenhuma informa��o NULL ser� apresentada. 

Situa��o 1:
Se a Tabela A (esquerda) possui os produtos de 1 � 10, e na Tabela B (deireita) tamb�m temos os produtos de 1 � 10, se fizermos um INNER JOIN ou um LEFT JOIN, teremos o mesmo resultado, visto que, n�o h� em nenhum produto que exista em uma tabela por�m, n�o exista em outra.

Situa��o 2:
Se a Tabela A (esquerda) possui os produtos de 1 � 11, e na Tabela B (direita) temos apenas os produtos de 1 � 10, isso quer dizer que existe um produto na Tabela A que n�o existe na Tabela B, logo: Se usarmos o LEFT JOIN, a tabela resultante ter� um produto a mais (o que existe apenas na Tabela A (esquerda)), enquanto o INNER JOIN retornar� apenas os produtos que est�o presentes em ambas as tabelas, portanto n�o incluir� na tabela resultante o produto que s� existe da Tabela A (esquerda)
*/

------------------------------

/* AULA 15 - CROSS JOIN
Um outro JOIN que pode ser �til � o CROSS JOIN.

Com este JOIN, conseguimos criar uma tabela que � a combina��o de TODOS os valores entre duas colunas.

A combina��o resultante desse JOIN � conhecida como produto cartesiano, uma combina��o um a um de todos os valores de duas ou mais colunas.
*/

SELECT DISTINCT BrandName FROM DimProduct 
SELECT * FROM DimProductCategory

SELECT DISTINCT
	BrandName,
	ProductCategoryName
FROM DimProduct CROSS JOIN DimProductCategory

------------------------------

/* AULA 16 - M�LTIPLOS JOINs
Em algumas situa��es precisaremos utilizar m�ltiplos JOINs para conseguir criar nossa tabela com as informa��es que necessitados.

Por exemplo: No banco de dados ContosoRetailDW, temos uma tabela chamada DimProduct, que cont�m as informa��es dos produtos. 
Por�m, essa tabela n�o possui informa��es das categorias desses produtos, apenas as informa��es de IDs das subcategorias.
Portanto, sabemos apenas de forma indireta qual � a categoria do produto. 
De acordo com o ID da subcategoria, conseguimos descobrir qual � o nome da categoria do produto. Para isso, teremos que fazer um JOIN entre a tabela DimProduct com a tabela DimProductSubcategory e depois outro JOIN da tabela DimProductSubcategory com a tabela DimProductCategory. */


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
Existem outros dois comandos que usamos para jun��o de tabelas: UNION e UNION ALL. Estes dois permitem a jun��o de duas ou mais tabelas, como se estiv�ssemos empilhando as tabelas uma sobre a outra, ou seja, coloando uma tabela em cima da outra.*/

-- Se voc� tiver duas colunas com exatamente as mesmas informa��es e que voc� gostaria de unificar em uma �nica tabela, poder� utilizar o UNION, exemplo se a tabela DimCustomer estivesse separada em duas tabelas (Masculino e Feminino)
-- UNION
SELECT * FROM DimCustomer WHERE Gender = 'F'
UNION -- Entre as consultas inclu�ra o UNION
SELECT * FROM DimCustomer WHERE Gender = 'M'

-- UNION ALL
-- Se fosse utilizar o UNION teriamos linhas exclu�das pois o UNION exclu� informa��es duplicadas e nesse caso teriamos pessoas do sexo M e F com o mesmo primeiro nome e mesmo dia de anivers�rio
SELECT FirstName, BirthDate FROM DimCustomer WHERE Gender = 'F'
UNION ALL -- Entre as consultas inclu�ra o UNION ALL
SELECT FirstName, BirthDate FROM DimCustomer WHERE Gender = 'M'

-- UNION juntar� as tabelas mas remover� as linhas duplicadas.
-- UNION ALL juntar� as tabelas por�m, manter� todas as informa��es de ambas as tabelas.

------------------------------

-- AULA 18 - Explica��o Exerc�cios
-- AULA 19 - Resolu��o Exerc�cio 01
-- AULA 20 - Resolu��o Exerc�cio 02
-- AULA 21 - Resolu��o Exerc�cio 03
-- AULA 22 - Resolu��o Exerc�cio 04
-- AULA 23 - Resolu��o Exerc�cio 05
-- AULA 24 - Resolu��o Exerc�cio 06
-- AULA 25 - Resolu��o Exerc�cio 07
-- AULA 26 - Resolu��o Exerc�cio 08
-- AULA 27 - Resolu��o Exerc�cio 09
-- AULA 28 - Resolu��o Exerc�cio 10
