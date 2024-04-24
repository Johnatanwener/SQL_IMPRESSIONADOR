-- M�dulo 14 - SQL SERVER - Subqueries e CTE's


/* AULA 01 - Introdu��o ao M�dulo
Nesse m�dulo vamos aprender a criar subqueries no SQL.

- O que � uma subquery
- Aplica��es de subqueries
- Subquery aninhada
- Subquery correlacionada
- CTE's: Common Table Expression */

------------------------------

/* AULA 02 - O que � uma Subquert e onde usamos

1. O que � uma Subquery?
Uma Subconsulta (ou Subquery ou SubSELECT) nada mais � do que uma consulta dentro de outra consulta. Ou seja, com uma subquery conseguimos utilizar o resultado de uma query (consulta) dentro de outra consulta.

2. Onde utilizamos uma Subquery
Subqueries podem ser utilizadas em 4 situa��es poss�veis:
1. Subqueries com WHERE (escalar): Nesta situa��o, utilizamos o resultado de um SELECT para filtrar um outro SELECT; Para este caso, utilizamos o termo 'escalar, para dizer que o resultado do SELECT mais interno � um valor �nico, e n�o uma lista de valores.
2. Subqueries com WHERE (lista): Aqui temos uma situa��o semelhante � anterior, com a diferen�a de que o resultado subquery seria uma lista de v�rios valores que poderiam ser passados no WHERE. NEse caso, como o filtro seria de mais de 1 valor, utilizamos o IN.
3. Subqueries dentro de um SELECT: Outra op��o seria utilizar o resultado de um SELECT como uma nova coluna de uma query principal.
4. Subqueries junto com um FROM: Podemos utilizar o resultado de um SELECT como uma tabela de um outro SELECT. Neste caso, precisamos utilizar o comando AS para dar um nome para essa tabela. */

-- 1. Subquery junto com um WHERE, como um filtro din�mico e escalar (valor �nico)
SELECT
	Coluna1,
	Coluna2
FROM Tabela
WHERE Coluna1 = (SELECT)

-- 2. Subquery junto com um WHERE, como um filtro din�mico e em lista (v�rios valores)
SELECT
	Coluna1,
	Coluna2
FROM Tabela
WHERE Coluna1 IN (SELECT)

-- 3- Subquery junto com um SELECT, como uma nova coluna
SELECT
	Coluna1,
	Coluna2,
	(SELECT)
FROM Tabela
	
-- 4. Subquery junto com um FROM, como uma nova tabela
SELECT
	Coluna1,
	Coluna2
FROM (SELECT) AS T


-- Ex: Imagina que eu quero selecionar os produtos com o Pre�o maior do que a m�dia. */
-- 1� Passo:  Descobrir a m�dia
SELECT AVG(UnitPrice) From DimProduct

-- 2� Passo: Filtrar a nossa tabela, utilizando o WHERE
SELECT
	*
FROM DimProduct
WHERE UnitPrice > 356.8301 -- Ao inv�s de colar o resultado da consulta anterior, eu escrevo a consulta anterior, dentro do WHERE entre ()

-- Fazer isso n�o � muito autom�tico, pois escrevemos manualmente  m�dia de pre�o no filtro. Se os pre�os alterarem ou se tivermos adi��o ou exclus�o de protuos, essa filtragem n�o ser� autom�tica. O valor de 356.8301 continuar� fixo mesmo que a m�dia se altere. O ideal ent�o, seria utilizar uma subquery, substituindo o valor fixo de 356.8301 pelo SELECT que criamos para descobrir essa m�dia:
SELECT
	*
FROM DimProduct
WHERE UnitPrice > (SELECT AVG(UnitPrice) From DimProduct)

-- Obs.: Na solu��o acima, utilizamos uma subquery, ou seja, um SELECT dentro de outro SELECT. Dessa forma, o c�lculo da m�dia de pre�o ficar� 100% autom�tico, sem a necessidade de atualizar manualmente o valor.

------------------------------

/* AULA 03, 04 e 05 - Subquery na pr�tica (Aplica��o com o WHERE)
Para entender a ideia por tr�s das subqueries, vamos come�ar fazendo 3 exemplos com a aplica��o WHERE.

Exemplo 1: Quais produtos da tabela DimProduct possuem custos acima da m�dia? */
SELECT AVG(UnitCost) FROM DimProduct     -- 147.6555

