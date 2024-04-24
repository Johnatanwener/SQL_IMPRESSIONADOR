-- M�dulo 14 - SQL SERVER - Subqueries e CTE's


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