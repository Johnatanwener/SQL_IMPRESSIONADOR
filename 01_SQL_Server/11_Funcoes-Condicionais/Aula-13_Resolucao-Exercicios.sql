-- M�dulo 11 - SQL SERVER - FUN��ES CONDICIONAIS


/*  EXERC�CIO 01.
O setor de vendas decidiu aplicar um desconto aos produtos de acordo com a sua classe. O percentual aplicado dever� ser de: 

Economy -> 5% 
Regular -> 7% 
Deluxe -> 9% 

a) Fa�a uma consulta � tabela DimProduct que retorne as seguintes colunas: ProductKey, ProductName, e outras duas colunas que dever�o retornar o % de Desconto e UnitPrice com desconto. 
b) Fa�a uma adapta��o no c�digo para que os % de desconto de 5%, 7% e 9% sejam facilmente modificados (dica: utilize vari�veis). */
SELECT * FROM DimProduct

-- a)
-- % de Desconto
SELECT 
	ProductKey AS 'ID Produto',
	ProductName AS 'Nome Produto',
	ClassName AS 'Classe Produto',
	UnitPrice AS 'Pre�o Unit�rio',
	CASE
		WHEN ClassName = 'Economy' THEN 0.05
		WHEN ClassName = 'Regular' THEN 0.07
		ELSE 0.09
	END AS '% de Desconto'
FROM 
	DimProduct

-- Pre�o com Desconto
SELECT 
	ProductKey AS 'ID Produto',
	ProductName AS 'Nome Produto',
	ClassName AS 'Classe Produto',
	UnitPrice AS 'Pre�o Unit�rio',
	CASE
		WHEN ClassName = 'Economy' THEN (1 - 0.05) * UnitPrice
		WHEN ClassName = 'Regular' THEN (1 - 0.07) * UnitPrice
		ELSE (1 - 0.09) * UnitPrice
	END AS 'Pre�o com Desconto'
FROM 
	DimProduct

-- b)
DECLARE @varEconomy FLOAT, @varRegular FLOAT, @varDeluxe FLOAT
SET @varEconomy = 0.05
SET @varRegular = 0.07
SET @varDeluxe = 0.09

-- % de Desconto
SELECT 
	ProductKey AS 'ID Produto',
	ProductName AS 'Nome Produto',
	ClassName AS 'Classe Produto',
	UnitPrice AS 'Pre�o Unit�rio',
	CASE
		WHEN ClassName = 'Economy' THEN @varEconomy
		WHEN ClassName = 'Regular' THEN @varRegular
		ELSE @varDeluxe
	END AS '% de Desconto'
FROM 
	DimProduct

-- Pre�o com Desconto
SELECT 
	ProductKey AS 'ID Produto',
	ProductName AS 'Nome Produto',
	ClassName AS 'Classe Produto',
	UnitPrice AS 'Pre�o Unit�rio',
	CASE
		WHEN ClassName = 'Economy' THEN (1 - @varEconomy) * UnitPrice
		WHEN ClassName = 'Regular' THEN (1 - @varRegular) * UnitPrice
		ELSE (1 - @varDeluxe) * UnitPrice
	END AS 'Pre�o com Desconto'
FROM 
	DimProduct

---------------------------

/* EXERC�CIO 02.
Voc� ficou respons�vel pelo controle de produtos da empresa e dever� fazer uma an�lise da quantidade de produtos por Marca. 

A divis�o das marcas em categorias dever� ser a seguinte: 
CATEGORIA A: Mais de 500 produtos  
CATEGORIA B: Entre 100 e 500 produtos  
CATEGORIA C: Menos de 100 produtos  

Fa�a uma consulta � tabela DimProduct e retorne uma tabela com um agrupamento de Total de Produtos por Marca, al�m da coluna de Categoria, conforme a regra acima. */

SELECT * FROM DimProduct

SELECT
	BrandName AS 'Marca',
	COUNT(*) AS 'Qtd. Produtos',
	CASE
		WHEN COUNT(*) >= 500 THEN 'Categoria A'
		WHEN COUNT(*) >= 100 THEN 'Categoria B'
		ELSE 'Categoria C'
	END AS 'Categorias'
FROM DimProduct
GROUP BY BrandName

---------------------------

/* EXERC�CIO 03.
 Ser� necess�rio criar uma categoriza��o de cada loja da empresa considerando a quantidade de funcion�rios de cada uma. A l�gica a ser seguida ser� a l�gica abaixo: 

EmployeeCount >= 50; 'Acima de 50 funcion�rios' 
EmployeeCount >= 40; 'Entre 40 e 50 funcion�rios' 
EmployeeCount >= 30; 'Entre 30 e 40 funcion�rios' 
EmployeeCount >= 20; 'Entre 20 e 30 funcion�rios' 
EmployeeCount >= 10; 'Entre 10 e 20 funcion�rios' 
Caso contr�rio: 'Abaixo de 10 funcion�rios' 

Fa�a uma consulta � tabela DimStore que retorne as seguintes informa��es: StoreName, EmployeeCount e a coluna de categoria, seguindo a regra acima. */

SELECT * FROM DimStore

