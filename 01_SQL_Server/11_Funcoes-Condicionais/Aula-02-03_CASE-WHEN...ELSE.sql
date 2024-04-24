-- M�dulo 11 - SQL SERVER - FUN��ES CONDICIONAIS


/* AULA 02 - CASE WHEN... ELSE (Explica��o)
Assim como qualquer linguagem de programa��o, no SQL tamb�m podemos tratar condi��es.

A estrutura utilizada para o tratamento de condi��es no SQL � o CASE. A fun��o CASE nos permite tratar condi��es e retornar um determinado valor, de acordo com o resultado de um ou mais testes l�gicos. Essa fun��o tem exatamente o mesmo objetivo das fun��es SE e IF que voc� deve ter visro em algum momento.

Um exemplo simples de utiliza��o da instru��o CASE � incluindo em nosso c�digo dentro de um SELECT como se fosse uma nova coluna.

CASE
	WHEN teste_logico THEN 'resultado1'
	ELSE 'resultado2'
END
*/

-- Exemplo 1: Determine a situa��o do aluno. Se a M�dia for >= 6, ent�o est� aprovado. Caso contr�rio, reprovado.
DECLARE @varNota FLOAT
SET @varNota = 6

SELECT
	CASE
		WHEN @varNota >= 6 THEN 'Aprovado'
		ELSE 'Reprovado'
	END AS 'Situa��o'


-- Exemplo 2: A data de vencimento de um produto � no dia 10/03/2022. Fa�a um teste l�gico para verificar se um produto passou da validade ou n�o.
DECLARE @varDataVencimento DATETIME, @varDataAtual DATETIME
SET @varDataVencimento = '10/03/2025'
SET @varDataAtual = '30/04/2022'

SELECT
	CASE
		WHEN @varDataAtual > @varDataVencimento THEN 'Produto Vencido'
		ELSE 'Na validade'
	END

------------------------------

-- AULA 03 - CASE WHEN... ELSE (Exemplo)
-- Exemplo: Fa�a um SELECT das colunas CustomerKey, FirstName e Gender na tabela DimCustomer e utilize o CASE para criar uma 4� coluna com a informa��o de 'Masculino' ou 'Feminino'.

SELECT * FROM DimCustomer

SELECT
	CustomerKey AS 'ID Cliente',
	FirstName AS 'Nome',
	Gender AS 'Sexo',
	CASE
		WHEN Gender = 'M' THEN 'Masculino'
		ELSE 'Feminino'
	END AS 'Sexo (CASE)'
FROM
	DimCustomer