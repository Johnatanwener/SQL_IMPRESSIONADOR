-- MÓDULO 10 - SQL SERVER - Manipulando Strings e Datas


/* AULA 13 - TRIM, LTRIM e RTRIM
As funções TRIM, LTRIM e RTRIM são funções que nos permitem retirar espaços adicionais de um texto.

A função TRIM retira espaços adicionais à esquerda e à direita do texto
A função LTRIM retira espaços adicionais à esquerda do texto
A função RTRIM retira espaços adicionais à direita do texto 

Visualmente, parece que não há diferença na aplicação dessas 3 funções. Porém, se utilizarmos a função DATALENGTH sobre cada um dos resultados, vemos a diferença.
*/

-- Utilize as funções acima no código '   ABC123   '
DECLARE @varCodigo VARCHAR(MAX)
SET @varCodigo = '   ABC123   '

SELECT
	TRIM(@varCodigo) AS 'Trim',
	LTRIM(@varCodigo) AS 'Ltrim',
	RTRIM(@varCodigo) AS 'Rtrim'
-- Parece que está tudo igual porém, se utilizarmos a função DATALENGTH veremos a diferença

SELECT
	DATALENGTH(TRIM(@varCodigo)) AS 'Trim', -- Removeu todos os espaços
	DATALENGTH(LTRIM(@varCodigo)) AS 'Ltrim', -- Removeu apenas os espaços a esquerda
	DATALENGTH(RTRIM(@varCodigo)) AS 'Rtrim' -- Removeu apenas os espaços a direita
