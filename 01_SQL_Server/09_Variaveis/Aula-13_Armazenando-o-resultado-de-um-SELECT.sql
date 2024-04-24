-- MÓDULO 09 - SQL SERVER - VARIÁVEIS


/* AULA 13 - ARMAZENANDO O RESULTATO DE UM SELECT EM UMA VARIÁVEL
Podemos também armazenar o resultado de uma consulta (SELECT) dentro de uma variável.

No exemplo abaixo, armazenamos dentro de duas variáveis os resultados de dois SELECTs: um que calcula a quantidade de funcionários em uma empresa, e o outro que calcula a quantidade de clientes, ambos considerando uma data de nascimento.

Exemplo 0: Crie uma variável de data para otimizar a consulta abaixo. */
DECLARE @varData DATETIME
DECLARE @varNumFuncionarios INT
DECLARE @varNumClientes INT
SET @varData = '01/01/1980'
SET @varNumFuncionarios = (SELECT COUNT(*) FROM DimEmployee WHERE BirthDate >= @varData)
SET @varNumClientes = (SELECT COUNT(*) FROM DimCustomer WHERE BirthDate >= @varData)

SELECT 'Número de Funcionários', @varNumFuncionarios
UNION
SELECT 'Número de Clientes', @varNumClientes


-- Exemplo 1: Crie uma variável para armazenar a quantidade total de funcionários da tabela DimEmployee.
SELECT COUNT(*) FROM DimEmployee

DECLARE @varTotalFuncionarios INT
SET @varTotalFuncionarios = (SELECT COUNT(*) FROM DimEmployee)
SELECT @varTotalFuncionarios


-- Exemplo 2: Crie uma variável para armazenar a quantidade total de lojas com o status Off.
SELECT COUNT(*) FROM DimStore WHERE Status = 'Off'

DECLARE @varLojasOff INT
SET @varLojasOff = (SELECT COUNT(*) FROM DimStore WHERE Status = 'Off')
SELECT @varLojasOff