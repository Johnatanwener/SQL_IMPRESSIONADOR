-- M�DULO 10 - SQL SERVER - Manipulando Strings e Datas


/* AULA 04 - LEFT e RIGHT
As fun��es LEFT e RIGHT permitem extrair uma parte de um texto, sempre come�ando da esqueda para a direita, ou da direita para a esquerda, respectivamente.

LEFT extrai uma determinada quantidade de caracteres de um texto, da esquerda para a direita
RIGHT extrai uma determinada quantidade de caracteres de um texto, da direita para a esquerda */

SELECT * FROM DimProduct
SELECT LEFT('Product0101001', 7)
SELECT RIGHT('Product0101001', 7)
-- As fun��es ir�o solicitar 2 argumentos, sendo o primeiro o 'valor' e o segundo a quantidade de caracteres que deseja extrair)

-- Exemplo: Fa�a uma consulta � tabela DimProduct e divida a coluna de StyleName em 2 partes
SELECT
	ProductName AS 'Produto',
	UnitPrice AS 'Pre�o',
	LEFT(StyleName, 7) AS 'Cod 1', 
	RIGHT(StyleName, 7) AS 'Cod 2'
FROM
	DimProduct
-- Sempre que quiser extrair informa��es da esquerda para direitra ou vice-versa, poder� usar a fun��o LEFT e RIGHT
