-- Módulo 11 - SQL SERVER - FUNÇÕES CONDICIONAIS


/* AULA 01 - Introdução ao Módulo
Nesse módulo vamos aprender a tratar condições no SQL

- CASE WHEN/ELSE
- CASE Aninhado
- CASE/AND
- CASE/OR
- CASE Aditivo
- IIF
- IFNULL
*/

------------------------------

/* AULA 02 - CASE WHEN... ELSE (Explicação)
Assim como qualquer linguagem de programação, no SQL também podemos tratar condições.

A estrutura utilizada para o tratamento de condições no SQL é o CASE. A função CASE nos permite tratar condições e retornar um determinado valor, de acordo com o resultado de um ou mais testes lógicos. Essa função tem exatamente o mesmo objetivo das funções SE e IF que você deve ter visro em algum momento.

Um exemplo simples de utilização da instrução CASE é incluindo em nosso código dentro de um SELECT como se fosse uma nova coluna.

CASE
	WHEN teste_logico THEN 'resultado1'
	ELSE 'resultado2'
END
*/

-- Exemplo 1: Determine a situação do aluno. Se a Média for >= 6, então está aprovado. Caso contrário, reprovado.
DECLARE @varNota FLOAT
SET @varNota = 6

SELECT
	CASE
		WHEN @varNota >= 6 THEN 'Aprovado'
		ELSE 'Reprovado'
	END AS 'Situação'


-- Exemplo 2: A data de vencimento de um produto é no dia 10/03/2022. Faça um teste lógico para verificar se um produto passou da validade ou não.
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
-- Exemplo: Faça um SELECT das colunas CustomerKey, FirstName e Gender na tabela DimCustomer e utilize o CASE para criar uma 4ª coluna com a informação de 'Masculino' ou 'Feminino'.

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

-- No exemplo acima, utilizamos o CASE para verificar se o gênero do cliente é igual a 'M'. Se for, queremos retornar o texto 'Masculino'. Caso contrário, retornamos o resultado 'Feminino'.

------------------------------

-- AULA 04 - CASE WHEN WHEN... ELSE (Explicação)

CASE
	WHEN teste_logico1 THEN 'resultado1'
	WHEN teste_logico2 THEN 'resultado2'
	ELSE 'resultado3'
END

/* Exemplo 1:
Crie um código para verificar a nota do aluno e determinar a situação:
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
Classifique o produto de acordo com o seu preço:
- Preço >= 40000: Luxo
- Preço >= 10000 e Preço < 40000: Econômico
- Preço < 10000: Básico
*/

DECLARE @varPreco FLOAT
SET @varPreco = 30000

SELECT
	CASE
		WHEN @varPreco >= 40000 THEN 'Luxo'
		WHEN @varPreco >= 10000 THEN 'Econômico'
		ELSE 'Básico'
	END

------------------------------

/* AULA 05 - CASE WHEN WHEN... ELSE (Exemplo)
No exemplo anterior, vimos como utilizar o CASE com apenas um teste lógico. Ou seja, verificamos apenas uma vez o dexo do cliente. Caso o gênero não fosse 'M', já assumimos que seria 'F'. Porém, alguns clientes na verdade são empresas, e na coluna de Gender o que temos é o valor NULL.
Neste caso, se utilizarmos o CASE criado no exemplo anterior, todas as empresas ficariam como o sexo 'Feminino'.
O ideal seria fazer um novo para verificar se, caso o sexo não seja nem 'M', e nem 'F', aí sim podemos considerar como 'Empresa'.

Exemplo: Crie uma coluna para substituir o 'M' por 'Masculino' e 'F' por 'Feminino'. Verifique se será necessário fazer alguma correção. */

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

