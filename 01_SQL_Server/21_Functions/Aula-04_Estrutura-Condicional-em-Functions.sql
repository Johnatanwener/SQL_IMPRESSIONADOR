-- MÓDULO 21 - SQL SERVER - FUNCTIONS


/* AULA 04 - Adicionando uma estrutura condicional em nossa Function
- Alterando e excluindo uma function

Para alterar uma function, devemos, na primeira linha do nosso código, utilizar o comando ALTER FUNCTION: 

Recomendado: Quando for criar uma FUNCTION, utilizar o comando CREATE OR ALTER FUNCTION, pois se a função não existir no banco de dados, será criada porém, se ela já existe será alterada. Poderiamos usar CREATE FUNCTION e depois ALTER FUNCTION porém, eu (professor) prefiro fazer desta forma pois já fica os dois comandos de uma vez só. 

Obs.: Se errar ao criar uma Function ou quiser exclui-lá do banco de dados basta usar o comando DROP */

DROP FUNCTION 'nome da function'

-- Imagine que queiramos adicionar na coluna de data por extenso que criamos anteriormente a informação de semestre, de acordo com o mês, utilizariamos o comando CASE e fariamos da seguinte forma:
CREATE OR ALTER FUNCTION fnDataCompleta(@data AS DATE)
RETURNS VARCHAR(MAX)
AS
BEGIN

	RETURN DATENAME(DW, @Data) + ', ' +
			DATENAME(D, @Data) + ' de ' +
			DATENAME(M, @Data) + ' de ' + 
			DATENAME(YY, @Data) + ' - ' +
			CASE
				WHEN MONTH(@Data) <= 6 THEN
					'(1º Semestre)'
				ELSE
					'(2º Semestre)'
			END

END
-----
SELECT
	nome_cliente,
	data_de_nascimento,
	[dbo].[fnDataCompleta](data_de_nascimento)
FROM
	dCliente

DROP FUNCTION fnDataCompleta