-- MÓDULO 10 - SQL SERVER - Manipulando Strings e Datas


/* AULA 01 - Introdução ao Módulo
Nesse módulo vamos aprender a manipular textos (strings) e datas nas nossas tabelas.

- LEN e DATALENGTH
- CONCAT
- LEFT e RIGHT
- REPLACE, TRANSLATE e STUFF
- UPPER E LOWER
- FORMAT
- CHARINDEX e SUBSTRING
- TRIM, LTRIM e RTRIM
- YEAR, MONTH e DAY
- DATEFROMPARTS
- GETDATE e SYSDATETIME
- DATENAME e DATEPART
- DATEADD e DATEDIFF
*/

------------------------------

/* AULA 02 - LEN e DATALENGTH
As funções LEN e DATALENGTH possuem resultados semelhantes: ambos retornam a quantidade de caracteres de um determinado texto.

A grande diferença entre os dois é sutil: O LEN retorna a quantidade de caracteres de um texto porém, ignora quando aparecem espaços a mais.

Já o DATALENGTH retorna a quantidade de caracteres, incluindo espaços a mais dentro do texto. */

-- Exemplo: Descubra a quantidade de caracteres da palavra 'SQL Hashtag'

SELECT
	LEN('SQL Hashtag') AS 'Len',
	DATALENGTH('SQL Hashtag') AS 'Datalength'

-- OBS 1: Só iremos visualizar uma diferença entre LEN e DATALENGTH se houver espaços em branco adicionais no final de uma palavra, pois o DATALENGTH também contará esses espaços em branco, enquanto o LEN não. Exemplo:

SELECT
	LEN('SQL Hashtag    ') AS 'Len', -- 4 caracteres vazios
	DATALENGTH('SQL Hashtag    ') AS 'Datalength' -- 4 caracteres vazios

-- OBS 2: A escolha da utilização de LEN e DATALENGTH vai depender se você precisará contar espaços vazios ou não. 

------------------------------

/* AULA 03 - CONCAT
A função CONCAT permite juntar dois ou mais textos em um só. 

Exemplo: Faça uma consulta à tabela DimCustomer onde seja possível visualizar o nome completo de cada cliente. */
SELECT * FROM DimCustomer -- Não temos uma coluna com o nome completo dos clientes.

SELECT
	FirstName AS 'Nome',
	LastName AS 'Sobrenome',
	CONCAT(FirstName, ' ', LastName) AS 'Nome Completo',
	EmailAddress AS 'E-mail'
FROM
	DimCustomer

-- OBS: Para separar os textos é obrigatório acrescentar um espaço entre aspas simples;

------------------------------

/* AULA 04 - LEFT e RIGHT
As funções LEFT e RIGHT permitem extrair uma parte de um texto, sempre começando da esqueda para a direita, ou da direita para a esquerda, respectivamente.

LEFT extrai uma determinada quantidade de caracteres de um texto, da esquerda para a direita
RIGHT extrai uma determinada quantidade de caracteres de um texto, da direita para a esquerda */

SELECT * FROM DimProduct
SELECT LEFT('Product0101001', 7)
SELECT RIGHT('Product0101001', 7)
-- As funções irão solicitar 2 argumentos, sendo o primeiro o 'valor' e o segundo a quantidade de caracteres que deseja extrair)

-- Exemplo: Faça uma consulta à tabela DimProduct e divida a coluna de StyleName em 2 partes
SELECT
	ProductName AS 'Produto',
	UnitPrice AS 'Preço',
	LEFT(StyleName, 7) AS 'Cod 1', 
	RIGHT(StyleName, 7) AS 'Cod 2'
FROM
	DimProduct
-- Sempre que quiser extrair informações da esquerda para direitra ou vice-versa, poderá usar a função LEFT e RIGHT

------------------------------

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

------------------------------

/* AULA 07 - TRANSLATE e STUFF
Existem outras duas funções usadas para substituir textos: TRANSLATE e STUFF.

A função TRANSLATE permite que a gente informe uma sequência de caractereres antigos que desejamos substituir, além da sequência de caracteres novos que serão usados para substituir os caracteres antigos, seguindo exatamente a mesma sequência.

A função TRANSLATE pede 3 argumentos:
1. Texto
2. Sequência antiga de caracteres
3. Sequência nova de caracteres
*/

