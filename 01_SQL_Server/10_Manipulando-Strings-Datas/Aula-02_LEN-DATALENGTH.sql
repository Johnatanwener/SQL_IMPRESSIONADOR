-- MÓDULO 10 - SQL SERVER - Manipulando Strings e Datas


/* AULA 02 - LEN e DATALENGTH
As funções LEN e DATALENGTH possuem resultados semelhantes: ambos retornam a quantidade de caracteres de um determinado texto.

A grande diferença entre os dois é sutil: O LEN retorna a quantidade de caracteres de um texto porém, ignora quando aparecem espaços a mais.

Já o DATALENGTH retorna a quantidade de caracteres, incluindo espaços a mais dentro do texto. */

-- Exemplo: Descubra a quantidade de caracteres da palavra 'SQL Hashtag'

SELECT
	LEN('SQL Hashtag') AS 'Len',
	DATALENGTH('SQL Hashtag') AS 'Datalength'

-- OBS 1: Só iremos visualizar uma diferença entre LEN e DATALENGTH se houver espaços em branco adicionais no final de uma palavra, pois o DATALENGTH também contará esses espaços em branco, enquanto o LEN não. Exemplo:

SELECT
	LEN('SQL Hashtag    ') AS 'Len', -- 4 caracteres vazios
	DATALENGTH('SQL Hashtag    ') AS 'Datalength' -- 4 caracteres vazios

-- OBS 2: A escolha da utilização de LEN e DATALENGTH vai depender se você precisará contar espaços vazios ou não. 