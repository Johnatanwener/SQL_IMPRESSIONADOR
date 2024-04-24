-- M�dulo 14 - SQL SERVER - Subqueries e CTE's


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