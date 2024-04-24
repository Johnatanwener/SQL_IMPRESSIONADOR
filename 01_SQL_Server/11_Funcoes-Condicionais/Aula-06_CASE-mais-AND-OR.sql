-- Módulo 11 - SQL SERVER - FUNÇÕES CONDICIONAIS


/* AULA 06 - CASE com os operadores lógicos AND e OR
Podemos combinar o CASE com o AND para criar testes lógicos ainda mais avançados.
Observe o exemplo abaixo. Queremos criar uma nova coluna em nossa tabela para registrar o desconto de cada produto. Os produtos que forem da marca Contoso E que também forem da cor Red, receberão um desconto de 10%. Caso contrário, não recebem nenhum desconto. Repare que a única diferença em relação aos exemplos anteriores foi que adicionamos um AND para nos permitir passar mais de um teste lógico.

Como estamos utilizando o operador lógico AND, as duas condições (Marca igual à Contoso) E (Cor igual à Red) precisam ser satisfeitas para que o desconto seja aplicado.	  */

-- Faça uma consulta à tabela DimProduct e retorne as colunas ProductName, BrandName, ColorName, UnitPrice e uma coluna de preço com desconto.

-- a) Caso o produto seja da marca Contoso E da cor Red, o desconto do produto será de 10%. Caso contrário, não terá nenhum desconto.
SELECT
	ProductName AS 'Produto',
	BrandName AS 'Marca',
	ColorName AS 'Cor',
	UnitPrice AS 'Preço Unitário',
	CASE
		WHEN BrandName = 'Contoso' AND ColorName = 'Red' THEN 0.1
		ELSE 0
	END AS '% de Desconto'
FROM
	DimProduct


/* Podemos também combinar o CASE com o operador lógico OR. No exemplo abaixo, os produtos que forem da marca Contoso OU da marca Fabrikam, receberão um desconto de 10%. Caso contrário, não recebem nenhum desconto.

Como estamos utilizando o operador lógico OR, qualquer uma das duas condições poderão ser satisfeitas (Marca igual à Contoso) OU (Marca igual à Fabrikam) para que o desconto seja aplicado.	   */

-- b) Caso o produto seja da marca Litware OU Fabrikam, ele receberá um desconto de 5%. Caso contrário, não terá nenhum desconto.
SELECT
	ProductName AS 'Produto',
	BrandName AS 'Marca',
	UnitPrice AS 'Preço Unitário',
	CASE
		WHEN BrandName = 'Litware' OR BrandName = 'Fabrikam' THEN 0.05
		ELSE 0
	END AS '% de Desconto'
FROM
	DimProduct