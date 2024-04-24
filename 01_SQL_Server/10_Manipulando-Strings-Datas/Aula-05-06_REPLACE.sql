-- MÓDULO 10 - SQL SERVER - Manipulando Strings e Datas


/* AULA 05 - REPLACE PT. 01
A função REPLACE permite que a gente substitua um determinado texto por outro texto. */

-- No texto 'O Excel é o melhor', substitua 'Excel' por 'SQL'
SELECT REPLACE('O Excel é o melhor', 'Excel', 'SQL')

-- Exemplo: Crie uma consulta a partir de DimCustomer onde você retorna o Nome Completo dos Clientes, a coluna de Sexo (Abrev) e uma outra coluna de Sexo substituindo M por Masculino e F por Feminino
SELECT * FROM DimCustomer

SELECT
	FirstName AS 'Nome',
	LastName AS 'Sobrenome',
	Gender AS 'Sexo (Abrev.)',
	REPLACE(Gender, 'M', 'Masculino') AS 'Sexo'
FROM
	DimCustomer

------------------------------

-- AULA 06 - REPLACE PT. 02

SELECT
	FirstName AS 'Nome',
	LastName AS 'Sobrenome',
	Gender AS 'Sexo (Abrev.)',
	REPLACE(REPLACE(Gender, 'M', 'Masculino'), 'F', 'Feminino') AS 'Sexo'
FROM
	DimCustomer

SELECT
	CONCAT(FirstName, ' ', LastName) AS 'Nome Completo',
	Gender AS 'Sexo (Abrev)',
	REPLACE(REPLACE(Gender, 'M', 'Masculino'), 'F', 'Feminino') AS 'Sexo (Extenso)'
FROM
	DimCustomer
