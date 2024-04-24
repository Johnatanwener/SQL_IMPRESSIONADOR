-- MÓDULO 21 - SQL SERVER - FUNCTIONS


-- Todas as functions dos exercícios a seguir devem ser criadas para manipulação de dados do banco de dados ContosoRetailDW.
USE ContosoRetailDW


/* EXERCICIO 01
 Crie uma Function que calcule o tempo (em anos) entre duas datas. Essa function deve receber dois argumentos: data_inicial e data_final. Caso a data_final não seja informada, a function deve automaticamente considerar a data atual do sistema. Essa function será usada para calcular o tempo de casa de cada funcionário.

Obs: a função DATEDIFF não é suficiente para resolver este problema. */
SELECT * FROM dimEmployee

CREATE OR ALTER FUNCTION fnCalculaDiferencaDatas(@data_incial DATE, @data_final DATE)
RETURNS INT
AS
BEGIN
	IF @data_final IS NULL SET @data_final = GETDATE()

	RETURN DATEDIFF(YEAR, @data_incial, @data_final)
END

SELECT
	FirstName,
	HireDate,
	EndDate,
	dbo.fnCalculaDiferencaDatas(HireDate, EndDate)
FROM dimEmployee

------------------------------

/* EXERCICIO 02
Crie uma function que calcula a bonificação de cada funcionário (5% a mais em relação ao BaseRate). Porém, tome cuidado! Nem todos os funcionários deverão receber bônus... */
SELECT * FROM DimEmployee

CREATE OR ALTER FUNCTION fnCalculaBonus(@salario FLOAT, @status VARCHAR(100), @percentual FLOAT)
RETURNS FLOAT
AS
BEGIN
	DECLARE @bonus AS FLOAT

	IF @status = 'Current'
		SET @bonus = @salario * @percentual
	ELSE
		SET @bonus = 0
	
	RETURN @bonus
END

SELECT
	FirstName,
	BaseRate,
	Status,
	dbo.fnCalculaBonus(baserate, status, 0.05) AS 'Bonificação de 5%'
FROM DimEmployee

------------------------------

/* EXERCICIO 03
Crie uma Function que retorna uma tabela. Esta function deve receber como parâmetro o gênero do cliente e retornar todos os clientes que são do gênero informado na function. Observe que esta function será utilizada particularmente com a tabela DimCustomer. */
SELECT * FROM DimCustomer

CREATE OR ALTER FUNCTION fnselect_genero(@genero VARCHAR(MAX))
RETURNS TABLE
AS
RETURN (SELECT * FROM DimCustomer WHERE gender = @genero)

SELECT * FROM dbo.fnselect_genero('F')

------------------------------

/* EXERCICIO 04
Crie uma Function que retorna uma tabela resumo com o total de produtos por cores. Sua function deve receber 1 argumento, onde será possível especificar de qual marca você deseja o resumo. */
SELECT * FROM DimProduct

CREATE OR ALTER FUNCTION fnanalisa_cores(@marca VARCHAR(MAX))
RETURNS TABLE
AS
RETURN (SELECT ColorName, COUNT(*) AS 'Total Produtos' FROM DimProduct WHERE BrandName = @marca GROUP BY ColorName)

SELECT * FROM dbo.fnanalisa_cores('Litware')