-- TRANSLATE substitui cada caractere na ordem encontrada no texto.
SELECT TRANSLATE('10.241/444.124k23/1', './k', '---')
-- Nessa aplicação de TRANSLATE, todos os caracteres (ponto, barra e a letra k) são substituidos por um (traço -).

SELECT TRANSLATE('10.241/444.124k23/1', './k', 'abc')
-- Nessa aplicação de TRANSLATE, todos os caracteres (ponto, barra e a letra k) são substituidos por (abc), sendo que, a substituição ocorre 1 por 1, ou seja, todos os (.) são substituidos por (a), todas as (/) são substituidas por (b) etc.

SELECT TRANSLATE('3*[2+1]/{8-4}', '[]{}', '()()')
-- Nessa aplicação de TRANSLATE, todos os colchetes e chaves são substitudos por parenteses.

SELECT TRANSLATE('ABCD-490123', 'ABCD', 'WXYZ')
-- Nessa aplicação de TRANSLATE, os 4 primeiros caracteres são substituidos de 'ABCD' para WXYZ'.


/* A função STUFF permite que a gente substitua uma sequência de caracteres com um tamanho específico, por um outro texto.
Essa função pede 4 argumentos.
1. Texto
2. Posição inicial onde começa o texto antigo
3. Quantidade de caracteres do texto antigo
4. Novo texto.

Nos exemplos abaixo, temos duas situações: VBA Impressionador e SQL Impressionador. Ambos possuem 3 caracteres iniciais (referete ao nome do curso) e podemos utilizar esse padrão, junto com a função STUFF, para substituir sempre os 3 primeiros caracteres (independente do que esteja escrito nesses 3 primeiros caracteres) pelo texto 'Excel'.
*/

SELECT STUFF('VBA Impressionador', 1, 3, 'Excel')
SELECT STUFF('SQL Impressionador', 1, 3, 'Excel')

SELECT
	STUFF('MT98-Moto G', 1, 2, 'CEL'),
	STUFF('AP01-IPhone', 1, 2, 'CEL'),
	STUFF('SS61-Samsung Galaxy', 1, 2, 'CEL')

------------------------------

/* AULA 08 - UPPER e LOWER
As funções UPPER e LOWER são bastante intuitivas e nos permitem ajustar as palavras para que fiquem em letras maiúsculas e minúsculas.

UPPER transforma um texto em maiúscula
LOWER transforma um texto em minúscula */

-- Exemplo: Faça uma consulta à tabela DimCustomer e utilize as funções UPPER e LOWER na coluna de FirstName para observar o resultado
SELECT 
	FirstName AS 'Nome',
	UPPER(FirstName) AS 'NOME',
	LOWER(FirstName) AS 'nome',
	EmailAddress AS 'E-mail'
FROM
		DimCustomer

------------------------------

/* AULA 09 - FORMAT
A função FORMAT é uma função muito útil para realizar formatações personalizadas em nossas consultas.

Essa função nos pede 2 argumentos:
1. Valor a ser formatado
2. Código de formatação
*/

-- 1. Formatação de Número
-- 5123
SELECT FORMAT(5123, 'G') AS 'Geral' -- Formatação Geral
SELECT FORMAT(5123, 'N') AS 'Número' -- Formatação Número
SELECT FORMAT(5123, 'C') AS 'Moeda' -- Formatação Moeda

-- 2. Formatação de Data
-- 01/04/2024
SELECT FORMAT(CAST('01/04/2024' AS DATETIME), 'dd/MM/yyyy') -- Formatação completa
SELECT FORMAT(CAST('01/04/2024' AS DATETIME), 'dd/MMM/yyyy', 'en-US') -- De acordo com o idioma
SELECT FORMAT(CAST('01/04/2024' AS DATETIME), 'dd') -- dia
SELECT FORMAT(CAST('01/04/2024' AS DATETIME), 'MM') -- mês
SELECT FORMAT(CAST('01/04/2024' AS DATETIME), 'yy') -- ano

-- 3. Formatação Personalizada
-- 1234567 --> 12-34-567
SELECT FORMAT(1234567, '##-##-###')

-- Formatar as colunas de Data de Nascimento e Renda Anual da tabela DimCustomer, de acordo com as formatações aprendidas.
SELECT
	FirstName AS 'Nome',
	BirthDate AS 'Data de Nascimento',
	FORMAT(BirthDate, 'dd/MMMM/yyyy') AS 'Data Formatada',
	YearlyIncome AS 'Renda Anual',
	FORMAT(YearlyIncome, 'C') AS 'Renda Anual Formatada'
