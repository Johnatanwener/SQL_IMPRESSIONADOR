-- M�DULO 04 - SQL SERVER - ORDENAR E FILTRAR

/* AULA 14 - WHERE mais LIKE - Filtro especial para textos
O comando LIKE � usado em conjunto com o WHERE para procurar por um determinado padr�o em uma coluna.

Existem 2 caracteres especiais usados em conjunto com o LIKE.

1. O sinal de porcentagem (%) representa zero, um ou m�ltiplos caracteres.
2. O underline (_) representa um �nico caractere.

Aplica��o do LIKE							Descri��o
WHERE CustomerName LIKE 'a%'	>	Encontra qualquer valor que come�a com 'a'
WHERE CustomerName LIKE '%a'	>	Encontra qualquer valor que termina com 'a'
WHERE CustomerName LIKE '%or%'	>	Encontra qualquer valor que tenha 'or' em qualquer posi��o da palavra
WHERE CustomerName LIKE '_r%'	>	Encontra qualquer valor que tenha 'r' a partir do segundo caractere
WHERE CustomerName LIKE 'a_%'	>	Encontra qualquer valor que comece com 'a' e tenha pelo menos 2 caracteres		
WHERE CustomerName LIKE 'a__%'	>	Encontra qualquer valor que comece com 'a' e tenha pelo menos 3 caracteres
WHERE CustomerName LIKE 'a%0'	>	Encontra qualquer valor que comece com 'a' e termine com 'o'

-- 1. Selecione todos os produtos que possuem o texto 'MP3 Player' contido na nome do produto. */
SELECT * FROM DimProduct
WHERE ProductName LIKE '%MP3 Player%' 

-- 2. Selecione todos os produtos que t�m a descri��o do nome come�ando por 'Type'.
SELECT * FROM DimProduct
WHERE ProductDescription LIKE '%Type%'

-- 3. Selecione todos os produtos que t�m a descri��o do nome terminando em 'WMA'.
SELECT * FROM DimProduct
WHERE ProductDescription LIKE '%WMA'