SELECT
	StoreName AS 'Nome da Loja',
	EmployeeCount As 'Qtd. Funcionarios',
	CASE
		WHEN EmployeeCount >= 50 THEN 'Acima de 50 funcion�rios'
		WHEN EmployeeCount >= 40 THEN 'Entre 40 e 50 funcion�rios'
		WHEN EmployeeCount >= 30 THEN 'Entre 30 e 40 funcion�rios'
		WHEN EmployeeCount >= 20 THEN 'Entre 20 e 30 funcion�rios'
		WHEN EmployeeCount >= 10 THEN 'Entre 10 e 20 funcion�rios'
		ELSE 'Abaixo de 10 funcion�rios' 
	END AS 'Categorias'
FROM
	DimStore

---------------------------

/* EXERC�CIO 04.
 O setor de log�stica dever� realizar um transporte de carga dos produtos que est�o no dep�sito de Seattle para o dep�sito de Sunnyside.  

N�o se tem muitas informa��es sobre os produtos que est�o no dep�sito, apenas se sabe que existem 100 exemplares de cada Subcategoria. Ou seja, 100 laptops, 100 c�meras digitais, 100 ventiladores, e assim vai. 

O gerente de log�stica definiu que os produtos ser�o transportados por duas rotas distintas. Al�m disso, a divis�o dos produtos em cada uma das rotas ser� feita de acordo com as subcategorias (ou seja, todos os produtos de uma mesma subcategoria ser�o transportados pela mesma rota): 

Rota 1: As subcategorias que tiverem uma soma total menor que 1000 kg dever�o ser transportados pela Rota 1. 
Rota 2: As subcategorias que tiverem uma soma total maior ou igual a 1000 kg dever�o ser transportados pela Rota 2.

Voc� dever� realizar uma consulta � tabela DimProduct e fazer essa divis�o das subcategorias por cada rota. Algumas dicas:

- Dica 1: A sua consulta dever� ter um total de 3 colunas: Nome da Subcategoria, Peso Total e Rota. 
- Dica 2: Como n�o se sabe quais produtos existem no dep�sito, apenas que existem 100 exemplares de cada subcategoria, voc� dever� descobrir o peso m�dio de cada subcategoria e multiplicar essa m�dia por 100, de forma que voc� descubra aproximadamente qual � o peso total dos produtos por subcategoria. 
- Dica 3: Sua resposta final dever� ter um JOIN e um GROUP BY. */

SELECT * FROM DimProduct
SELECT * FROM DimProductSubcategory

SELECT
	ProductSubcategoryName AS 'Nome da Subcategoria',
	ROUND(AVG(Weight), 2) AS 'Peso M�dio',
	ROUND(AVG(Weight) * 100, 2) AS 'Peso Total',
	CASE
		WHEN ROUND(AVG(Weight) * 100, 2) < 1000 THEN 'Rota 1'
		ELSE 'Rota 2'
	END AS 'Rota'
FROM 
	DimProduct
LEFT JOIN DimProductSubcategory
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
GROUP BY ProductSubcategoryName

---------------------------

/* EXERC�CIO 05.
O setor de marketing est� com algumas ideias de a��es para alavancar as vendas em 2021. Uma delas consiste em realizar sorteios entre os clientes da empresa.  

Este sorteio ser� dividido em categorias: 
�Sorteio M�e do Ano�: Nessa categoria v�o participar todas as mulheres com filhos. 
�Sorteio Pai do Ano�: Nessa categoria v�o participar todos os pais com filhos. 
�Caminh�o de Pr�mios�: Nessa categoria v�o participar todas os demais clientes (homens e mulheres sem filhos).

Seu papel ser� realizar uma consulta � tabela DimCustomer e retornar 3 colunas: 

- FirstName AS �Nome� 
- Gender AS �Sexo� 
- TotalChildren AS �Qtd. Filhos� 
- EmailAdress AS �E-mail� 
- A��o de Marketing: nessa coluna voc� dever� dividir os clientes de acordo com as categorias �Sorteio M�e do Ano�, �Sorteio Pai do Ano� e �Caminh�o de Pr�mios�. */

SELECT * FROM DimCustomer

SELECT
	FirstName AS 'Nome',
	Gender AS 'Sexo',
	TotalChildren AS 'Qtd. Filhos',
	EmailAddress AS 'E-mail',
	CASE
		WHEN Gender = 'F' AND TotalChildren > 0 THEN 'Sorteio M�e do Ano'
		WHEN Gender = 'M' AND TotalChildren > 0 THEN 'Sorteio Pai do Ano'
		ELSE 'Caminh�o de Pr�mios'
	END AS 'A��o de Marketing'
FROM
	DimCustomer

---------------------------

/* EXERC�CIO 06. 
Descubra qual � a loja que possui o maior tempo de atividade (em dias). Voc� dever� fazer essa consulta na tabela DimStore, e considerar a coluna OpenDate como refer�ncia para esse c�lculo. 
Aten��o: lembre-se que existem lojas que foram fechadas. */

SELECT * FROM DimStore

SELECT
	StoreName AS 'Nome da Loja',
	OpenDate AS 'Data de Abertura',
	CloseDate AS 'Data de Fechamento',
	CASE
		WHEN CloseDate IS NULL THEN DATEDIFF(DAY, OpenDate, GETDATE())
		ELSE DATEDIFF(DAY, OpenDate, CloseDate) 
	END AS 'Dias em atividade'
FROM
	DimStore
ORDER BY [Dias em atividade] DESC