FROM
	DimCustomer

------------------------------

/* AULA 10 - CHARINDEX e SUBSTRING PT. 01
As funções CHARINDEX e SUBSTRING combinadas são muito úteis para manipular textos de forma mais avançada.

A função CHARINDEX nos permite descobrir a posição de uma determinada posição de caracteres dentro de um texto. Essa função nos pede 2 argumentos.
1. Texto a ser procurado
2. Texto completo

Já a função SUBSTRING nos permite retornar uma quantidade de caracteres de dentro de um texto, a partir de uma posição inicial. Essa função nos pede 3 argumentos: 
1.  Texto
2. Posição inicial do texto a ser extraido
3. Quantidade de caracteres a ser extraído

Abaixo, temos alguns exemplos de ambas as funções.	*/

SELECT 'Raquel Moreno' AS 'Nome'

-- Descubra a posição em que começa o sobrenome da Raquel utilizando a função CHARINDEX
SELECT CHARINDEX('M', 'Raquel Moreno') -- Retorna a posição da letra M
SELECT CHARINDEX('Moreno', 'Raquel Moreno') -- Retorna a posição que começa o conjunto de caracteres pedido.

-- Extraia o sobrenome da Raquel utilizando a função SUBSTRING
SELECT SUBSTRING('Raquel Moreno', 8, 6) AS 'Sobrenome'
-- 3 argumentos ('Texto', 'Posiçao Inicial', 'Qtd de caracteres apartir da Posição inicial')

------------------------------

-- AULA 11 - CHARINDEX e SUBSTRING PT. 02
-- Combine as funções CHARINDEX e SUBSTRING para extrair de forma automática qualquer sobrenome

SELECT SUBSTRING('Johnatan Wener', 8, 6) AS 'Sobrenome' -- Não retornará o resultado corretamente, pois o nome 'Johnatan Wener' possui um padrão diferente do 'Raquel Moreno'; O correto seria:
SELECT SUBSTRING('Johnatan Wener', 10, 6) AS 'Sobrenome' -- Porém, para tornar essa função mais automática faremos...

SELECT 'Johnatan Wener' AS 'Nome'
SELECT CHARINDEX(' ', 'Johnatan Wener') AS 'Posição'
SELECT SUBSTRING('Johnatan Wener', CHARINDEX(' ', 'Johnatan Wener') + 1, 100) AS 'Sobrenome'


-- AULA 12 - CHARINDEX e SUBSTRING PT. 03
DECLARE @varNome VARCHAR(MAX)
SET @varNome = 'Qualquer Nome'
SELECT SUBSTRING(@varNome, CHARINDEX(' ', @varNome) + 1, 100) AS 'Sobrenome'

------------------------------

/* AULA 13 - TRIM, LTRIM e RTRIM
As funções TRIM, LTRIM e RTRIM são funções que nos permitem retirar espaços adicionais de um texto.

A função TRIM retira espaços adicionais à esquerda e à direita do texto
A função LTRIM retira espaços adicionais à esquerda do texto
A função RTRIM retira espaços adicionais à direita do texto 

Visualmente, parece que não há diferença na aplicação dessas 3 funções. Porém, se utilizarmos a função DATALENGTH sobre cada um dos resultados, vemos a diferença.
*/

-- Utilize as funções acima no código '   ABC123   '
DECLARE @varCodigo VARCHAR(MAX)
SET @varCodigo = '   ABC123   '

SELECT
	TRIM(@varCodigo) AS 'Trim',
	LTRIM(@varCodigo) AS 'Ltrim',
	RTRIM(@varCodigo) AS 'Rtrim'
-- Parece que está tudo igual porém, se utilizarmos a função DATALENGTH veremos a diferença

SELECT
	DATALENGTH(TRIM(@varCodigo)) AS 'Trim', -- Removeu todos os espaços
	DATALENGTH(LTRIM(@varCodigo)) AS 'Ltrim', -- Removeu apenas os espaços a esquerda
	DATALENGTH(RTRIM(@varCodigo)) AS 'Rtrim' -- Removeu apenas os espaços a direita

------------------------------

/* AULA 14 - DAY, MONTH, YEAR e DATEFROMPARTS
As funções DAY, MONTH e YEAR são funções que nos permitem descobrir o dia, mês e o ano de uma data. 
A função DATEFROMPARTS é uma função que nos permite retornar uma data completa a partir das informações separadas de dia, mês e ano.	  */

