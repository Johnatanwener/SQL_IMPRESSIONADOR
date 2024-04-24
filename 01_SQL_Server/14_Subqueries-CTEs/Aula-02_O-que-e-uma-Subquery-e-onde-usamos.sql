-- Módulo 14 - SQL SERVER - Subqueries e CTE's


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