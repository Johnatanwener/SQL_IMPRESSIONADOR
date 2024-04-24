-- MÓDULO 22 - SQL SERVER - PROCEDURES


-- AULA 07-08 - Criando uma Procedure mais Complexa para Cadastro de Contratos

SELECT * FROM dCliente
SELECT * FROM dGerente
SELECT * FROM fContratos

/*
Exemplo: Crie uma procedure para cadastrar uma nova assinatura de um contrato na tabela fContratos (com parâmetros).
Gerente: Lucas Sampaio
Cliente: Gustavo Barbosa
Valor do Contrato: 5000

- 1º Passo: Definir as variáveis a serem utilizadas.
- 2º Passo: Armazenar o valor de id_gerente de acordo com o gerente associado
- 3º Passo: Armazenar o valor de id_cliente de acordo com o nome do cliente
- 4º Passo: Armazenar a data da assinatura como sendo a data atual do sistema
- 5º Passo: Utilizar o INSERT INTO para inserir os dados na tabela fContratos
*/

CREATE OR ALTER PROCEDURE prRegistraContrato(@gerente VARCHAR(MAX), @cliente VARCHAR(MAX), @valor FLOAT)
AS
BEGIN
	DECLARE
		@vIdGerente INT,
		@vIdCliente INT

	SELECT
		@vIdGerente = id_gerente
	FROM dGerente
	WHERE nome_gerente = @gerente

	SELECT
		@vIdCliente = id_cliente
	FROM dCliente
	WHERE nome_cliente = @cliente

	INSERT INTO fContratos(data_assinatura, id_cliente, id_gerente, valor_contrato) VALUES
		(GETDATE(), @vIdCliente, @vIdGerente, @valor)

	PRINT 'Contrato registrado com sucesso!'
END

EXECUTE prRegistraContrato @gerente = 'Lucas Sampaio', @cliente = 'Gustavo Barbosa', @valor = 5000

SELECT * FROM fContratos
SELECT * FROM dCliente
SELECT * FROM dGerente