-- M�DULO 09 - SQL SERVER - VARI�VEIS


/* AULA 14 - PRINT - PRINTANDO UMA MENSAGEM NA TELA
Um outro comando muito �til � o PRINT. Podemos criar um c�digo para printar/exibir um determinado valor na caixa de mensagens. */

SELECT * FROM DimProduct
SELECT COUNT(*) FROM DImProduct

-- Exemplo 1: Printe na tela a quantidade de lojas On e a quantidade  de lojas Off da tabela DimStore. Utilize vari�veis para isso.
SET NOCOUNT ON

DECLARE @varLojasOn INT, @varLojasOff INT
SET @varLojasOn = (SELECT COUNT(*) FROM DimStore WHERE Status = 'On')
SET @varLojasOff = (SELECT COUNT(*) FROM DimStore WHERE Status = 'Off')

SELECT @varLojasOn AS 'Lojas Abertas', @varLojasOff AS 'Lojas Fechadas'


--PRINT @varLojasOn
--PRINT @varLojasOff
-- PRINT 'O total de lojas abertas � de ' + @varLojasOn
-- PRINT 'O total de lojas fechadas � de ' + @varLojasOff)
-- Obs: Executando a consulta desta forma, ser� retornado uma mensagem de erro pois estou tentando juntar um TEXTO com um N�MERO, por isso colocamos o CAST para for�ar a variavel ser entendida como VARCHAR

PRINT 'O total de lojas abertas � de ' + CAST(@varLojasOn AS VARCHAR(30))
PRINT 'O total de lojas fechadas � de ' + CAST(@varLojasOff AS VARCHAR(30))

-- E para excluir o texto que aparece na aba Mensagens (X linhas afetadas) precisaremos inserir um comando no inicio da consulta. SET NOCOUNT ON