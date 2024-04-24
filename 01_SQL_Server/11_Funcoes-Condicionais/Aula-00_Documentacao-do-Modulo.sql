-- M�dulo 11 - SQL SERVER - FUN��ES CONDICIONAIS


/* AULA 01 - Introdu��o ao M�dulo
Nesse m�dulo vamos aprender a tratar condi��es no SQL

- CASE WHEN/ELSE
- CASE Aninhado
- CASE/AND
- CASE/OR
- CASE Aditivo
- IIF
- IFNULL
*/

------------------------------

/* AULA 02 - CASE WHEN... ELSE (Explica��o)
Assim como qualquer linguagem de programa��o, no SQL tamb�m podemos tratar condi��es.

A estrutura utilizada para o tratamento de condi��es no SQL � o CASE. A fun��o CASE nos permite tratar condi��es e retornar um determinado valor, de acordo com o resultado de um ou mais testes l�gicos. Essa fun��o tem exatamente o mesmo objetivo das fun��es SE e IF que voc� deve ter visro em algum momento.

Um exemplo simples de utiliza��o da instru��o CASE � incluindo em nosso c�digo dentro de um SELECT como se fosse uma nova coluna.

CASE
	WHEN teste_logico THEN 'resultado1'
	ELSE 'resultado2'
END
*/

-- Exemplo 1: Determine a situa��o do aluno. Se a M�dia for >= 6, ent�o est� aprovado. Caso contr�rio, reprovado.
DECLARE @varNota FLOAT
SET @varNota = 6

SELECT
	CASE
		WHEN @varNota >= 6 THEN 'Aprovado'
		ELSE 'Reprovado'
	END AS 'Situa��o'


-- Exemplo 2: A data de vencimento de um produto � no dia 10/03/2022. Fa�a um teste l�gico para verificar se um produto passou da validade ou n�o.
DECLARE @varDataVencimento DATETIME, @varDataAtual DATETIME
SET @varDataVencimento = '10/03/2025'
SET @varDataAtual = '30/04/2022'

SELECT
	CASE
		WHEN @varDataAtual > @varDataVencimento THEN 'Produto Vencido'
		ELSE 'Na validade'
	END

------------------------------

-- AULA 03 - CASE WHEN... ELSE (Exemplo)
-- Exemplo: Fa�a um SELECT das colunas CustomerKey, FirstName e Gender na tabela DimCustomer e utilize o CASE para criar uma 4� coluna com a informa��o de 'Masculino' ou 'Feminino'.

SELECT * FROM DimCustomer

SELECT
	CustomerKey AS 'ID Cliente',
	FirstName AS 'Nome',
	Gender AS 'Sexo',
	CASE
		WHEN Gender = 'M' THEN 'Masculino'
		ELSE 'Feminino'
	END AS 'Sexo (CASE)'
FROM
	DimCustomer

-- No exemplo acima, utilizamos o CASE para verificar se o g�nero do cliente � igual a 'M'. Se for, queremos retornar o texto 'Masculino'. Caso contr�rio, retornamos o resultado 'Feminino'.

------------------------------

-- AULA 04 - CASE WHEN WHEN... ELSE (Explica��o)

CASE
	WHEN teste_logico1 THEN 'resultado1'
	WHEN teste_logico2 THEN 'resultado2'
	ELSE 'resultado3'
END

/* Exemplo 1:
Crie um c�digo para verificar a nota do aluno e determinar a situa��o:
- Aprovado: nota maior ou igual a 6
- Prova final: noa entre 4 e 6
- Reprovado: nota abaixo de 4
*/

DECLARE @varNota FLOAT
SET @varNota = 8.5

SELECT
CASE
	WHEN @varNota >= 6 THEN 'Aprovado'
	WHEN @varNota >= 4 THEN 'Prova final'
	ELSE 'Reprovado'
END


/* Exemplo 2: 
Classifique o produto de acordo com o seu pre�o:
- Pre�o >= 40000: Luxo
- Pre�o >= 10000 e Pre�o < 40000: Econ�mico
- Pre�o < 10000: B�sico
*/

