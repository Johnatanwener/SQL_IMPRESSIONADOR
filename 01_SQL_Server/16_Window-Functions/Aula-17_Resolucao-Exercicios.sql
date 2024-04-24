-- MÓDULO 16 - SQL SERVER - Window Function (Funções de Janela)


-- Para resolver os exercícios 1 a 4, crie uma View chamada vwProdutos, que contenha o agrupamento das colunas BrandName, ColorName e os totais de quantidade vendida por marca/cor e também o total de receita por marca/cor.
CREATE VIEW vwProdutos AS 
SELECT 
	BrandName AS 'Marca', 
	ColorName AS 'Cor', 
	COUNT(*) AS 'Quantidade_Vendida', 
	ROUND(SUM(SalesAmount), 2) AS 'Receita_Total' 
FROM DimProduct 
INNER JOIN FactSales 
	ON DimProduct.ProductKey = FactSales.ProductKey 
GROUP BY BrandName, ColorName

------------------------------

/* EXERCÍCIO 01: 
Utilize a View vwProdutos para criar uma coluna extra calculando a quantidade total vendida dos produtos. */
SELECT 
	*,
	SUM(Quantidade_Vendida) OVER() AS 'Qtd. Total Vendida'
FROM vwProdutos

------------------------------

/* EXERCÍCIO 02:
Crie mais uma coluna na consulta anterior, incluindo o total de produtos vendidos para cada marca. */
SELECT 
	*,
	SUM(Quantidade_Vendida) OVER() AS 'Qtd. Total Vendida',
	SUM(Quantidade_Vendida) OVER(PARTITION BY Marca) AS 'Qtd. Total (por Marca)'
FROM vwProdutos

------------------------------

/* EXERCÍCIO 03: 
Calcule o % de participação do total de vendas de produtos por marca. 
 
Ex: A marca A. Datum teve uma quantidade total de vendas de 199.041 de um total de 3.406.089 de vendas. Isso significa que a da marca A. Datum é 199.041/3.406.089 = 5,84%. */
SELECT 
	*,
	SUM(Quantidade_Vendida) OVER() AS 'Qtd. Total Vendida',
	SUM(Quantidade_Vendida) OVER(PARTITION BY Marca) AS 'Qtd. Total (por Marca)',
	FORMAT(1.0*SUM(Quantidade_Vendida) OVER(PARTITION BY Marca) / SUM(Quantidade_Vendida) OVER(), '0.00%') AS '% Participação'
FROM vwProdutos

------------------------------

/* EXERCÍCIO 04:
Crie uma consulta à View vwProdutos, selecionando as colunas Marca, Cor, Quantidade_Vendida e também criando uma coluna extra de Rank para descobrir a posição de cada Marca/Cor. Você deve obter o resultado abaixo. Obs: Sua consulta deve ser filtrada para que seja mostrada apenas a marca Contoso. */
SELECT
	*,
	ROW_NUMBER() OVER(ORDER BY Quantidade_Vendida DESC) AS 'Rank'
FROM vwProdutos
WHERE Marca = 'Contoso'

------------------------------

/* EXERCÍCIO DESAFIO 01:
Para responder os próximos 2 exercícios, você precisará criar uma View auxiliar. Diferente do que foi feito anteriormente, você não terá acesso ao código dessa view antes do gabarito. A sua view deve se chamar vwHistoricoLojas e deve conter um histórico com a quantidade de lojas abertas a cada Ano/Mês. Os desafios são: 

(1) Criar uma coluna de ID para essa View 
(2) Relacionar as tabelas DimDate e DimStore 

Dicas: 
1. A coluna de ID será criada a partir de uma função de janela. Você deverá se atentar a forma como essa coluna deverá ser ordenada, pensando que queremos visualizar uma ordem de Ano/Mês que seja: 2005/january, 2005/February... e não 2005/April, 2005/August... 
2- As colunas Ano, Mês e Qtd_Lojas correspondem, respectivamente, às seguintes colunas: CalendarYear e CalendarMonthLabel da tabela DimDate e uma contagem da coluna OpenDate da tabela DimStore. */

