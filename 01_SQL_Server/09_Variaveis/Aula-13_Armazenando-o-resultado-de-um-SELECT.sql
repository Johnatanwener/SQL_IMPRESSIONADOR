-- M�DULO 09 - SQL SERVER - VARI�VEIS


/* AULA 13 - ARMAZENANDO O RESULTATO DE UM SELECT EM UMA VARI�VEL
Podemos tamb�m armazenar o resultado de uma consulta (SELECT) dentro de uma vari�vel.

No exemplo abaixo, armazenamos dentro de duas vari�veis os resultados de dois SELECTs: um que calcula a quantidade de funcion�rios em uma empresa, e o outro que calcula a quantidade de clientes, ambos considerando uma data de nascimento.

Exemplo 0: Crie uma vari�vel de data para otimizar a consulta abaixo. */
DECLARE @varData DATETIME
DECLARE @varNumFuncionarios INT
DECLARE @varNumClientes INT
SET @varData = '01/01/1980'
SET @varNumFuncionarios = (SELECT COUNT(*) FROM DimEmployee WHERE BirthDate >= @varData)
SET @varNumClientes = (SELECT COUNT(*) FROM DimCustomer WHERE BirthDate >= @varData)

SELECT 'N�mero de Funcion�rios', @varNumFuncionarios
UNION
SELECT 'N�mero de Clientes', @varNumClientes


-- Exemplo 1: Crie uma vari�vel para armazenar a quantidade total de funcion�rios da tabela DimEmployee.
SELECT COUNT(*) FROM DimEmployee

DECLARE @varTotalFuncionarios INT
SET @varTotalFuncionarios = (SELECT COUNT(*) FROM DimEmployee)
SELECT @varTotalFuncionarios


-- Exemplo 2: Crie uma vari�vel para armazenar a quantidade total de lojas com o status Off.
SELECT COUNT(*) FROM DimStore WHERE Status = 'Off'

DECLARE @varLojasOff INT
SET @varLojasOff = (SELECT COUNT(*) FROM DimStore WHERE Status = 'Off')
SELECT @varLojasOff