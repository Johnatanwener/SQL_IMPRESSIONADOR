-- MÓDULO 04 - SQL SERVER - ORDENAR E FILTRAR

/* AULA 14 - WHERE mais LIKE - Filtro especial para textos
O comando LIKE é usado em conjunto com o WHERE para procurar por um determinado padrão em uma coluna.

Existem 2 caracteres especiais usados em conjunto com o LIKE.

1. O sinal de porcentagem (%) representa zero, um ou múltiplos caracteres.
2. O underline (_) representa um único caractere.

Aplicação do LIKE							Descrição
WHERE CustomerName LIKE 'a%'	>	Encontra qualquer valor que começa com 'a'
WHERE CustomerName LIKE '%a'	>	Encontra qualquer valor que termina com 'a'
WHERE CustomerName LIKE '%or%'	>	Encontra qualquer valor que tenha 'or' em qualquer posição da palavra
WHERE CustomerName LIKE '_r%'	>	Encontra qualquer valor que tenha 'r' a partir do segundo caractere
WHERE CustomerName LIKE 'a_%'	>	Encontra qualquer valor que comece com 'a' e tenha pelo menos 2 caracteres		
WHERE CustomerName LIKE 'a__%'	>	Encontra qualquer valor que comece com 'a' e tenha pelo menos 3 caracteres
WHERE CustomerName LIKE 'a%0'	>	Encontra qualquer valor que comece com 'a' e termine com 'o'

-- 1. Selecione todos os produtos que possuem o texto 'MP3 Player' contido na nome do produto. */
SELECT * FROM DimProduct
WHERE ProductName LIKE '%MP3 Player%' 

-- 2. Selecione todos os produtos que têm a descrição do nome começando por 'Type'.
SELECT * FROM DimProduct
WHERE ProductDescription LIKE '%Type%'

-- 3. Selecione todos os produtos que têm a descrição do nome terminando em 'WMA'.
SELECT * FROM DimProduct
WHERE ProductDescription LIKE '%WMA'