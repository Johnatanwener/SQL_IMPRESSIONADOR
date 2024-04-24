-- MÓDULO 15 - SQL SERVER - LOOPS NO SQL


/* EXERCÍCIO 01
Utilize o Loop While para criar um contador que comece em um valor inicial @ValorInicial e termine em um valor final @ValorFinal. Você deverá printar na tela a seguinte frase: “O valor do contador é: “ + ___ */

DECLARE @ValorInicial INT = 1
DECLARE @ValorFinal INT = 100

WHILE @ValorInicial <= @ValorFinal
BEGIN
	PRINT CONCAT('O valor do contador é: ', @ValorInicial)
	SET @ValorInicial += 1
END

------------------------------

/* EXERCÍCIO 02
Você deverá criar uma estrutura de repetição que printe na tela a quantidade de contratações para cada ano, desde 1996 até 2003. A informação de data de contratação encontra-se na coluna HireDate da tabela DimEmployee. Utilize o formato: 

X contratações em 1996 
Y contratações em 1997 
Z contratações em 1998 
... 
... 
N contratações em 2003 

Obs: a coluna HireDate contém a data completa (dd/mm/aaaa). Lembrando que você deverá printar a quantidade de contratações por ano. */

DECLARE @AnoInicial INT = 1996
DECLARE @AnoFinal INT = 2003

WHILE @AnoInicial <= @AnoFinal
BEGIN
	DECLARE @QtdFuncionarios INT = (SELECT COUNT(*) FROM DimEmployee WHERE YEAR(HireDate) = @AnoInicial)
	PRINT CONCAT(@QtdFuncionarios, ' contratações em ', @AnoInicial)
	SET @AnoInicial += 1
END

SELECT COUNT(*) FROM DimEmployee WHERE YEAR(HireDate) = @AnoInicial

------------------------------

/* EXERCÍCIO 03
Utilize um Loop While para criar uma tabela chamada Calendario, contendo uma coluna que comece com a data 01/01/2021 e vá até 31/12/2021. */

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