-- Módulo 11 - SQL SERVER - FUNÇÕES CONDICIONAIS


/* AULA 09 - IIF (Alternativa ao CASE)
Uma alternatica ao CASE seria a função IIF. Ela é muito semelhante com a fórmula SE do Excel, pois pede 3 argumentos.
1. Teste lógico
2. Valor se verdadeiro
3. Valor se falso

No exercício abaixo, queremos classificar um projeto de acordo com o seu nível de risco. Utilizamos para isso uma variável. */

-- Exemplo 1: Qual é a categoria de risco do projeto abaixo, de acordo com a sua nota:
-- Risco Alto: Classicacao >= 5
-- Risco Baixo: Classificacao < 5

DECLARE @varClassificacao INT
SET @varClassificacao = 9
SELECT
	IIF(
		@varClassificacao >= 5,
		'Risco Alto',
		'Risco Baixo'
		) AS 'Status'

-- Exemplo 2: Crie uma coluna única de 'Cliente', contendo o nome do cliente, seja ele uma pessoa ou uma empresa. Traga também a coluna de CustomerKey e CustomerType.
SELECT * FROM DimCustomer
SELECT
	CustomerKey AS 'ID Cliente',
	CustomerType AS 'Tipo Cliente',
	IIF(
		CustomerType = 'Person',
		FirstName,
		CompanyName) AS 'Cliente'
FROM
	DimCustomer