DECLARE @varPreco FLOAT
SET @varPreco = 30000

SELECT
	CASE
		WHEN @varPreco >= 40000 THEN 'Luxo'
		WHEN @varPreco >= 10000 THEN 'Econ�mico'
		ELSE 'B�sico'
	END

------------------------------

/* AULA 05 - CASE WHEN WHEN... ELSE (Exemplo)
No exemplo anterior, vimos como utilizar o CASE com apenas um teste l�gico. Ou seja, verificamos apenas uma vez o dexo do cliente. Caso o g�nero n�o fosse 'M', j� assumimos que seria 'F'. Por�m, alguns clientes na verdade s�o empresas, e na coluna de Gender o que temos � o valor NULL.
Neste caso, se utilizarmos o CASE criado no exemplo anterior, todas as empresas ficariam como o sexo 'Feminino'.
O ideal seria fazer um novo para verificar se, caso o sexo n�o seja nem 'M', e nem 'F', a� sim podemos considerar como 'Empresa'.

Exemplo: Crie uma coluna para substituir o 'M' por 'Masculino' e 'F' por 'Feminino'. Verifique se ser� necess�rio fazer alguma corre��o. */

SELECT * FROM DimCustomer

SELECT
	CustomerKey AS 'ID do Cliente',
	FirstName AS 'Nome',
	Gender AS 'Sexo',
	CASE
		WHEN Gender = 'M' THEN 'Masculino'
		WHEN Gender = 'F' THEN 'Feminino'
		ELSE 'Empresa'
	END AS 'Sexo CASE'
FROM
	DimCustomer

------------------------------

/* AULA 06 - CASE com os operadores l�gicos AND e OR
Podemos combinar o CASE com o AND para criar testes l�gicos ainda mais avan�ados.
Observe o exemplo abaixo. Queremos criar uma nova coluna em nossa tabela para registrar o desconto de cada produto. Os produtos que forem da marca Contoso E que tamb�m forem da cor Red, receber�o um desconto de 10%. Caso contr�rio, n�o recebem nenhum desconto. Repare que a �nica diferen�a em rela��o aos exemplos anteriores foi que adicionamos um AND para nos permitir passar mais de um teste l�gico.

Como estamos utilizando o operador l�gico AND, as duas condi��es (Marca igual � Contoso) E (Cor igual � Red) precisam ser satisfeitas para que o desconto seja aplicado.	  */

-- Fa�a uma consulta � tabela DimProduct e retorne as colunas ProductName, BrandName, ColorName, UnitPrice e uma coluna de pre�o com desconto.

-- a) Caso o produto seja da marca Contoso E da cor Red, o desconto do produto ser� de 10%. Caso contr�rio, n�o ter� nenhum desconto.
SELECT
	ProductName AS 'Produto',
	BrandName AS 'Marca',
	ColorName AS 'Cor',
	UnitPrice AS 'Pre�o Unit�rio',
	CASE
		WHEN BrandName = 'Contoso' AND ColorName = 'Red' THEN 0.1
		ELSE 0
	END AS '% de Desconto'
FROM
	DimProduct


/* Podemos tamb�m combinar o CASE com o operador l�gico OR. No exemplo abaixo, os produtos que forem da marca Contoso OU da marca Fabrikam, receber�o um desconto de 10%. Caso contr�rio, n�o recebem nenhum desconto.

Como estamos utilizando o operador l�gico OR, qualquer uma das duas condi��es poder�o ser satisfeitas (Marca igual � Contoso) OU (Marca igual � Fabrikam) para que o desconto seja aplicado.	   */

-- b) Caso o produto seja da marca Litware OU Fabrikam, ele receber� um desconto de 5%. Caso contr�rio, n�o ter� nenhum desconto.
SELECT
	ProductName AS 'Produto',
	BrandName AS 'Marca',
	UnitPrice AS 'Pre�o Unit�rio',
	CASE
		WHEN BrandName = 'Litware' OR BrandName = 'Fabrikam' THEN 0.05
		ELSE 0
	END AS '% de Desconto'
FROM
	DimProduct

------------------------------