SELECT
	*
FROM
	DimProduct
WHERE UnitCost >= (SELECT AVG(UnitCost) FROM DimProduct)

/* Exemplo 2: Fa�a uma consulta para retornar os produtos da categoria 'Televisions'. Tome cuidado pois n�o temos a informa��o de Nome da Subcategoria na tabela DimProduct. Dessa forma, precisaremos criar um SELECT que descubra o ID da categoria 'Televisions' e passar esse resultado como o valor que queremos filtrar dentro do WHERE. */
SELECT * FROM DimProduct
WHERE ProductSubcategoryKey = 
	(SELECT ProductSubcategoryKey FROM DimProductSubcategory
		WHERE ProductSubcategoryName = 'Televisions')


/* Exemplo 3: Filtre a tabela FactSales e mostre apenas as vendas referentes �s lojas com 100 ou mais funcion�rios */
SELECT	StoreKey FROM DimStore WHERE EmployeeCount >= 100
SELECT * FROM FactSales WHERE StoreKey IN (199, 200, 289)
-- Ao inv�s de fazer a consulta igual acima, poderemos automatizar o filtro da seguinte forma:

SELECT * FROM FactSales
WHERE StoreKey IN (
	SELECT	StoreKey
	FROM DimStore
	WHERE EmployeeCount >= 100
)

------------------------------

/*AULA 06 - ANY, SOME e ALL
Os operadores ANY e SOME s�o equivalentes e permitem realizar uma compara��o entre um �nico valor de uma coluna e um intervalo de outros valors. O =ANY e o =SOME s�o equivalentes. Quando usados com o sinal l�gico '=', eles possuem a mesma finalidade do operador IN, permitindo retornar todas as linhas que sejam iguais � lista de valores especificados. */

CREATE TABLE funcionarios(
id_funcionario INT,
nome VARCHAR(50),
idade INT,
sexo VARCHAR(50))

INSERT INTO funcionarios(id_funcionario, nome, idade, sexo)
VALUES	
	(1, 'Julia', 20, 'F'),
	(2, 'Daniel', 21, 'M'),
	(3, 'Amanda', 22, 'F'),
	(4, 'Pedro', 23, 'M'),
	(5, 'Andr�', 24, 'M'),
	(6, 'Luisa', 25, 'F')

SELECT * FROM funcionarios

-- Selecione os funcion�rios do sexo masculino (MAS, utilizando a coluna de IDADE para isso)
SELECT * FROM funcionarios
WHERE idade IN (21, 23, 24)

SELECT * FROM funcionarios
WHERE idade IN (SELECT idade FROM funcionarios WHERE sexo = 'M')

/* = ANY(valor1, valor2, valor3) :
Equivalente ao IN, retorna as linhas da tabela que sejam iguais ao valor1, OU valor2, OU valor3 */
SELECT * FROM funcionarios
WHERE idade = ANY (SELECT idade FROM funcionarios WHERE sexo = 'M')

/* > ANY(valor1, valor2, valor3) :
Retorna as linhas da tabela com valores maiores que o valor1, OU valor2, OU valor3. Ou seja, maior que o m�nimo dos valores */
SELECT * FROM funcionarios
WHERE idade > ANY (SELECT idade FROM funcionarios WHERE sexo = 'M')

/* < ANY(valor1, valor2, valor3) :
Retorna as linhas da tabela com valores maiores que o valor1, OU valor2, OU valor3. Ou seja, maior que o m�ximo dos valores */
SELECT * FROM funcionarios
WHERE idade < ANY (SELECT idade FROM funcionarios WHERE sexo = 'M')

-- Obs.: O ANY � = ao SOME. Ou seja, poderia utilizar o SOME em qualquer uma das op��es acima, ao inv�s de ANY.

/* 
O operador ALL tamb�m permite uma compara��o entre valores especificados, mas para que a consulta retorne algum resultado, � necess�rio que o valor comparado seja maior ou menor do que TODOS os valores da lista. (Obs.: Dificilmente utilizamos o =ALL pois estar�amos comparando um valor e esperando que ele fosse igual a todos os valores da lista. A menos que todos os valores da lista fossem iguais, o =ALL n�o faria sentido)

Exemplo:
> ALL(valor1, valor2, valor3) :
	Retorna as linhas da tabela com valores maiores que o valor1, E valor2, E valor3. Ou seja, maior que o m�ximo dos valores */
