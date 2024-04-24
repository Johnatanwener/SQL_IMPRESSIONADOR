-- M�DULO 15 - SQL SERVER - LOOPS NO SQL


/* EXERC�CIO 01
Utilize o Loop While para criar um contador que comece em um valor inicial @ValorInicial e termine em um valor final @ValorFinal. Voc� dever� printar na tela a seguinte frase: �O valor do contador �: � + ___ */

DECLARE @ValorInicial INT = 1
DECLARE @ValorFinal INT = 100

WHILE @ValorInicial <= @ValorFinal
BEGIN
	PRINT CONCAT('O valor do contador �: ', @ValorInicial)
	SET @ValorInicial += 1
END

------------------------------

/* EXERC�CIO 02
Voc� dever� criar uma estrutura de repeti��o que printe na tela a quantidade de contrata��es para cada ano, desde 1996 at� 2003. A informa��o de data de contrata��o encontra-se na coluna HireDate da tabela DimEmployee. Utilize o formato: 

X contrata��es em 1996 
Y contrata��es em 1997 
Z contrata��es em 1998 
... 
... 
N contrata��es em 2003 

Obs: a coluna HireDate cont�m a data completa (dd/mm/aaaa). Lembrando que voc� dever� printar a quantidade de contrata��es por ano. */

DECLARE @AnoInicial INT = 1996
DECLARE @AnoFinal INT = 2003

WHILE @AnoInicial <= @AnoFinal
BEGIN
	DECLARE @QtdFuncionarios INT = (SELECT COUNT(*) FROM DimEmployee WHERE YEAR(HireDate) = @AnoInicial)
	PRINT CONCAT(@QtdFuncionarios, ' contrata��es em ', @AnoInicial)
	SET @AnoInicial += 1
END

SELECT COUNT(*) FROM DimEmployee WHERE YEAR(HireDate) = @AnoInicial

------------------------------

/* EXERC�CIO 03
Utilize um Loop While para criar uma tabela chamada Calendario, contendo uma coluna que comece com a data 01/01/2021 e v� at� 31/12/2021. */

CREATE TABLE Calendario (
	Data DATE 
)

DECLARE @DataInicio DATE = '01/01/2021'
DECLARE @DataFim DATE = '31/12/2021'

WHILE @DataInicio <= @DataFim
BEGIN
	INSERT INTO Calendario (Data) VALUES (@DataInicio)
	SET @DataInicio = DATEADD(DAY, 1, @DataInicio)
END

SELECT * FROM Calendario

DROP TABLE Calendario