/* AULA 07 - CASE Aninhado
O CASE Aninhado nada mais � do que um CASE dentreo de outro CASE. Em algumas situa��es ele pode ser muito �til.

No exemplo 1 abaixo, criamos uma l�gica onde, de acordo com a quantidade de funcion�rios da loja (EmployeeCount) estabelecemos um status para aquela loja.

- Acima de 40 funcion�rios
- Entre 30 e 39 funcion�rios
- Entre 20 e 29 funcion�rios
- Abaixo de 19 funcion�rios

Por�m, especificamente para as lojas que t�m mais de 40 funcion�rios, queremos fazer um novo teste e dividir em 'LOJA ABERTA' ou 'LOJA FECHADA'. */

SELECT
	StoreKey,
	StoreName,
	StoreType,
	Status,
	EmployeeCount,
	CASE
		WHEN EmployeeCount >= 40 THEN
			CASE
				WHEN Status = 'Off' THEN 'LOJA FECHADA: Acima de 40 funcion�rios'
				WHEN Status = 'On' THEN 'LOJA ABERTA: Acima de 40 funcion�rio'
				END
		WHEN EmployeeCount >= 30 THEN 'Entre 30 e 39 funcion�rios'
		WHEN EmployeeCount >= 20 THEN 'Entre 20 e 29 funcion�rios'
		ELSE 'Abaixo de 19 funcion�rios'
	END AS 'Categoria'
FROM
	DimStore

-- No exemplo 2 abaixo, criamos uma l�gica onde, de acordo com o cargo (Title) iremos distribuir uma porcentagem de bonus. Por�m

-- 4 Cargos (Title):
-- Sales Group Manager
-- Sales Region Manager
-- Sales State Manager
-- Sales Store Manager

-- Assalariado (SalariedFlag)?
-- SalariedFlag = 0: n�o � assalariado
-- SalariedFlag = 1: � assalariado

-- Situa��o: C�lculo do b�nus
-- Sales Group Manager: Se for assalariado, 20%; Se n�o, 15%.
-- Sales Region Manager: 15%
-- Sales State Manager: 7%
-- Sales Store Manager: 2%

SELECT
	FirstName,
	Title,
	SalariedFlag,
	CASE
		WHEN Title = 'Sales Group Manager' THEN
		CASE	
			WHEN SalariedFlag = 1 THEN 0.3
			ELSE 0.2
		END 
		WHEN Title = 'Sales Region Manager' THEN 0.15
		WHEN Title = 'Sales State Manager' THEN 0.07
		ELSE 0.02
	END AS 'B�nus'
FROM
	DimEmployee

------------------------------

/* AULA 08 - CASE Aditivo
Uma outra aplica��o do CASE � em uma situ���o especial, mostrada abaixo. Nessa aplica��o, conseguimos adicionar uma condi��o a uma condi��o anterior.

Por exemplo, no exerc�cio abaixo, queremos aplicar um desconto de 10% aos produtos da categoria 'TV and Video'. E al�m disso, caso tamb�m seja da subcategoria 'Televis�o', queremos aplicar mais 5%, fechando em 15% de desconto.

Criamos um primeiro CASE para verificar a categoria. Logo em seguida, seomamos ao CASE que verifica se a subcategoria � televis�o. */

-- Os produtos da categoria 'TV and Video' ter�o um desconto de 10%
-- Se al�m de ser da categoria 'TV and Video', o produto for da subcategoria 'Televisions', receber� mais 5%. Total, 15%

SELECT
	ProductKey,
	ProductName,
	ProductCategoryName,
	ProductSubcategoryName,	
	UnitPrice,
	CASE WHEN ProductCategoryName = 'TV and Video' 
		THEN 0.10 ELSE 0.00 END
	+ CASE WHEN ProductSubCategoryName = 'Televisions' 
		THEN 0.05 ELSE 0.00 END
FROM DimProduct
INNER JOIN DimProductSubcategory
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
		INNER JOIN DimProductCategory
			ON DimProductSubcategory.ProductCategoryKey = DimProductCategory.ProductCategoryKey

------------------------------