CREATE VIEW vwHistoricoLojas AS
SELECT
	ROW_NUMBER() OVER(ORDER BY CalendarMonth) AS 'ID',
	CalendarYear AS 'Ano',
	CalendarMonthLabel AS 'Mês',
	COUNT(OpenDate)AS 'Qtd_Lojas'
FROM DimDate
LEFT JOIN DimStore
	ON DimDate.DateKey = DimStore.OpenDate
GROUP BY CalendarYear, CalendarMonthLabel, CalendarMonth

SELECT * FROM vwHistoricoLojas

------------------------------

/* EXERCÍCIO 05:
A partir da view criada no exercício anterior, você deverá fazer uma soma móvel considerando sempre o mês atual + 2 meses para trás. */

SELECT
	*,
	SUM(Qtd_Lojas) OVER(ORDER BY ID ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS 'Soma Móvel'
FROM vwHistoricoLojas

------------------------------

/* EXERCÍCIO 06:
Utilize a vwHistoricoLojas para calcular o acumulado de lojas abertas a cada ano/mês. */

SELECT
	*,
	SUM(Qtd_Lojas) OVER(ORDER BY ID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS 'Acumulado'
FROM vwHistoricoLojas

------------------------------

/* EXERCÍCIO DESAFIO 02:
Neste desafio, você terá que criar suas próprias tabelas e views para conseguir resolver os exercícios 7 e 8. Os próximos exercícios envolverão análises de novos clientes. Para isso, será necessário criar uma nova tabela e uma nova view. 
Abaixo, temos um passo a passo para resolver o problema por partes. 

PASSO 1: Crie um novo banco de dados chamado Desafio e selecione esse banco de dados criado. 
PASSO 2: Crie uma tabela de datas entre o dia 1 de janeiro do ano com a compra (DateFirstPurchase) mais antiga e o dia 31 de dezembro do ano com a compra mais recente.  
	Obs.: 1. Chame essa tabela de Calendario. 
	Obs.: 2. A princípio, essa tabela deve conter apenas 1 coluna, chamada data e do tipo DATE. 
PASSO 3: Crie colunas auxiliares na tabela Calendario chamadas: Ano, Mes, Dia, AnoMes e NomeMes. Todas do tipo INT. 
PASSO 4: Adicione na tabela os valores de Ano, Mês, Dia, AnoMes e NomeMes (nome do mês em português). Dica: utilize a instrução CASE para verificar o mês e retornar o nome certo. 
PASSO 5: Crie a View vwNovosClientes, que deve ter as colunas mostradas abaixo. */


-- PASSO 1: Crie um novo banco de dados chamado Desafio e selecione esse banco de dados criado. 
CREATE DATABASE Desafio
USE Desafio


/* PASSO 2: Crie uma tabela de datas entre o dia 1 de janeiro do ano com a compra (DateFirstPurchase) mais antiga e o dia 31 de dezembro do ano com a compra mais recente.  
	Obs.: 1. Chame essa tabela de Calendario. 
	Obs.: 2. A princípio, essa tabela deve conter apenas 1 coluna, chamada data e do tipo DATE. */
SELECT * FROM ContosoRetailDW.dbo.DimCustomer ORDER BY DateFirstPurchase


CREATE TABLE Calendario (
	Data DATE
)

-- Declarando o ANO inicial e o ANO final
DECLARE @varAnoInicial INT = YEAR((SELECT MIN(DateFirstPurchase) FROM ContosoRetailDW.dbo.DimCustomer))
DECLARE @varAnoFinal INT = YEAR((SELECT MAX(DateFirstPurchase) FROM ContosoRetailDW.dbo.DimCustomer))

-- Declarando a DATA inicial e a DATA final
DECLARE @varDataInicial DATE = DATEFROMPARTS(@varAnoInicial, 1 ,1)
DECLARE @varDataFinal DATE = DATEFROMPARTS(@varAnoFinal, 12, 31)

-- Inserindo as informações de data na coluna Data da tabela Calendario
WHILE @varDataInicial <= @varDataFinal
BEGIN
	INSERT INTO Calendario(Data) VALUES(@varDataInicial)
	SET @varDataInicial = DATEADD(DAY, 1, @varDataInicial)
END

SELECT * FROM Calendario


-- PASSO 3: Crie colunas auxiliares na tabela Calendario chamadas: Ano, Mes, Dia, AnoMes e NomeMes.
ALTER TABLE Calendario
ADD Ano INT,
	Mes INT,
	Dia INT,
	AnoMes INT,
	NomeMes VARCHAR(50)

SELECT * FROM Calendario


-- PASSO 4: Adicione na tabela os valores de Ano, Mês, Dia, AnoMes e NomeMes (nome do mês em português). Dica: utilize a instrução CASE para verificar o mês e retornar o nome certo. 
UPDATE Calendario SET Ano = Year(Data)
UPDATE Calendario SET Mes = Month(Data)
UPDATE Calendario SET Dia = Day(Data)
UPDATE Calendario SET AnoMes = CONCAT(YEAR(Data), FORMAT(MONTH(Data), '00'))
UPDATE Calendario SET NomeMes = 
			CASE
				WHEN MONTH(Data) = 1 THEN 'Janeiro'
				WHEN MONTH(Data) = 2 THEN 'Fevereiro'
				WHEN MONTH(Data) = 3 THEN 'Março'
				WHEN MONTH(Data) = 4 THEN 'Abril'
				WHEN MONTH(Data) = 5 THEN 'Maio'
				WHEN MONTH(Data) = 6 THEN 'Junho'
				WHEN MONTH(Data) = 7 THEN 'Julho'
				WHEN MONTH(Data) = 8 THEN 'Agosto'
				WHEN MONTH(Data) = 9 THEN 'Setembro'
				WHEN MONTH(Data) = 10 THEN 'Outubro'
				WHEN MONTH(Data) = 11 THEN 'Novembro'
				WHEN MONTH(Data) = 12 THEN 'Dezembro'
			END

SELECT * FROM Calendario


-- PASSO 5: Crie a View vwNovosClientes, que deve ter as colunas mostradas abaixo.
CREATE VIEW vwNovosClientes AS
SELECT
	ROW_NUMBER() OVER(ORDER BY AnoMes) AS 'ID',
	Ano,
	NomeMes,
	COUNT(DimCustomer.DateFirstPurchase) AS 'Novos_Clientes'
FROM Calendario
LEFT JOIN ContosoRetailDW.dbo.DimCustomer
	ON Calendario.Data = DimCustomer.DateFirstPurchase
GROUP BY Ano, NomeMes, AnoMes

SELECT * FROM vwNovosClientes

------------------------------

/* EXERCÍCIO 07:
a) Faça um cálculo de soma móvel de novos clientes nos últimos 2 meses. 
b) Faça um cálculo de média móvel de novos clientes nos últimos 2 meses. 
c) Faça um cálculo de acumulado dos novos clientes ao longo do tempo.  
d) Faça um cálculo de acumulado intra-ano, ou seja, um acumulado que vai de janeiro a dezembro de cada ano, e volta a fazer o cálculo de acumulado no ano seguinte. */

-- a)
SELECT
	*,
	SUM(Novos_Clientes) OVER(ORDER BY ID ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS 'Soma Móvel (2 meses)',
	AVG(Novos_Clientes) OVER(ORDER BY ID ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS 'Média Móvel (2 meses)',
	SUM(Novos_Clientes) OVER(ORDER BY ID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS 'Soma Móvel Acumulado',
	SUM(Novos_Clientes) OVER(PARTITION BY Ano ORDER BY ID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS 'Acumulado YTD'
FROM vwNovosClientes

------------------------------

/* EXERCÍCIO 08:
Faça os cálculos de MoM e YoY para avaliar o percentual de crescimento de novos clientes, entre o mês atual e o mês anterior, e entre um mês atual e o mesmo mês do ano anterior. */
SELECT
	*,
	LAG(Novos_Clientes, 1) OVER(ORDER BY ID),
	FORMAT(1.0*Novos_Clientes/NULLIF(LAG(Novos_Clientes, 1) OVER(ORDER BY ID), 0) - 1, '0.00%') AS '% MoM',
	FORMAT(1.0*Novos_Clientes/NULLIF(LAG(Novos_Clientes, 12) OVER(ORDER BY ID), 0) - 1, '0.00%') AS '% YoY'
FROM vwNovosClientes