SELECT * FROM funcionarios
WHERE idade < ALL (SELECT idade FROM funcionarios WHERE sexo = 'M')

/* < ALL(valor1, valor2, valor3) :
Retorna as linhas da tabela com valores menores que o valor1, E valor2, E valor3. Ou seja, menor que o m�nimo dos valores
*/
SELECT * FROM funcionarios
WHERE idade > ALL (SELECT idade FROM funcionarios WHERE sexo = 'M')

------------------------------

/* AULA 07 e 08 - EXISTS
O operador EXISTS � usado para testar a exist�ncia de qualquer registro (linha) em uma subconsulta.
Pensando em um exemplo pr�tico, imagina que queiramos descobrir quais s�o os produtos que possuem vendas em um determinado dia.

Exemplo: Retornar uma tabela com todos os produtos (ID Produto e Nome Produto) que possuem alguma venda no dia 01/01/2007 */

-- Conta a quantidade de Produtos
SELECT COUNT(*) FROM DimProduct -- 2.517 produtos
SELECT TOP(100) * FROM FactSales

-- Retorna uma tabela com todos os produtos que possuem alguma venda
SELECT
	ProductKey,
	ProductName
FROM	
	DimProduct
WHERE EXISTS(
	SELECT
		ProductKey
	FROM
		factSales
	WHERE
		DateKey = '01/01/2007'
		AND factSales.ProductKey = DimProduct.ProductKey
)


-- Solu��o alternativa com o ANY
SELECT
	ProductKey,
	ProductName
FROM	
	DimProduct
WHERE ProductKey = ANY(
	SELECT
		ProductKey
	FROM
		factSales
	WHERE
		DateKey = '01/01/2007'
		-- AND factSales.ProductKey = DimProduct.ProductKey
	)

------------------------------

/* AULA 09 - Subquery na pr�tica (Aplica��o com o SELECT)
Podemos tamb�m utilizar subqueries para criar novas colunas dentro de uma consulta.
Repare no exemplo abaixo: Queremos descobrir qual foi o total de vendas de cada produto da nossa tabela DimProduct. Para isso, adicionamos uma subquery (um novo SELECT) como sendo uma couna extra da nossa consulta principal. Assim, al�m de mostrar as colunas ProductKey e ProductName da tabela dimProduct, adicionamos tamb�m uma coluna que faz a contagem de vendas na tabela FactSales.

 Exemplo: Retornar uma tabela com todos os produtos (ID Produto e Nome Produto) e tamb�m o total de vendas para cada produto */

SELECT
	ProductKey,
	ProductName,
	(SELECT COUNT(ProductKey) FROM FactSales WHERE FactSales.ProductKey = DimProduct.ProductKey) AS 'Qtd. Vendas'
FROM
	DimProduct

------------------------------

/* AULA 10 - Subquery na pr�tica (Aplica��o com o FROM)
Nos exemplos abaixo, vemos duas formas de descobrir o total de produtos da marca Contoso.

Na op��o 1, fizemos uma contagem na tabela dimProduct e por fim um filtro na coluna BrandName.
Na op��o 2, utilizamos a ideia de subqueries: a contagem foi feita n�o na tabela dimProduct, mas sim em uma tabela que foi filtrada antes de ser aplicada no FROM.

Exemplo: Retornar a quantidade total de produtos da marca Contoso. */

SELECT 
	COUNT(*) 
FROM DimProduct
WHERE BrandName = 'Contoso'

SELECT
	COUNT(*)
FROM (SELECT * FROM DimProduct WHERE BrandName = 'Contoso') AS T

------------------------------

