-- MÓDULO 09 - SQL SERVER - VARIÁVEIS


/* EXERCÍCIO 1. 
Declare 4 variáveis inteiras. Atribua os seguintes valores a elas: 
valor1 = 10 
valor2 = 5 
valor3 = 34 
valor4 = 7 
a) Crie uma nova variável para armazenar o resultado da soma entre valor1 e valor2. Chame essa variável de soma. 
b) Crie uma nova variável para armazenar o resultado da subtração entre valor3 e valor 4. Chame essa variável de subtracao.  
c) Crie uma nova variável para armazenar o resultado da multiplicação entre o valor 1 e o valor4. Chame essa variável de multiplicacao. 
d) Crie uma nova variável para armazenar o resultado da divisão do valor3 pelo valor4. Chame essa variável de divisao. Obs: O resultado deverá estar em decimal, e não em inteiro. 
e) Arredonde o resultado da letra d) para 2 casas decimais. */

DECLARE @valor1 FLOAT 
DECLARE @valor2 FLOAT
DECLARE @valor3 FLOAT
DECLARE @valor4 FLOAT

SET @valor1 = 10
SET @valor2 = 5 
SET @valor3 = 34
SET @valor4 = 7

DECLARE @soma FLOAT 
SET @soma = @valor1 + @valor2
SELECT @soma

DECLARE @subtracao FLOAT 
SET @subtracao = @valor3 - @valor4
SELECT @subtracao

DECLARE @multiplicacao FLOAT
SET @multiplicacao = @valor1 * @valor4
SELECT @multiplicacao

DECLARE @divisao FLOAT 
SET @divisao = @valor3 / @valor4
SELECT @divisao


SELECT 
	@soma AS 'Soma', 
	@subtracao AS 'Subtracao', 
	@multiplicacao AS 'Multiplicacao', 
	ROUND(@divisao, 2) AS 'Divisao'

------------------------------

/* EXERCÍCIO 2.
Para cada declaração das variáveis abaixo, atenção em relação ao tipo de dado que deverá ser especificado. 
a) Declare uma variável chamada ‘produto’ e atribua o valor de ‘Celular’. 
b) Declare uma variável chamada ‘quantidade’ e atribua o valor de 12.  
c) Declare uma variável chamada ‘preco’ e atribua o valor 9.99. 
d) Declare uma variável chamada ‘faturamento’ e atribua o resultado da multiplicação entre ‘quantidade’ e ‘preco’.  
e) Visualize o resultado dessas 4 variáveis em uma única consulta, por meio do SELECT. */

DECLARE @produto VARCHAR(50)
DECLARE @quantidade INT
DECLARE @preco FLOAT
DECLARE @faturamento FLOAT

SET @produto = 'Celular'
SET @quantidade = 12
SET @preco = 799.99
SET @faturamento = @quantidade * @preco

SELECT 
	@produto AS 'Produto', 
	@quantidade AS 'Quantidade', 
	@preco AS 'Preco Unitário', 
	@faturamento AS 'Faturamento'

------------------------------

/* EXERCÍCIO 3. 
Você é responsável por gerenciar um banco de dados onde são recebidos dados externos de usuários. Em resumo, esses dados são: 
- Nome do usuário 
- Data de nascimento 
- Quantidade de pets que aquele usuário possui 
Você precisará criar um código em SQL capaz de juntar as informações fornecidas por este usuário. Para simular estes dados, crie 3 variáveis, chamadas: nome, data_nascimento e num_pets. Você deverá armazenar os valores ‘André’, ‘10/02/1998’ e 2, respectivamente. 
O resultado final a ser alcançado é mostrado no print abaixo: 
Dica: você precisará utilizar as funções CAST e FORMAT para chegar no resultado. */

DECLARE @nome VARCHAR(MAX)
DECLARE @data_nascimento DATETIME
DECLARE @num_pets INT

SET @nome = 'André'
SET @data_nascimento = '10/02/1998'
SET @num_pets = 2

SELECT 'Meu nome é ' + CAST(@nome AS VARCHAR(MAX)) + ', nasci em' + FORMAT(@data_nascimento, 'dd/MM/yyyy') + ' e tenho ' + CAST(@num_pets AS VARCHAR(MAX)) + ' pets.'

------------------------------

/* EXERCÍCIO 4. 
Você acabou de ser promovido e o seu papel será realizar um controle de qualidade sobre as lojas da empresa.  
A primeira informação que é passada a você é que o ano de 2008 foi bem complicado para a empresa, pois foi quando duas das principais lojas fecharam. O seu primeiro desafio é descobrir o nome dessas lojas que fecharam no ano de 2008, para que você possa entender o motivo e mapear planos de ação para evitar que outras lojas importantes tomem o mesmo caminho. 
O seu resultado deverá estar estruturado em uma frase, com a seguinte estrutura: 
‘As lojas fechadas no ano de 2008 foram:  ’ + nome_das_lojas  
Obs: utilize o comando PRINT (e não o SELECT!) para mostrar o resultado. */

SELECT * FROM DimStore WHERE CloseDate BETWEEN '20080101' AND '20081231'

DECLARE @nomeLoja1 VARCHAR(MAX)
DECLARE @nomeLoja2 VARCHAR(MAX)

SET @nomeLoja1 = 'Contoso Buffalo Store'
SET @nomeLoja2 = 'Contoso Trenton No. 2 Store'

PRINT 'As lojas fechadas no ano de 2008 foram: ' + @nomeLoja1 + ' e ' + @nomeLoja2

-- OU

SELECT StoreName,CloseDate FROM DimStore WHERE Status = 'Off'
SELECT StoreName,CloseDate FROM DimStore WHERE FORMAT(CloseDate, 'yyyy') = 2008

DECLARE @VarListasLojas VARCHAR(MAX)
SET @VarListasLojas = ''
SELECT
	@VarListasLojas = @VarListasLojas + StoreName + ', '
FROM
	DimStore
WHERE FORMAT(CloseDate, 'yyyy') = 2008

PRINT 'As lojas fechadas no ano de 2008 foram: ' + @VarListasLojas

------------------------------

/* EXERCÍCIO 5. 
Você precisa criar uma consulta para mostrar a lista de produtos da tabela DimProduct para uma subcategoria específica: ‘Lamps’.  
Utilize o conceito de variáveis para chegar neste resultado. */

SELECT * FROM DimProduct
SELECT * FROM DimProductSubcategory

DECLARE @varIDSubcategoria INT
DECLARE @varNomeSubcategoria VARCHAR(MAX)

SET @varNomeSubcategoria = 'Lamps'
SET @varIdSubcategoria = (SELECT ProductSubcategoryKey FROM DimProductSubcategory WHERE ProductSubcategoryName = @varNomeSubcategoria)

SELECT * FROM DimProduct WHERE ProductSubcategoryKey = @varIdSubcategoria
