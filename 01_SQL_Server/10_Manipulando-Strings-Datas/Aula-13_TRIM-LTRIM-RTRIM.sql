-- M�DULO 10 - SQL SERVER - Manipulando Strings e Datas


/* AULA 13 - TRIM, LTRIM e RTRIM
As fun��es TRIM, LTRIM e RTRIM s�o fun��es que nos permitem retirar espa�os adicionais de um texto.

A fun��o TRIM retira espa�os adicionais � esquerda e � direita do texto
A fun��o LTRIM retira espa�os adicionais � esquerda do texto
A fun��o RTRIM retira espa�os adicionais � direita do texto 

Visualmente, parece que n�o h� diferen�a na aplica��o dessas 3 fun��es. Por�m, se utilizarmos a fun��o DATALENGTH sobre cada um dos resultados, vemos a diferen�a.
*/

-- Utilize as fun��es acima no c�digo '   ABC123   '
DECLARE @varCodigo VARCHAR(MAX)
SET @varCodigo = '   ABC123   '

SELECT
	TRIM(@varCodigo) AS 'Trim',
	LTRIM(@varCodigo) AS 'Ltrim',
	RTRIM(@varCodigo) AS 'Rtrim'
-- Parece que est� tudo igual por�m, se utilizarmos a fun��o DATALENGTH veremos a diferen�a

SELECT
	DATALENGTH(TRIM(@varCodigo)) AS 'Trim', -- Removeu todos os espa�os
	DATALENGTH(LTRIM(@varCodigo)) AS 'Ltrim', -- Removeu apenas os espa�os a esquerda
	DATALENGTH(RTRIM(@varCodigo)) AS 'Rtrim' -- Removeu apenas os espa�os a direita
