-- Módulo 14 - SQL SERVER - Subqueries e CTE's


/* AULA 01 - Introdução ao Módulo
Nesse módulo vamos aprender a criar subqueries no SQL.

- O que é uma subquery
- Aplicações de subqueries
- Subquery aninhada
- Subquery correlacionada
- CTE's: Common Table Expression */

------------------------------

/* AULA 02 - O que é uma Subquert e onde usamos

1. O que é uma Subquery?
Uma Subconsulta (ou Subquery ou SubSELECT) nada mais é do que uma consulta dentro de outra consulta. Ou seja, com uma subquery conseguimos utilizar o resultado de uma query (consulta) dentro de outra consulta.

2. Onde utilizamos uma Subquery
Subqueries podem ser utilizadas em 4 situações possíveis:
1. Subqueries com WHERE (escalar): Nesta situação, utilizamos o resultado de um SELECT para filtrar um outro SELECT; Para este caso, utilizamos o termo 'escalar, para dizer que o resultado do SELECT mais interno é um valor único, e não uma lista de valores.
2. Subqueries com WHERE (lista): Aqui temos uma situação semelhante à anterior, com a diferença de que o resultado subquery seria uma lista de vários valores que poderiam ser passados no WHERE. NEse caso, como o filtro seria de mais de 1 valor, utilizamos o IN.
3. Subqueries dentro de um SELECT: Outra opção seria utilizar o resultado de um SELECT como uma nova coluna de uma query principal.
4. Subqueries junto com um FROM: Podemos utilizar o resultado de um SELECT como uma tabela de um outro SELECT. Neste caso, precisamos utilizar o comando AS para dar um nome para essa tabela. */

-- 1. Subquery junto com um WHERE, como um filtro dinâmico e escalar (valor único)
SELECT
	Coluna1,
	Coluna2
FROM Tabela
WHERE Coluna1 = (SELECT)

-- 2. Subquery junto com um WHERE, como um filtro dinâmico e em lista (vários valores)
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


-- Ex: Imagina que eu quero selecionar os produtos com o Preço maior do que a média. */
-- 1º Passo:  Descobrir a média
SELECT AVG(UnitPrice) From DimProduct

-- 2º Passo: Filtrar a nossa tabela, utilizando o WHERE
SELECT
	*
FROM DimProduct
WHERE UnitPrice > 356.8301 -- Ao invés de colar o resultado da consulta anterior, eu escrevo a consulta anterior, dentro do WHERE entre ()

-- Fazer isso não é muito automático, pois escrevemos manualmente  média de preço no filtro. Se os preços alterarem ou se tivermos adição ou exclusão de protuos, essa filtragem não será automática. O valor de 356.8301 continuará fixo mesmo que a média se altere. O ideal então, seria utilizar uma subquery, substituindo o valor fixo de 356.8301 pelo SELECT que criamos para descobrir essa média:
SELECT
	*
FROM DimProduct
WHERE UnitPrice > (SELECT AVG(UnitPrice) From DimProduct)

-- Obs.: Na solução acima, utilizamos uma subquery, ou seja, um SELECT dentro de outro SELECT. Dessa forma, o cálculo da média de preço ficará 100% automático, sem a necessidade de atualizar manualmente o valor.

------------------------------

/* AULA 03, 04 e 05 - Subquery na prática (Aplicação com o WHERE)
Para entender a ideia por trás das subqueries, vamos começar fazendo 3 exemplos com a aplicação WHERE.

Exemplo 1: Quais produtos da tabela DimProduct possuem custos acima da média? */
SELECT AVG(UnitCost) FROM DimProduct     -- 147.6555

SELECT
	*
FROM
	DimProduct
WHERE UnitCost >= (SELECT AVG(UnitCost) FROM DimProduct)

/* Exemplo 2: Faça uma consulta para retornar os produtos da categoria 'Televisions'. Tome cuidado pois não temos a informação de Nome da Subcategoria na tabela DimProduct. Dessa forma, precisaremos criar um SELECT que descubra o ID da categoria 'Televisions' e passar esse resultado como o valor que queremos filtrar dentro do WHERE. */
SELECT * FROM DimProduct
WHERE ProductSubcategoryKey = 
	(SELECT ProductSubcategoryKey FROM DimProductSubcategory
		WHERE ProductSubcategoryName = 'Televisions')