/* AULA 11 - Plano de Execu��o estimado
No exerc�cio acima foi mostrado como resolver o mesmo problema de duas maneiras. Por�m, uma vez que a primeira forma j� estava sendo utilizada e possivelmente memorizada, por que eu deveria aprender uma segunda forma de fazer a mesma coisa?

Assim, como nas ferramentas de Excel, Power BI, etc. No SQL tamb�m teremos mais de uma forma de resolver o mesmo problema e se existe duas ou mais formas de resolver um problema � interessante que eu sa�ba todas as formas para identificar qual � a maneira mais simples e r�pida de resolver o problema em quest�o.

No SQL Server temos uma op��o que nos ajdua a identificar qual das possiveis formas de resolver um problema � a mais otimizada, r�pida, simples. E essa op��o � o Plano de Execu��o Estimado, que se encontra na barra de menu 'Editor do SQL' ou atrav�s do atalho  CTRL + L.

Embora no exemplo anterior o Custo da consulta (relativo ao lote) tenha sido de '50%', o que nos diz que n�o importa qual das op��es fosse usada, o resultado de processamento seria o mesmo. 
Em outras ocasi�es, dependendo do c�digo e da consulta realizada, a diferen�a de Custo da consulta pode ser grande, por exemplo (20% e 70%), o que nos informaria qual seria a melhor e mais otimizada forma de usar uma consulta nesta ocasi�o. */

------------------------------

/* AULA 12 e 13 - Subquery aninhada
Tamb�m � poss�vel criar subqueries aninhadas, ou seja, subqueries dentro de subqueries. Para entender como vai funcionar, vamos fazer o seguinte exemplo: descobrir os nomes dos clientes que ganham o segundo maior sal�rio.

Poder�amos descobrir o segundo maior sal�rio aplicando um TOP 2 + ORDER BY. Feito isso, descobrir�amos que o segundo maior sl�rio � $160.000 e poder�amos utilziar esse resultado para filtrar a nossa tabela dimCustomer e descobrir os clientes que recebem o 2� maior sal�rio. Mas como tornar isso mais autom�tico?

Exemplo: Descubra os nomes dos clientes que ganham o segundo maior sal�rio. */

SELECT * FROM DimCustomer
WHERE CustomerType = 'Person'
ORDER BY YearlyIncome DESC
-- Obs.: Desta forma � poss�vel descobrir o segundo maior sal�rio por�m, de uma forma mais manual, tendo que rolar a tabela at� identificar qual � o segundo maior sal�rio.

SELECT 
	DISTINCT TOP(2) YearlyIncome 
FROM 
	DimCustomer
WHERE CustomerType = 'Person'
ORDER BY YearlyIncome DESC
-- Obs.: Desta forma, seria muito mais r�pido e eficiente que o anterior.

SELECT
	CustomerKey,
	FirstName,
	LastName,
	YearlyIncome
FROM DimCustomer
WHERE YearlyIncome = 160000
-- Obs.: Finalmente, teriamos o resultado dos clientes que possuem o segundo maior sal�rio. Por�m, foi necess�rio varias etapas para se chegar a esse resultado, fazendo com que essa consulta n�o fosse a mais otimizada poss�vel, pois se eu tiver um cliente que ganhasse 165 mil, a consulta anterior j� n�o funcion�ria, pois n�o est� automatizada.

-- Obs.: A forma mais otimizada seria substituir o valor de 160000 por uma subquery por�m h� um detalhe. O valor 160000 � um resultado de uma consulta anterior que descobriu o segundo maior sal�rio, por isso eu teria que fazer o seguinte:
--1� Descobrir o maior sal�rio
--2� Descobrir apenas o segundo maior sal�rio
--3� Descobrir os nomes dos clientes que ganham o segundo maior sal�rio

SELECT
	CustomerKey,
	FirstName,
	LastName,
	YearlyIncome
FROM DimCustomer
WHERE YearlyIncome = (
	SELECT
		MAX(YearlyIncome)
	FROM DimCustomer
	WHERE
		YearlyIncome < (
			SELECT 
				MAX(YearlyIncome) 
			FROM DimCustomer	
			WHERE CustomerType = 'Person'
	)
)
/* Obs.: O que a subquery acima esta solicitando ao SQL � que ele traga o M�ximo valor MENOR QUE o M�ximo valor. � como se pedisse, me traga o 1� depois do 1�.
A subquery mais interna, retorna o valor m�ximo que � 170000;
Enquanto a subquery mais externa retorna o m�ximo valor que � menor que 170000; */

------------------------------

