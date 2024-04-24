-- MÓDULO 10 - SQL SERVER - Manipulando Strings e Datas


/* AULA 10 - CHARINDEX e SUBSTRING PT. 01
As funções CHARINDEX e SUBSTRING combinadas são muito úteis para manipular textos de forma mais avançada.

A função CHARINDEX nos permite descobrir a posição de uma determinada posição de caracteres dentro de um texto. Essa função nos pede 2 argumentos.
1. Texto a ser procurado
2. Texto completo

Já a função SUBSTRING nos permite retornar uma quantidade de caracteres de dentro de um texto, a partir de uma posição inicial. Essa função nos pede 3 argumentos: 
1.  Texto
2. Posição inicial do texto a ser extraido
3. Quantidade de caracteres a ser extraído

Abaixo, temos alguns exemplos de ambas as funções.	*/

SELECT 'Raquel Moreno' AS 'Nome'

-- Descubra a posição em que começa o sobrenome da Raquel utilizando a função CHARINDEX
SELECT CHARINDEX('M', 'Raquel Moreno') -- Retorna a posição da letra M
SELECT CHARINDEX('Moreno', 'Raquel Moreno') -- Retorna a posição que começa o conjunto de caracteres pedido.

-- Extraia o sobrenome da Raquel utilizando a função SUBSTRING
SELECT SUBSTRING('Raquel Moreno', 8, 6) AS 'Sobrenome'
-- 3 argumentos ('Texto', 'Posiçao Inicial', 'Qtd de caracteres apartir da Posição inicial')

------------------------------

-- AULA 11 - CHARINDEX e SUBSTRING PT. 02
-- Combine as funções CHARINDEX e SUBSTRING para extrair de forma automática qualquer sobrenome

SELECT SUBSTRING('Johnatan Wener', 8, 6) AS 'Sobrenome' -- Não retornará o resultado corretamente, pois o nome 'Johnatan Wener' possui um padrão diferente do 'Raquel Moreno'; O correto seria:
SELECT SUBSTRING('Johnatan Wener', 10, 6) AS 'Sobrenome' -- Porém, para tornar essa função mais automática faremos...

SELECT 'Johnatan Wener' AS 'Nome'
SELECT CHARINDEX(' ', 'Johnatan Wener') AS 'Posição'
SELECT SUBSTRING('Johnatan Wener', CHARINDEX(' ', 'Johnatan Wener') + 1, 100) AS 'Sobrenome'


-- AULA 12 - CHARINDEX e SUBSTRING PT. 03
DECLARE @varNome VARCHAR(MAX)
SET @varNome = 'Qualquer Nome'
SELECT SUBSTRING(@varNome, CHARINDEX(' ', @varNome) + 1, 100) AS 'Sobrenome'