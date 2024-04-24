-- Módulo 11 - SQL SERVER - FUNÇÕES CONDICIONAIS


/* AULA 02 - CASE WHEN... ELSE (Explicação)
Assim como qualquer linguagem de programação, no SQL também podemos tratar condições.

A estrutura utilizada para o tratamento de condições no SQL é o CASE. A função CASE nos permite tratar condições e retornar um determinado valor, de acordo com o resultado de um ou mais testes lógicos. Essa função tem exatamente o mesmo objetivo das funções SE e IF que você deve ter visro em algum momento.

Um exemplo simples de utilização da instrução CASE é incluindo em nosso código dentro de um SELECT como se fosse uma nova coluna.

CASE
	WHEN teste_logico THEN 'resultado1'
	ELSE 'resultado2'
END
*/

-- Exemplo 1: Determine a situação do aluno. Se a Média for >= 6, então está aprovado. Caso contrário, reprovado.
DECLARE @varNota FLOAT
SET @varNota = 6

SELECT
	CASE
		WHEN @varNota >= 6 THEN 'Aprovado'
		ELSE 'Reprovado'
	END AS 'Situação'


-- Exemplo 2: A data de vencimento de um produto é no dia 10/03/2022. Faça um teste lógico para verificar se um produto passou da validade ou não.
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
-- Exemplo: Faça um SELECT das colunas CustomerKey, FirstName e Gender na tabela DimCustomer e utilize o CASE para criar uma 4ª coluna com a informação de 'Masculino' ou 'Feminino'.

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