/* AULA 14 - CTE (Common table Expression)
Nessa aula vamos aprender o que � uma CTE (Common Table Expression), uma esp�cie de tabela tempor�ria que conseguimos criar no nosso c�digo e reaproveitar ao longo deste c�digo.

Abaixo temos uma CTE. A estrutura para cri�-la � bem simples. Utilizamos o comando WITH, seguido do nome da CTE, e em seguida o AS para especificar o que vai compor essa CTE. No exemplo abaixo, a CTE vai armazenar determinadas colunas da tabela dimProduct, mas considerando apenas a marca Contoso. Em seguida, podemos selecionar essa CTE utilizando o comando SELECT.

Exemplo: Crie uma CTE para armazenar o resultado de uma consulta que contenha: ProductKey, ProductName, BrandName, ColorName e UnitPrice, apenas para a marca Contoso. */

WITH cte AS (
SELECT
	ProductKey,
	ProductName,
	BrandName,
	ColorName,
	UnitPrice
FROM
	DimProduct
WHERE BrandName = 'Contoso'
)

--SELECT * FROM cte
SELECT COUNT(*) FROM cte

------------------------------

/* AULA 15 - Calculando agrega��es com CTE
Podemos armazenar consultas mais complexas dentro de uma CTE. No exemplo abaixo, criamos uma CTE que � o agrupamento da tabela dimProduct, contendo o total de produtos por marca. Por fim, podemos descobrir a m�dia de produtos por marca, aplicando o AVG na coluna Total da nossa CTE.


-- Exemplo: Crie uma CTE que seja o resultado do agrupamento de total de produtos por marca. Fa�a uma m�dia de produtos por marca. */

WITH cte AS (
	SELECT
		BrandName,
		COUNT(*) AS 'Total'
	FROM
		DimProduct
	GROUP BY
		BrandName
)

--SELECT * FROM cte
SELECT AVG(Total) FROM cte

------------------------------

/* AULA 16 - Nomeando colunas de uma CTE
Tamb�m seria poss�vel criar uma CTE especificando os nomes das suas colunas. No exemplo abaixo, temos a CTE com colunas chamadas 'Marca' e 'Total'. Posteriormente, podemos fazer um SELECT referenciando o nome delas.

Exemplo: Crie uma CTE que seja o resultado do agrupamento de total de produtos por marca. Fa�a uma m�dia de produtos por marca. */

WITH cte(Marca, Total) AS (
	SELECT
		BrandName,
		COUNT(*)
	FROM
		DimProduct
	GROUP BY
		BrandName
)

SELECT Marca, Total FROM cte

------------------------------

/* AULA 17 - Criando m�ltiplas CTE's
Podemos criar m�ltiplas CTEs e em seguida criar uma rela��o entre elas. Observe a consulta abaixo. Criamos duas CTEs (produtos_contoso e vendas_top1000) e por fim, reaslizamos um JOIN entre essas CTEs.

Exemplo: Crie 2 CTE's:
1. A primeira, cjamada produtos_contoso, deve conter as seguintes colunas (DimProduct): ProductKey, ProductName, BrandName
2. A segunda, chamada vendas_top100, deve ser um top 100 vendas mais recentes, considerando as seguintes colunas da tabela FactSales: SalesKey, ProductKey, DateKey, SalesQuantity

Por fim, fa�a um INNER JOIN dessas tabelas */

WITH produtos_contoso AS (
	SELECT
		ProductKey,
		ProductName,
		BrandName
	FROM
		DimProduct
	WHERE
		BrandName = 'Contoso'
),
vendas_top100 AS (
SELECT TOP(100)
	SalesKey,
	ProductKey,
	DateKey,
	SalesQuantity
FROM
	FactSales
ORDER BY DateKey DESC
)

SELECT * FROM vendas_top100
INNER JOIN produtos_contoso
	ON vendas_top100.ProductKey = produtos_contoso.ProductKey

------------------------------

-- AULA 18 - Explica��o Exerc�cios
-- AUlA 19 - Resolu��o Exerc�cio 01
-- AUlA 20 - Resolu��o Exerc�cio 02
-- AUlA 21 - Resolu��o Exerc�cio 03
-- AUlA 22 - Resolu��o Exerc�cio 04
-- AUlA 23 - Resolu��o Exerc�cio 05
-- AUlA 24 - Resolu��o Exerc�cio 06
-- AUlA 25 - Resolu��o Exerc�cio 07
-- AUlA 26 - Resolu��o Exerc�cio 08
-- AUlA 27 - Resolu��o Exerc�cio 09
-- AUlA 28 - Resolu��o Exerc�cio 10