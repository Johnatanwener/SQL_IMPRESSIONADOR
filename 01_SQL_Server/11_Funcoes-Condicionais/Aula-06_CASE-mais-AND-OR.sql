-- M�dulo 11 - SQL SERVER - FUN��ES CONDICIONAIS


/* AULA 06 - CASE com os operadores l�gicos AND e OR
Podemos combinar o CASE com o AND para criar testes l�gicos ainda mais avan�ados.
Observe o exemplo abaixo. Queremos criar uma nova coluna em nossa tabela para registrar o desconto de cada produto. Os produtos que forem da marca Contoso E que tamb�m forem da cor Red, receber�o um desconto de 10%. Caso contr�rio, n�o recebem nenhum desconto. Repare que a �nica diferen�a em rela��o aos exemplos anteriores foi que adicionamos um AND para nos permitir passar mais de um teste l�gico.

Como estamos utilizando o operador l�gico AND, as duas condi��es (Marca igual � Contoso) E (Cor igual � Red) precisam ser satisfeitas para que o desconto seja aplicado.	  */

-- Fa�a uma consulta � tabela DimProduct e retorne as colunas ProductName, BrandName, ColorName, UnitPrice e uma coluna de pre�o com desconto.

-- a) Caso o produto seja da marca Contoso E da cor Red, o desconto do produto ser� de 10%. Caso contr�rio, n�o ter� nenhum desconto.
SELECT
	ProductName AS 'Produto',
	BrandName AS 'Marca',
	ColorName AS 'Cor',
	UnitPrice AS 'Pre�o Unit�rio',
	CASE
		WHEN BrandName = 'Contoso' AND ColorName = 'Red' THEN 0.1
		ELSE 0
	END AS '% de Desconto'
FROM
	DimProduct


/* Podemos tamb�m combinar o CASE com o operador l�gico OR. No exemplo abaixo, os produtos que forem da marca Contoso OU da marca Fabrikam, receber�o um desconto de 10%. Caso contr�rio, n�o recebem nenhum desconto.

Como estamos utilizando o operador l�gico OR, qualquer uma das duas condi��es poder�o ser satisfeitas (Marca igual � Contoso) OU (Marca igual � Fabrikam) para que o desconto seja aplicado.	   */

-- b) Caso o produto seja da marca Litware OU Fabrikam, ele receber� um desconto de 5%. Caso contr�rio, n�o ter� nenhum desconto.
SELECT
	ProductName AS 'Produto',
	BrandName AS 'Marca',
	UnitPrice AS 'Pre�o Unit�rio',
	CASE
		WHEN BrandName = 'Litware' OR BrandName = 'Fabrikam' THEN 0.05
		ELSE 0
	END AS '% de Desconto'
FROM
	DimProduct