/* AULA 06 - CASE com os operadores lógicos AND e OR
Podemos combinar o CASE com o AND para criar testes lógicos ainda mais avançados.
Observe o exemplo abaixo. Queremos criar uma nova coluna em nossa tabela para registrar o desconto de cada produto. Os produtos que forem da marca Contoso E que também forem da cor Red, receberão um desconto de 10%. Caso contrário, não recebem nenhum desconto. Repare que a única diferença em relação aos exemplos anteriores foi que adicionamos um AND para nos permitir passar mais de um teste lógico.

Como estamos utilizando o operador lógico AND, as duas condições (Marca igual à Contoso) E (Cor igual à Red) precisam ser satisfeitas para que o desconto seja aplicado.	  */

-- Faça uma consulta à tabela DimProduct e retorne as colunas ProductName, BrandName, ColorName, UnitPrice e uma coluna de preço com desconto.

-- a) Caso o produto seja da marca Contoso E da cor Red, o desconto do produto será de 10%. Caso contrário, não terá nenhum desconto.
SELECT
	ProductName AS 'Produto',
	BrandName AS 'Marca',
	ColorName AS 'Cor',
	UnitPrice AS 'Preço Unitário',
	CASE
		WHEN BrandName = 'Contoso' AND ColorName = 'Red' THEN 0.1
		ELSE 0
	END AS '% de Desconto'
FROM
	DimProduct


/* Podemos também combinar o CASE com o operador lógico OR. No exemplo abaixo, os produtos que forem da marca Contoso OU da marca Fabrikam, receberão um desconto de 10%. Caso contrário, não recebem nenhum desconto.

Como estamos utilizando o operador lógico OR, qualquer uma das duas condições poderão ser satisfeitas (Marca igual à Contoso) OU (Marca igual à Fabrikam) para que o desconto seja aplicado.	   */

-- b) Caso o produto seja da marca Litware OU Fabrikam, ele receberá um desconto de 5%. Caso contrário, não terá nenhum desconto.
SELECT
	ProductName AS 'Produto',
	BrandName AS 'Marca',
	UnitPrice AS 'Preço Unitário',
	CASE
		WHEN BrandName = 'Litware' OR BrandName = 'Fabrikam' THEN 0.05
		ELSE 0
	END AS '% de Desconto'
FROM
	DimProduct

------------------------------

/* AULA 07 - CASE Aninhado
O CASE Aninhado nada mais é do que um CASE dentreo de outro CASE. Em algumas situações ele pode ser muito útil.

No exemplo 1 abaixo, criamos uma lógica onde, de acordo com a quantidade de funcionários da loja (EmployeeCount) estabelecemos um status para aquela loja.

- Acima de 40 funcionários
- Entre 30 e 39 funcionários
- Entre 20 e 29 funcionários
- Abaixo de 19 funcionários

Porém, especificamente para as lojas que têm mais de 40 funcionários, queremos fazer um novo teste e dividir em 'LOJA ABERTA' ou 'LOJA FECHADA'. */

SELECT
	StoreKey,
	StoreName,
	StoreType,
	Status,
	EmployeeCount,
	CASE
		WHEN EmployeeCount >= 40 THEN
			CASE
				WHEN Status = 'Off' THEN 'LOJA FECHADA: Acima de 40 funcionários'
				WHEN Status = 'On' THEN 'LOJA ABERTA: Acima de 40 funcionário'
				END
		WHEN EmployeeCount >= 30 THEN 'Entre 30 e 39 funcionários'
		WHEN EmployeeCount >= 20 THEN 'Entre 20 e 29 funcionários'
		ELSE 'Abaixo de 19 funcionários'
	END AS 'Categoria'
FROM
	DimStore

-- No exemplo 2 abaixo, criamos uma lógica onde, de acordo com o cargo (Title) iremos distribuir uma porcentagem de bonus. Porém

-- 4 Cargos (Title):
-- Sales Group Manager
-- Sales Region Manager
-- Sales State Manager
-- Sales Store Manager

-- Assalariado (SalariedFlag)?
-- SalariedFlag = 0: não é assalariado
-- SalariedFlag = 1: é assalariado

-- Situação: Cálculo do bônus
-- Sales Group Manager: Se for assalariado, 20%; Se não, 15%.
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
	END AS 'Bônus'
FROM
	DimEmployee

