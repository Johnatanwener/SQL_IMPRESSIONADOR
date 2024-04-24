-- M�DULO 09 - SQL SERVER - VARI�VEIS

/* 
AULA 10 - Cuidado ao executar o c�digo com vari�veis
AULA 11 - UTILIZANDO UMA VARI�VEL EM UMA CONSULTA PT. 01
� poss�vel utilizar vari�veis dentro de consultas, como mostrado no exemplo abaixo.

Criamos uma vari�vel @varDesconto para armazenar um determinado valor e usamos em nossa estrutura para calcular o pre�o com desconto em cima dos produtos.

Exemplo 1: Aplique um desconto de 10% em todos os pre�os dos produtos. Sua consulta final deve conter as colunas ProductKey, ProductName, UnitPrice e Pre�o com Desconto. */ 

preco = 100
desconto = 10% = 10/100 = 0.10
valor_do_desconto = 100 * 0.10 = 10
preco_com_desconto = 100 - 100 * 0.10 = 90
preco_com_desconto = 100 * (1 - 0.10) = 90
preco_com_desconto = 100 * (1 - desconto) = 90


DECLARE @varDesconto FLOAT
SET @varDesconto = 0.20

SELECT
	ProductKey AS 'ID',
	ProductName AS 'Nome do Produto',
	UnitPrice AS 'Pre�o Unit�rio',
	--UnitPrice * (1 - 0.10) AS 'Preco com Desconto'
	UnitPrice * (1 - @varDesconto) AS 'Preco com Desconto'
FROM
	DimProduct

------------------------------

/* AULA 12 - UTILIZANDO UMA VARI�VEL EM UMA CONSULTA PT. 02
Abaixo, temos mais um exemplo de como usar vari�veis dentro de consultas.

Dessa vez, criamos uma vari�vel @varData para tornar o filtro das consultas mais autom�tico.
Assim, sempre que precisarmos analisar uma nova data, alteramos o valor da vari�vel uma �nica vez e todos os lugares que utilizam esse c�digo ser�o atualizados automaticamente.

Crie uma vari�vel de data para otimizar a consulta abaixo. */

DECLARE @varData DATETIME
SET @varData = '01/01/1980'

SELECT 
	FirstName AS 'Nome',
	LastName AS 'Sobrenome',
	BirthDate AS 'Nascimento',
	'Cliente' AS 'Tipo'
FROM	
	DimCustomer
WHERE BirthDate >= @varData

UNION

SELECT 
	FirstName AS 'Nome',
	LastName AS 'Sobrenome',
	BirthDate AS 'Nascimento',
	'Funcion�rio' AS 'Tipo'
FROM	
	DimEmployee
WHERE BirthDate >= @varData
ORDER BY Nascimento