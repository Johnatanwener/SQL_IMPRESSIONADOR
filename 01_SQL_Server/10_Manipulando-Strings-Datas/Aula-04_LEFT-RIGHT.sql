-- MÓDULO 10 - SQL SERVER - Manipulando Strings e Datas


/* AULA 04 - LEFT e RIGHT
As funções LEFT e RIGHT permitem extrair uma parte de um texto, sempre começando da esqueda para a direita, ou da direita para a esquerda, respectivamente.

LEFT extrai uma determinada quantidade de caracteres de um texto, da esquerda para a direita
RIGHT extrai uma determinada quantidade de caracteres de um texto, da direita para a esquerda */

SELECT * FROM DimProduct
SELECT LEFT('Product0101001', 7)
SELECT RIGHT('Product0101001', 7)
-- As funções irão solicitar 2 argumentos, sendo o primeiro o 'valor' e o segundo a quantidade de caracteres que deseja extrair)

-- Exemplo: Faça uma consulta à tabela DimProduct e divida a coluna de StyleName em 2 partes
SELECT
	ProductName AS 'Produto',
	UnitPrice AS 'Preço',
	LEFT(StyleName, 7) AS 'Cod 1', 
	RIGHT(StyleName, 7) AS 'Cod 2'
FROM
	DimProduct
-- Sempre que quiser extrair informações da esquerda para direitra ou vice-versa, poderá usar a função LEFT e RIGHT