/* Exemplo 3: Filtre a tabela FactSales e mostre apenas as vendas referentes às lojas com 100 ou mais funcionários */
SELECT	StoreKey FROM DimStore WHERE EmployeeCount >= 100
SELECT * FROM FactSales WHERE StoreKey IN (199, 200, 289)
-- Ao invés de fazer a consulta igual acima, poderemos automatizar o filtro da seguinte forma:

SELECT * FROM FactSales
WHERE StoreKey IN (
	SELECT	StoreKey
	FROM DimStore
	WHERE EmployeeCount >= 100
)

------------------------------

/*AULA 06 - ANY, SOME e ALL
Os operadores ANY e SOME são equivalentes e permitem realizar uma comparação entre um único valor de uma coluna e um intervalo de outros valors. O =ANY e o =SOME são equivalentes. Quando usados com o sinal lógico '=', eles possuem a mesma finalidade do operador IN, permitindo retornar todas as linhas que sejam iguais à lista de valores especificados. */

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
	(5, 'André', 24, 'M'),
	(6, 'Luisa', 25, 'F')

SELECT * FROM funcionarios

-- Selecione os funcionários do sexo masculino (MAS, utilizando a coluna de IDADE para isso)
SELECT * FROM funcionarios
WHERE idade IN (21, 23, 24)

SELECT * FROM funcionarios
WHERE idade IN (SELECT idade FROM funcionarios WHERE sexo = 'M')

/* = ANY(valor1, valor2, valor3) :
Equivalente ao IN, retorna as linhas da tabela que sejam iguais ao valor1, OU valor2, OU valor3 */
SELECT * FROM funcionarios
WHERE idade = ANY (SELECT idade FROM funcionarios WHERE sexo = 'M')

/* > ANY(valor1, valor2, valor3) :
Retorna as linhas da tabela com valores maiores que o valor1, OU valor2, OU valor3. Ou seja, maior que o mínimo dos valores */
SELECT * FROM funcionarios
WHERE idade > ANY (SELECT idade FROM funcionarios WHERE sexo = 'M')

/* < ANY(valor1, valor2, valor3) :
Retorna as linhas da tabela com valores maiores que o valor1, OU valor2, OU valor3. Ou seja, maior que o máximo dos valores */
SELECT * FROM funcionarios
WHERE idade < ANY (SELECT idade FROM funcionarios WHERE sexo = 'M')

-- Obs.: O ANY é = ao SOME. Ou seja, poderia utilizar o SOME em qualquer uma das opções acima, ao invés de ANY.

/* 
O operador ALL também permite uma comparação entre valores especificados, mas para que a consulta retorne algum resultado, é necessário que o valor comparado seja maior ou menor do que TODOS os valores da lista. (Obs.: Dificilmente utilizamos o =ALL pois estaríamos comparando um valor e esperando que ele fosse igual a todos os valores da lista. A menos que todos os valores da lista fossem iguais, o =ALL não faria sentido)

Exemplo:
> ALL(valor1, valor2, valor3) :
	Retorna as linhas da tabela com valores maiores que o valor1, E valor2, E valor3. Ou seja, maior que o máximo dos valores */
SELECT * FROM funcionarios
WHERE idade < ALL (SELECT idade FROM funcionarios WHERE sexo = 'M')

/* < ALL(valor1, valor2, valor3) :
Retorna as linhas da tabela com valores menores que o valor1, E valor2, E valor3. Ou seja, menor que o mínimo dos valores
*/
SELECT * FROM funcionarios
WHERE idade > ALL (SELECT idade FROM funcionarios WHERE sexo = 'M')

------------------------------

