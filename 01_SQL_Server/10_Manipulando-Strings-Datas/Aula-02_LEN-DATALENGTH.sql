-- M�DULO 10 - SQL SERVER - Manipulando Strings e Datas


/* AULA 02 - LEN e DATALENGTH
As fun��es LEN e DATALENGTH possuem resultados semelhantes: ambos retornam a quantidade de caracteres de um determinado texto.

A grande diferen�a entre os dois � sutil: O LEN retorna a quantidade de caracteres de um texto por�m, ignora quando aparecem espa�os a mais.

J� o DATALENGTH retorna a quantidade de caracteres, incluindo espa�os a mais dentro do texto. */

-- Exemplo: Descubra a quantidade de caracteres da palavra 'SQL Hashtag'

SELECT
	LEN('SQL Hashtag') AS 'Len',
	DATALENGTH('SQL Hashtag') AS 'Datalength'

-- OBS 1: S� iremos visualizar uma diferen�a entre LEN e DATALENGTH se houver espa�os em branco adicionais no final de uma palavra, pois o DATALENGTH tamb�m contar� esses espa�os em branco, enquanto o LEN n�o. Exemplo:

SELECT
	LEN('SQL Hashtag    ') AS 'Len', -- 4 caracteres vazios
	DATALENGTH('SQL Hashtag    ') AS 'Datalength' -- 4 caracteres vazios

-- OBS 2: A escolha da utiliza��o de LEN e DATALENGTH vai depender se voc� precisar� contar espa�os vazios ou n�o. 