------------------------------

/* AULA 08 - CASE Aditivo
Uma outra aplicação do CASE é em uma situãção especial, mostrada abaixo. Nessa aplicação, conseguimos adicionar uma condição a uma condição anterior.

Por exemplo, no exercício abaixo, queremos aplicar um desconto de 10% aos produtos da categoria 'TV and Video'. E além disso, caso também seja da subcategoria 'Televisão', queremos aplicar mais 5%, fechando em 15% de desconto.

Criamos um primeiro CASE para verificar a categoria. Logo em seguida, seomamos ao CASE que verifica se a subcategoria é televisão. */

-- Os produtos da categoria 'TV and Video' terão um desconto de 10%
-- Se além de ser da categoria 'TV and Video', o produto for da subcategoria 'Televisions', receberá mais 5%. Total, 15%

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
Uma alternatica ao CASE seria a função IIF. Ela é muito semelhante com a fórmula SE do Excel, pois pede 3 argumentos.
1. Teste lógico
2. Valor se verdadeiro
3. Valor se falso

No exercício abaixo, queremos classificar um projeto de acordo com o seu nível de risco. Utilizamos para isso uma variável. */

-- Exemplo 1: Qual é a categoria de risco do projeto abaixo, de acordo com a sua nota:
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

-- Exemplo 2: Crie uma coluna única de 'Cliente', contendo o nome do cliente, seja ele uma pessoa ou uma empresa. Traga também a coluna de CustomerKey e CustomerType.
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
É possível utilizar um IIF dentro de outro IFF, criando o que chamamos de IFF composto. Com essa aplicação, tratamos vários resultados possíveis, de acordo com mais de um teste lógico.

No exemplo abaixo, queremos fazer uma consulta à tabela DimProduct e retornar o responsável pelos estoques dos produtos, de acordo com o StockTypeName. Como temos 3 tipos de estoque e consequentemente 3 responsáveis diferentes, teremos que utilizar mais de 1 IFF para conseguir cobrir todas as situações possíveis. */

-- Exemplo: Existem 3 tipos de estoque: High, Mid e Low. Faça um SELECT contendo as colunas de ProductKey, ProductName, StockTypeName e Nome do responsável pelo produto, de acordo com o tipo de estoque. A regra deverá ser a seguinte:
-- João é responsável pelos produtos High
-- Maria é responsável pelos produtos Mid
-- Luis é responsável pelos produtos Low

SELECT
	ProductKey AS 'ID Produto',
	ProductName AS 'Nome Produto',
	iif(
		StockTypeName = 'High',
		'João',
		IIF(
			StockTypeName = 'Mid',
			'Maria',
			'Luis')
			) AS 'Responsável'

FROM
	DimProduct

------------------------------

/*AULA 11 - ISNULL - Tratando valores nulos
A função ISNULL nos permite retornar um resultado alternativo para o caso de um valor ser nulo (NULL). Na consulta abaixo, diversas cidades na coluna CityName estão com o valor NULL. Podemos utilizar a função ISNULL para verificar essa coluna (no 1º argumento) e caso o valor seja nulo, ele retornará um resultado alternativo. Neste caso, o resultado alternativo que queremos para as cidades com o nome NULL será o texto 'Local desconhecido'. */

-- Exemplo: Faça uma consulta que substitua todos os valores nulos de CityName da tabela DimGeography pelo texto 'Local desconhecido'.
SELECT * FROM DimGeography

SELECT
	GeographyKey AS 'ID Geográfico',
	ContinentName AS 'Continente',
	CityName AS 'Cidade',
	ISNULL(CityName, 'Local desconhecido')
FROM
	DimGeography

------------------------------

-- AULA 12 - Explicação Exercícios
-- AULA 13 - Resolução Exercício 01
-- AULA 14 - Resolução Exercício 02
-- AULA 15 - Resolução Exercício 03
-- AULA 16 - Resolução Exercício 04
-- AULA 17 - Resolução Exercício 05
-- AULA 18 - Resolução Exercício 06