/* AULA 07 e 08 - EXISTS
O operador EXISTS é usado para testar a existência de qualquer registro (linha) em uma subconsulta.
Pensando em um exemplo prático, imagina que queiramos descobrir quais são os produtos que possuem vendas em um determinado dia.

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


-- Solução alternativa com o ANY
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

/* AULA 09 - Subquery na prática (Aplicação com o SELECT)
Podemos também utilizar subqueries para criar novas colunas dentro de uma consulta.
Repare no exemplo abaixo: Queremos descobrir qual foi o total de vendas de cada produto da nossa tabela DimProduct. Para isso, adicionamos uma subquery (um novo SELECT) como sendo uma couna extra da nossa consulta principal. Assim, além de mostrar as colunas ProductKey e ProductName da tabela dimProduct, adicionamos também uma coluna que faz a contagem de vendas na tabela FactSales.

 Exemplo: Retornar uma tabela com todos os produtos (ID Produto e Nome Produto) e também o total de vendas para cada produto */

SELECT
	ProductKey,
	ProductName,
	(SELECT COUNT(ProductKey) FROM FactSales WHERE FactSales.ProductKey = DimProduct.ProductKey) AS 'Qtd. Vendas'
FROM
	DimProduct

------------------------------

/* AULA 10 - Subquery na prática (Aplicação com o FROM)
Nos exemplos abaixo, vemos duas formas de descobrir o total de produtos da marca Contoso.

Na opção 1, fizemos uma contagem na tabela dimProduct e por fim um filtro na coluna BrandName.
Na opção 2, utilizamos a ideia de subqueries: a contagem foi feita não na tabela dimProduct, mas sim em uma tabela que foi filtrada antes de ser aplicada no FROM.

Exemplo: Retornar a quantidade total de produtos da marca Contoso. */

SELECT 
	COUNT(*) 
FROM DimProduct
WHERE BrandName = 'Contoso'

SELECT
	COUNT(*)
FROM (SELECT * FROM DimProduct WHERE BrandName = 'Contoso') AS T

------------------------------

/* AULA 11 - Plano de Execução estimado
No exercício acima foi mostrado como resolver o mesmo problema de duas maneiras. Porém, uma vez que a primeira forma já estava sendo utilizada e possivelmente memorizada, por que eu deveria aprender uma segunda forma de fazer a mesma coisa?

Assim, como nas ferramentas de Excel, Power BI, etc. No SQL também teremos mais de uma forma de resolver o mesmo problema e se existe duas ou mais formas de resolver um problema é interessante que eu saíba todas as formas para identificar qual é a maneira mais simples e rápida de resolver o problema em questão.

No SQL Server temos uma opção que nos ajdua a identificar qual das possiveis formas de resolver um problema é a mais otimizada, rápida, simples. E essa opção é o Plano de Execução Estimado, que se encontra na barra de menu 'Editor do SQL' ou através do atalho  CTRL + L.

Embora no exemplo anterior o Custo da consulta (relativo ao lote) tenha sido de '50%', o que nos diz que não importa qual das opções fosse usada, o resultado de processamento seria o mesmo. 
Em outras ocasiões, dependendo do código e da consulta realizada, a diferença de Custo da consulta pode ser grande, por exemplo (20% e 70%), o que nos informaria qual seria a melhor e mais otimizada forma de usar uma consulta nesta ocasião. */

------------------------------

/* AULA 12 e 13 - Subquery aninhada
Também é possível criar subqueries aninhadas, ou seja, subqueries dentro de subqueries. Para entender como vai funcionar, vamos fazer o seguinte exemplo: descobrir os nomes dos clientes que ganham o segundo maior salário.

Poderíamos descobrir o segundo maior salário aplicando um TOP 2 + ORDER BY. Feito isso, descobriríamos que o segundo maior slário é $160.000 e poderíamos utilziar esse resultado para filtrar a nossa tabela dimCustomer e descobrir os clientes que recebem o 2º maior salário. Mas como tornar isso mais automático?

Exemplo: Descubra os nomes dos clientes que ganham o segundo maior salário. */

SELECT * FROM DimCustomer
WHERE CustomerType = 'Person'
ORDER BY YearlyIncome DESC
-- Obs.: Desta forma é possível descobrir o segundo maior salário porém, de uma forma mais manual, tendo que rolar a tabela até identificar qual é o segundo maior salário.

SELECT 
	DISTINCT TOP(2) YearlyIncome 
FROM 
	DimCustomer
WHERE CustomerType = 'Person'
ORDER BY YearlyIncome DESC
-- Obs.: Desta forma, seria muito mais rápido e eficiente que o anterior.

