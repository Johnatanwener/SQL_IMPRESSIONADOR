-- M�DULO 21 - SQL SERVER - FUNCTIONS


/* AULA 05 - Criando funcoes complexas pt. 01
- Crie uma fun��o para retornar o primeiro nome de cada gerente. */

SELECT * FROM dGerente

SELECT 
	nome_gerente,
	LEFT(nome_gerente, CHARINDEX(' ', nome_gerente) - 1) AS primeiro_nome
FROM dGerente

-- Obs�.: Se eu criar um gerente que s� tenha o nome inserido, e executar a fun��o acima novamente, ser� apresentado um erro.
INSERT INTO dGerente(nome_gerente, data_contratacao, salario) VALUES
	('Jo�o', '10/01/2019', 3100)

-- O que ocorreu?: A fun��o percorreu toda nossa tabela dGerente e localizou o primeiro nome de todos os nossos gerentes corretamente a partir do espa�o (CHARINDEX) por�m, ao chegar no Jo�o, a nossa consulta n�o localizou o espa�o (CHARINDEX), e por isso retornou zero e ao finalizar a fun��o subtraiu - 1, o que fez com que o zero fosse exclu�do, o que fez com que toda a consulta perdesse o sentido e desse um erro. 
-- Obs�.: Para contornar o erro apresentado, ser� necess�rio criarmos uma Function.

------------------------------

-- AULA 06 - Criando funcoes complexas pt. 02

CREATE OR ALTER FUNCTION fnPrimeiroNome(@nomeCompleto AS VARCHAR(MAX))
RETURNS VARCHAR(MAX)
AS
BEGIN

	DECLARE @posicaoEspaco AS INT
	DECLARE @resposta AS VARCHAR(MAX)

	SET @posicaoEspaco = CHARINDEX(' ', @nomeCompleto)

	IF @posicaoEspaco = 0
		SET @resposta = @nomeCompleto
	ELSE
		SET @resposta = LEFT(@nomeCompleto, @posicaoEspaco - 1)

	RETURN @resposta

END

SELECT
	nome_gerente,
	dbo.fnPrimeiroNome(nome_gerente) AS primeiro_nome
FROM dGerente