-- Utilize as funções DAY, MONTH e YEAR para descobrir o dia, mês e ano da data: 18/05/2020
DECLARE @varData DATETIME
SET @varData = '23/02/2020'

SELECT
	DAY(@varData) AS 'Dia',
	MONTH(@varData) AS 'Mês',
	YEAR(@varData) AS 'Ano'


-- Utilize a função DATEFROMPARTS para obter uma data a partir das informações de dia, mês e ano
DECLARE @varDia INT, @varMes INT, @varAno INT
SET @varDia = 30
SET @varMes = 08
SET @varAno = 2022

SELECT
	DATEFROMPARTS(@varAno, @varMes, @varDia) AS 'Data'

------------------------------

/* AULA 15 - GETDATE, SYSDATETIME, DATEPART e DATENAME
As funções GETDATE e SYSDATETIME nos permitem retornar a data e hora atual do sistema. A diferença entre elas é que a SYSDATETIME tem uma maior precisão em relação à GETDATE.

GETDATE: Retorna a data/hora atual do sistema
SYSDATETIME: Retorna a data/hora atual do sistema (mais preciso que a GETDATE)

As funções DATENAME e DATEPART nos retornam informações de uma data, como o dia, mês, ano, trimestre, e assim vai. As duas são usadas da mesma forma, com 2 argumentos:
1. Informação que queremos da data
2. Data
*/

SELECT GETDATE()
SELECT SYSDATETIME()

-- DATENAME: Retorna o resultado em formato de TEXTO
DECLARE @varData0 DATETIME
SET @varData0 = GETDATE()
SELECT
	DATENAME(DAY, @varData0) AS 'Dia',
	DATENAME(MONTH, @varData0) AS 'Mês',
	DATENAME(YEAR, @varData0) AS 'Ano',
	DATENAME(DW, @varData0) AS 'Dia da Semana',
	DATENAME(DAYOFYEAR, @varData0) AS 'Dia do ano'

-- DATEPART: Retorna o resultado em formato de NÚMERO
SELECT
	DATEPART(DAY, @varData0) AS 'Dia',
	DATEPART(MONTH, @varData0) AS 'Mês',
	DATEPART(YEAR, @varData0) AS 'Ano',
	DATEPART(DAYOFYEAR, @varData0) AS 'Dia do ano'

SELECT
	SQL_VARIANT_PROPERTY(DATENAME(DAY, @varData0), 'BaseType'),
	SQL_VARIANT_PROPERTY(DATEPART(DAY, @varData0), 'BaseType')

------------------------------

/* AULA 16 - DATEADD e DATEDIFF
AS funções DATEADD e DATEDIFF são funções que nos permitem realizar cálculos com datas.

A função DATEADD adiciona ou subtrai uma determinada quantidade de dias, meses ou anos de uma data. Essa função nos pede 3 argumentos.
1. Intervalo de tempo que queremos considerar (dia, mês, ano).
2. Quantidade de intervalos que queremos considerar.
3. Data na qual vamos adicionar ou subtrair os intervalos.

Já a função DATEDIFF permite o cálculo da diferença entre duas datas. Essa função nos pede 3 argumentos.
1. Intervalo de tempo que queremos subtrair (dia, mês, ano)
2. Data 1 a ser considerada no cálculo)
3. Data 2 a ser considerada no cálculo)
*/

DECLARE @varData1 DATETIME, @varData2 DATETIME, @varData3 DATETIME
SET @varData1 = '10/07/2020'
SET @varData2 = '05/03/2020'
SET @varData3 = '14/11/2021'

-- DATEADD
SELECT
	DATEADD(DAY, 30, @varData1),
	DATEADD(QUARTER, 1, @varData1),
	DATEADD(MONTH, -1, @varData1)

-- DATEDIFF
SELECT
	DATEDIFF(DAY, @varData2, @varData3),
	DATEDIFF(WEEK, @varData2, @varData3),
	DATEDIFF(MONTH, @varData2, @varData3),
	DATEDIFF(YEAR, @varData2, @varData3)

------------------------------

-- AULA 17 - Explicações Exercícios
-- AULA 18 - Resolução Exercício 01
-- AULA 19 - Resolução Exercício 02
-- AULA 20 - Resolução Exercício 03
-- AULA 21 - Resolução Exercício 04
-- AULA 22 - Resolução Exercício 05
-- AULA 23 - Resolução Exercício 06