SELECT
	CustomerKey,
	FirstName,
	LastName,
	YearlyIncome
FROM DimCustomer
WHERE YearlyIncome = 160000
-- Obs.: Finalmente, teriamos o resultado dos clientes que possuem o segundo maior salário. Porém, foi necessário varias etapas para se chegar a esse resultado, fazendo com que essa consulta não fosse a mais otimizada possível, pois se eu tiver um cliente que ganhasse 165 mil, a consulta anterior já não funcionária, pois não está automatizada.

-- Obs.: A forma mais otimizada seria substituir o valor de 160000 por uma subquery porém há um detalhe. O valor 160000 é um resultado de uma consulta anterior que descobriu o segundo maior salário, por isso eu teria que fazer o seguinte:
--1º Descobrir o maior salário
--2º Descobrir apenas o segundo maior salário
--3º Descobrir os nomes dos clientes que ganham o segundo maior salário

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
/* Obs.: O que a subquery acima esta solicitando ao SQL é que ele traga o Máximo valor MENOR QUE o Máximo valor. É como se pedisse, me traga o 1º depois do 1º.
A subquery mais interna, retorna o valor máximo que é 170000;
Enquanto a subquery mais externa retorna o máximo valor que é menor que 170000; */

------------------------------

/* AULA 14 - CTE (Common table Expression)
Nessa aula vamos aprender o que é uma CTE (Common Table Expression), uma espécie de tabela temporária que conseguimos criar no nosso código e reaproveitar ao longo deste código.

Abaixo temos uma CTE. A estrutura para criá-la é bem simples. Utilizamos o comando WITH, seguido do nome da CTE, e em seguida o AS para especificar o que vai compor essa CTE. No exemplo abaixo, a CTE vai armazenar determinadas colunas da tabela dimProduct, mas considerando apenas a marca Contoso. Em seguida, podemos selecionar essa CTE utilizando o comando SELECT.

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

/* AULA 15 - Calculando agregações com CTE
Podemos armazenar consultas mais complexas dentro de uma CTE. No exemplo abaixo, criamos uma CTE que é o agrupamento da tabela dimProduct, contendo o total de produtos por marca. Por fim, podemos descobrir a média de produtos por marca, aplicando o AVG na coluna Total da nossa CTE.


-- Exemplo: Crie uma CTE que seja o resultado do agrupamento de total de produtos por marca. Faça uma média de produtos por marca. */

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
Também seria possível criar uma CTE especificando os nomes das suas colunas. No exemplo abaixo, temos a CTE com colunas chamadas 'Marca' e 'Total'. Posteriormente, podemos fazer um SELECT referenciando o nome delas.

Exemplo: Crie uma CTE que seja o resultado do agrupamento de total de produtos por marca. Faça uma média de produtos por marca. */

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

/* AULA 17 - Criando múltiplas CTE's
Podemos criar múltiplas CTEs e em seguida criar uma relação entre elas. Observe a consulta abaixo. Criamos duas CTEs (produtos_contoso e vendas_top1000) e por fim, reaslizamos um JOIN entre essas CTEs.

Exemplo: Crie 2 CTE's:
1. A primeira, cjamada produtos_contoso, deve conter as seguintes colunas (DimProduct): ProductKey, ProductName, BrandName
2. A segunda, chamada vendas_top100, deve ser um top 100 vendas mais recentes, considerando as seguintes colunas da tabela FactSales: SalesKey, ProductKey, DateKey, SalesQuantity

Por fim, faça um INNER JOIN dessas tabelas */

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

-- AULA 18 - Explicação Exercícios
-- AUlA 19 - Resolução Exercício 01
-- AUlA 20 - Resolução Exercício 02
-- AUlA 21 - Resolução Exercício 03
-- AUlA 22 - Resolução Exercício 04
-- AUlA 23 - Resolução Exercício 05
-- AUlA 24 - Resolução Exercício 06
-- AUlA 25 - Resolução Exercício 07
-- AUlA 26 - Resolução Exercício 08
-- AUlA 27 - Resolução Exercício 09
-- AUlA 28 - Resolução Exercício 10