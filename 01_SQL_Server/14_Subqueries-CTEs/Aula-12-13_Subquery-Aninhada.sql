-- Módulo 14 - SQL SERVER - Subqueries e CTE's


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