/* AULA 09 - IIF (Alternativa ao CASE)
Uma alternatica ao CASE seria a fun��o IIF. Ela � muito semelhante com a f�rmula SE do Excel, pois pede 3 argumentos.
1. Teste l�gico
2. Valor se verdadeiro
3. Valor se falso

No exerc�cio abaixo, queremos classificar um projeto de acordo com o seu n�vel de risco. Utilizamos para isso uma vari�vel. */

-- Exemplo 1: Qual � a categoria de risco do projeto abaixo, de acordo com a sua nota:
-- Risco Alto: Classicacao >= 5
-- Risco Baixo: Classificacao < 5

DECLARE @varClassificacao INT
SET @varClassificacao = 9
SELECT
	IIF(
		@varClassificacao >= 5,
		'Risco Alto',
		'Risco Baixo'
		) AS 'Status'

-- Exemplo 2: Crie uma coluna �nica de 'Cliente', contendo o nome do cliente, seja ele uma pessoa ou uma empresa. Traga tamb�m a coluna de CustomerKey e CustomerType.
SELECT * FROM DimCustomer
SELECT
	CustomerKey AS 'ID Cliente',
	CustomerType AS 'Tipo Cliente',
	IIF(
		CustomerType = 'Person',
		FirstName,
		CompanyName) AS 'Cliente'
FROM
	DimCustomer

------------------------------

/* AULA 10 - IIF Composto
� poss�vel utilizar um IIF dentro de outro IFF, criando o que chamamos de IFF composto. Com essa aplica��o, tratamos v�rios resultados poss�veis, de acordo com mais de um teste l�gico.

No exemplo abaixo, queremos fazer uma consulta � tabela DimProduct e retornar o respons�vel pelos estoques dos produtos, de acordo com o StockTypeName. Como temos 3 tipos de estoque e consequentemente 3 respons�veis diferentes, teremos que utilizar mais de 1 IFF para conseguir cobrir todas as situa��es poss�veis. */

-- Exemplo: Existem 3 tipos de estoque: High, Mid e Low. Fa�a um SELECT contendo as colunas de ProductKey, ProductName, StockTypeName e Nome do respons�vel pelo produto, de acordo com o tipo de estoque. A regra dever� ser a seguinte:
-- Jo�o � respons�vel pelos produtos High
-- Maria � respons�vel pelos produtos Mid
-- Luis � respons�vel pelos produtos Low

SELECT
	ProductKey AS 'ID Produto',
	ProductName AS 'Nome Produto',
	iif(
		StockTypeName = 'High',
		'Jo�o',
		IIF(
			StockTypeName = 'Mid',
			'Maria',
			'Luis')
			) AS 'Respons�vel'

FROM
	DimProduct

------------------------------

/*AULA 11 - ISNULL - Tratando valores nulos
A fun��o ISNULL nos permite retornar um resultado alternativo para o caso de um valor ser nulo (NULL). Na consulta abaixo, diversas cidades na coluna CityName est�o com o valor NULL. Podemos utilizar a fun��o ISNULL para verificar essa coluna (no 1� argumento) e caso o valor seja nulo, ele retornar� um resultado alternativo. Neste caso, o resultado alternativo que queremos para as cidades com o nome NULL ser� o texto 'Local desconhecido'. */

-- Exemplo: Fa�a uma consulta que substitua todos os valores nulos de CityName da tabela DimGeography pelo texto 'Local desconhecido'.
SELECT * FROM DimGeography

SELECT
	GeographyKey AS 'ID Geogr�fico',
	ContinentName AS 'Continente',
	CityName AS 'Cidade',
	ISNULL(CityName, 'Local desconhecido')
FROM
	DimGeography

------------------------------

-- AULA 12 - Explica��o Exerc�cios
-- AULA 13 - Resolu��o Exerc�cio 01
-- AULA 14 - Resolu��o Exerc�cio 02
-- AULA 15 - Resolu��o Exerc�cio 03
-- AULA 16 - Resolu��o Exerc�cio 04
-- AULA 17 - Resolu��o Exerc�cio 05
-- AULA 18 - Resolu��o Exerc�cio 06