-- M�DULO 10 - SQL SERVER - Manipulando Strings e Datas


/* AULA 10 - CHARINDEX e SUBSTRING PT. 01
As fun��es CHARINDEX e SUBSTRING combinadas s�o muito �teis para manipular textos de forma mais avan�ada.

A fun��o CHARINDEX nos permite descobrir a posi��o de uma determinada posi��o de caracteres dentro de um texto. Essa fun��o nos pede 2 argumentos.
1. Texto a ser procurado
2. Texto completo

J� a fun��o SUBSTRING nos permite retornar uma quantidade de caracteres de dentro de um texto, a partir de uma posi��o inicial. Essa fun��o nos pede 3 argumentos: 
1.  Texto
2. Posi��o inicial do texto a ser extraido
3. Quantidade de caracteres a ser extra�do

Abaixo, temos alguns exemplos de ambas as fun��es.	*/

SELECT 'Raquel Moreno' AS 'Nome'

-- Descubra a posi��o em que come�a o sobrenome da Raquel utilizando a fun��o CHARINDEX
SELECT CHARINDEX('M', 'Raquel Moreno') -- Retorna a posi��o da letra M
SELECT CHARINDEX('Moreno', 'Raquel Moreno') -- Retorna a posi��o que come�a o conjunto de caracteres pedido.

-- Extraia o sobrenome da Raquel utilizando a fun��o SUBSTRING
SELECT SUBSTRING('Raquel Moreno', 8, 6) AS 'Sobrenome'
-- 3 argumentos ('Texto', 'Posi�ao Inicial', 'Qtd de caracteres apartir da Posi��o inicial')

------------------------------

-- AULA 11 - CHARINDEX e SUBSTRING PT. 02
-- Combine as fun��es CHARINDEX e SUBSTRING para extrair de forma autom�tica qualquer sobrenome

SELECT SUBSTRING('Johnatan Wener', 8, 6) AS 'Sobrenome' -- N�o retornar� o resultado corretamente, pois o nome 'Johnatan Wener' possui um padr�o diferente do 'Raquel Moreno'; O correto seria:
SELECT SUBSTRING('Johnatan Wener', 10, 6) AS 'Sobrenome' -- Por�m, para tornar essa fun��o mais autom�tica faremos...

SELECT 'Johnatan Wener' AS 'Nome'
SELECT CHARINDEX(' ', 'Johnatan Wener') AS 'Posi��o'
SELECT SUBSTRING('Johnatan Wener', CHARINDEX(' ', 'Johnatan Wener') + 1, 100) AS 'Sobrenome'


-- AULA 12 - CHARINDEX e SUBSTRING PT. 03
DECLARE @varNome VARCHAR(MAX)
SET @varNome = 'Qualquer Nome'
SELECT SUBSTRING(@varNome, CHARINDEX(' ', @varNome) + 1, 100) AS 'Sobrenome'