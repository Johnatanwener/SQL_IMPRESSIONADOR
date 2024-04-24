-- M�DULO 10 - SQL SERVER - Manipulando Strings e Datas


/* AULA 01 - Introdu��o ao M�dulo
Nesse m�dulo vamos aprender a manipular textos (strings) e datas nas nossas tabelas.

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
As fun��es LEN e DATALENGTH possuem resultados semelhantes: ambos retornam a quantidade de caracteres de um determinado texto.

A grande diferen�a entre os dois � sutil: O LEN retorna a quantidade de caracteres de um texto por�m, ignora quando aparecem espa�os a mais.

J� o DATALENGTH retorna a quantidade de caracteres, incluindo espa�os a mais dentro do texto. */

-- Exemplo: Descubra a quantidade de caracteres da palavra 'SQL Hashtag'

SELECT
	LEN('SQL Hashtag') AS 'Len',
	DATALENGTH('SQL Hashtag') AS 'Datalength'

-- OBS 1: S� iremos visualizar uma diferen�a entre LEN e DATALENGTH se houver espa�os em branco adicionais no final de uma palavra, pois o DATALENGTH tamb�m contar� esses espa�os em branco, enquanto o LEN n�o. Exemplo:

SELECT
	LEN('SQL Hashtag    ') AS 'Len', -- 4 caracteres vazios
	DATALENGTH('SQL Hashtag    ') AS 'Datalength' -- 4 caracteres vazios

-- OBS 2: A escolha da utiliza��o de LEN e DATALENGTH vai depender se voc� precisar� contar espa�os vazios ou n�o. 

------------------------------

/* AULA 03 - CONCAT
A fun��o CONCAT permite juntar dois ou mais textos em um s�. 

Exemplo: Fa�a uma consulta � tabela DimCustomer onde seja poss�vel visualizar o nome completo de cada cliente. */
SELECT * FROM DimCustomer -- N�o temos uma coluna com o nome completo dos clientes.

SELECT
	FirstName AS 'Nome',
	LastName AS 'Sobrenome',
	CONCAT(FirstName, ' ', LastName) AS 'Nome Completo',
	EmailAddress AS 'E-mail'
FROM
	DimCustomer

-- OBS: Para separar os textos � obrigat�rio acrescentar um espa�o entre aspas simples;

------------------------------

/* AULA 04 - LEFT e RIGHT
As fun��es LEFT e RIGHT permitem extrair uma parte de um texto, sempre come�ando da esqueda para a direita, ou da direita para a esquerda, respectivamente.

LEFT extrai uma determinada quantidade de caracteres de um texto, da esquerda para a direita
RIGHT extrai uma determinada quantidade de caracteres de um texto, da direita para a esquerda */

SELECT * FROM DimProduct
SELECT LEFT('Product0101001', 7)
SELECT RIGHT('Product0101001', 7)
-- As fun��es ir�o solicitar 2 argumentos, sendo o primeiro o 'valor' e o segundo a quantidade de caracteres que deseja extrair)

-- Exemplo: Fa�a uma consulta � tabela DimProduct e divida a coluna de StyleName em 2 partes
SELECT
	ProductName AS 'Produto',
	UnitPrice AS 'Pre�o',
	LEFT(StyleName, 7) AS 'Cod 1', 
	RIGHT(StyleName, 7) AS 'Cod 2'
FROM
	DimProduct
-- Sempre que quiser extrair informa��es da esquerda para direitra ou vice-versa, poder� usar a fun��o LEFT e RIGHT

------------------------------

/* AULA 05 - REPLACE PT. 01
A fun��o REPLACE permite que a gente substitua um determinado texto por outro texto. */

-- No texto 'O Excel � o melhor', substitua 'Excel' por 'SQL'
SELECT REPLACE('O Excel � o melhor', 'Excel', 'SQL')

-- Exemplo: Crie uma consulta a partir de DimCustomer onde voc� retorna o Nome Completo dos Clientes, a coluna de Sexo (Abrev) e uma outra coluna de Sexo substituindo M por Masculino e F por Feminino
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
Existem outras duas fun��es usadas para substituir textos: TRANSLATE e STUFF.

A fun��o TRANSLATE permite que a gente informe uma sequ�ncia de caractereres antigos que desejamos substituir, al�m da sequ�ncia de caracteres novos que ser�o usados para substituir os caracteres antigos, seguindo exatamente a mesma sequ�ncia.

A fun��o TRANSLATE pede 3 argumentos:
1. Texto
2. Sequ�ncia antiga de caracteres
3. Sequ�ncia nova de caracteres
*/

-- TRANSLATE substitui cada caractere na ordem encontrada no texto.
SELECT TRANSLATE('10.241/444.124k23/1', './k', '---')
-- Nessa aplica��o de TRANSLATE, todos os caracteres (ponto, barra e a letra k) s�o substituidos por um (tra�o -).

SELECT TRANSLATE('10.241/444.124k23/1', './k', 'abc')
-- Nessa aplica��o de TRANSLATE, todos os caracteres (ponto, barra e a letra k) s�o substituidos por (abc), sendo que, a substitui��o ocorre 1 por 1, ou seja, todos os (.) s�o substituidos por (a), todas as (/) s�o substituidas por (b) etc.

SELECT TRANSLATE('3*[2+1]/{8-4}', '[]{}', '()()')
-- Nessa aplica��o de TRANSLATE, todos os colchetes e chaves s�o substitudos por parenteses.

SELECT TRANSLATE('ABCD-490123', 'ABCD', 'WXYZ')
-- Nessa aplica��o de TRANSLATE, os 4 primeiros caracteres s�o substituidos de 'ABCD' para WXYZ'.


/* A fun��o STUFF permite que a gente substitua uma sequ�ncia de caracteres com um tamanho espec�fico, por um outro texto.
Essa fun��o pede 4 argumentos.
1. Texto
2. Posi��o inicial onde come�a o texto antigo
3. Quantidade de caracteres do texto antigo
4. Novo texto.

Nos exemplos abaixo, temos duas situa��es: VBA Impressionador e SQL Impressionador. Ambos possuem 3 caracteres iniciais (referete ao nome do curso) e podemos utilizar esse padr�o, junto com a fun��o STUFF, para substituir sempre os 3 primeiros caracteres (independente do que esteja escrito nesses 3 primeiros caracteres) pelo texto 'Excel'.
*/

SELECT STUFF('VBA Impressionador', 1, 3, 'Excel')
SELECT STUFF('SQL Impressionador', 1, 3, 'Excel')

SELECT
	STUFF('MT98-Moto G', 1, 2, 'CEL'),
	STUFF('AP01-IPhone', 1, 2, 'CEL'),
	STUFF('SS61-Samsung Galaxy', 1, 2, 'CEL')

------------------------------

/* AULA 08 - UPPER e LOWER
As fun��es UPPER e LOWER s�o bastante intuitivas e nos permitem ajustar as palavras para que fiquem em letras mai�sculas e min�sculas.

UPPER transforma um texto em mai�scula
LOWER transforma um texto em min�scula */

-- Exemplo: Fa�a uma consulta � tabela DimCustomer e utilize as fun��es UPPER e LOWER na coluna de FirstName para observar o resultado
SELECT 
	FirstName AS 'Nome',
	UPPER(FirstName) AS 'NOME',
	LOWER(FirstName) AS 'nome',
	EmailAddress AS 'E-mail'
FROM
		DimCustomer

------------------------------

/* AULA 09 - FORMAT
A fun��o FORMAT � uma fun��o muito �til para realizar formata��es personalizadas em nossas consultas.

Essa fun��o nos pede 2 argumentos:
1. Valor a ser formatado
2. C�digo de formata��o
*/

-- 1. Formata��o de N�mero
-- 5123
SELECT FORMAT(5123, 'G') AS 'Geral' -- Formata��o Geral
SELECT FORMAT(5123, 'N') AS 'N�mero' -- Formata��o N�mero
SELECT FORMAT(5123, 'C') AS 'Moeda' -- Formata��o Moeda

-- 2. Formata��o de Data
-- 01/04/2024
SELECT FORMAT(CAST('01/04/2024' AS DATETIME), 'dd/MM/yyyy') -- Formata��o completa
SELECT FORMAT(CAST('01/04/2024' AS DATETIME), 'dd/MMM/yyyy', 'en-US') -- De acordo com o idioma
SELECT FORMAT(CAST('01/04/2024' AS DATETIME), 'dd') -- dia
SELECT FORMAT(CAST('01/04/2024' AS DATETIME), 'MM') -- m�s
SELECT FORMAT(CAST('01/04/2024' AS DATETIME), 'yy') -- ano

-- 3. Formata��o Personalizada
-- 1234567 --> 12-34-567
SELECT FORMAT(1234567, '##-##-###')

-- Formatar as colunas de Data de Nascimento e Renda Anual da tabela DimCustomer, de acordo com as formata��es aprendidas.
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
As fun��es CHARINDEX e SUBSTRING combinadas s�o muito �teis para manipular textos de forma mais avan�ada.

A fun��o CHARINDEX nos permite descobrir a posi��o de uma determinada posi��o de caracteres dentro de um texto. Essa fun��o nos pede 2 argumentos.
1. Texto a ser procurado
2. Texto completo

J� a fun��o SUBSTRING nos permite retornar uma quantidade de caracteres de dentro de um texto, a partir de uma posi��o inicial. Essa fun��o nos pede 3 argumentos: 
1.  Texto
2. Posi��o inicial do texto a ser extraido
3. Quantidade de caracteres a ser extra�do

Abaixo, temos alguns exemplos de ambas as fun��es.	*/

SELECT 'Raquel Moreno' AS 'Nome'

-- Descubra a posi��o em que come�a o sobrenome da Raquel utilizando a fun��o CHARINDEX
SELECT CHARINDEX('M', 'Raquel Moreno') -- Retorna a posi��o da letra M
SELECT CHARINDEX('Moreno', 'Raquel Moreno') -- Retorna a posi��o que come�a o conjunto de caracteres pedido.

-- Extraia o sobrenome da Raquel utilizando a fun��o SUBSTRING
SELECT SUBSTRING('Raquel Moreno', 8, 6) AS 'Sobrenome'
-- 3 argumentos ('Texto', 'Posi�ao Inicial', 'Qtd de caracteres apartir da Posi��o inicial')

------------------------------

-- AULA 11 - CHARINDEX e SUBSTRING PT. 02
-- Combine as fun��es CHARINDEX e SUBSTRING para extrair de forma autom�tica qualquer sobrenome

SELECT SUBSTRING('Johnatan Wener', 8, 6) AS 'Sobrenome' -- N�o retornar� o resultado corretamente, pois o nome 'Johnatan Wener' possui um padr�o diferente do 'Raquel Moreno'; O correto seria:
SELECT SUBSTRING('Johnatan Wener', 10, 6) AS 'Sobrenome' -- Por�m, para tornar essa fun��o mais autom�tica faremos...

SELECT 'Johnatan Wener' AS 'Nome'
SELECT CHARINDEX(' ', 'Johnatan Wener') AS 'Posi��o'
SELECT SUBSTRING('Johnatan Wener', CHARINDEX(' ', 'Johnatan Wener') + 1, 100) AS 'Sobrenome'


-- AULA 12 - CHARINDEX e SUBSTRING PT. 03
DECLARE @varNome VARCHAR(MAX)
SET @varNome = 'Qualquer Nome'
SELECT SUBSTRING(@varNome, CHARINDEX(' ', @varNome) + 1, 100) AS 'Sobrenome'

------------------------------

/* AULA 13 - TRIM, LTRIM e RTRIM
As fun��es TRIM, LTRIM e RTRIM s�o fun��es que nos permitem retirar espa�os adicionais de um texto.

A fun��o TRIM retira espa�os adicionais � esquerda e � direita do texto
A fun��o LTRIM retira espa�os adicionais � esquerda do texto
A fun��o RTRIM retira espa�os adicionais � direita do texto 

Visualmente, parece que n�o h� diferen�a na aplica��o dessas 3 fun��es. Por�m, se utilizarmos a fun��o DATALENGTH sobre cada um dos resultados, vemos a diferen�a.
*/

-- Utilize as fun��es acima no c�digo '   ABC123   '
DECLARE @varCodigo VARCHAR(MAX)
SET @varCodigo = '   ABC123   '

SELECT
	TRIM(@varCodigo) AS 'Trim',
	LTRIM(@varCodigo) AS 'Ltrim',
	RTRIM(@varCodigo) AS 'Rtrim'
-- Parece que est� tudo igual por�m, se utilizarmos a fun��o DATALENGTH veremos a diferen�a

SELECT
	DATALENGTH(TRIM(@varCodigo)) AS 'Trim', -- Removeu todos os espa�os
	DATALENGTH(LTRIM(@varCodigo)) AS 'Ltrim', -- Removeu apenas os espa�os a esquerda
	DATALENGTH(RTRIM(@varCodigo)) AS 'Rtrim' -- Removeu apenas os espa�os a direita

------------------------------

/* AULA 14 - DAY, MONTH, YEAR e DATEFROMPARTS
As fun��es DAY, MONTH e YEAR s�o fun��es que nos permitem descobrir o dia, m�s e o ano de uma data. 
A fun��o DATEFROMPARTS � uma fun��o que nos permite retornar uma data completa a partir das informa��es separadas de dia, m�s e ano.	  */

-- Utilize as fun��es DAY, MONTH e YEAR para descobrir o dia, m�s e ano da data: 18/05/2020
DECLARE @varData DATETIME
SET @varData = '23/02/2020'

SELECT
	DAY(@varData) AS 'Dia',
	MONTH(@varData) AS 'M�s',
	YEAR(@varData) AS 'Ano'


-- Utilize a fun��o DATEFROMPARTS para obter uma data a partir das informa��es de dia, m�s e ano
DECLARE @varDia INT, @varMes INT, @varAno INT
SET @varDia = 30
SET @varMes = 08
SET @varAno = 2022

SELECT
	DATEFROMPARTS(@varAno, @varMes, @varDia) AS 'Data'

------------------------------

/* AULA 15 - GETDATE, SYSDATETIME, DATEPART e DATENAME
As fun��es GETDATE e SYSDATETIME nos permitem retornar a data e hora atual do sistema. A diferen�a entre elas � que a SYSDATETIME tem uma maior precis�o em rela��o � GETDATE.

GETDATE: Retorna a data/hora atual do sistema
SYSDATETIME: Retorna a data/hora atual do sistema (mais preciso que a GETDATE)

As fun��es DATENAME e DATEPART nos retornam informa��es de uma data, como o dia, m�s, ano, trimestre, e assim vai. As duas s�o usadas da mesma forma, com 2 argumentos:
1. Informa��o que queremos da data
2. Data
*/

SELECT GETDATE()
SELECT SYSDATETIME()

-- DATENAME: Retorna o resultado em formato de TEXTO
DECLARE @varData0 DATETIME
SET @varData0 = GETDATE()
SELECT
	DATENAME(DAY, @varData0) AS 'Dia',
	DATENAME(MONTH, @varData0) AS 'M�s',
	DATENAME(YEAR, @varData0) AS 'Ano',
	DATENAME(DW, @varData0) AS 'Dia da Semana',
	DATENAME(DAYOFYEAR, @varData0) AS 'Dia do ano'

-- DATEPART: Retorna o resultado em formato de N�MERO
SELECT
	DATEPART(DAY, @varData0) AS 'Dia',
	DATEPART(MONTH, @varData0) AS 'M�s',
	DATEPART(YEAR, @varData0) AS 'Ano',
	DATEPART(DAYOFYEAR, @varData0) AS 'Dia do ano'

SELECT
	SQL_VARIANT_PROPERTY(DATENAME(DAY, @varData0), 'BaseType'),
	SQL_VARIANT_PROPERTY(DATEPART(DAY, @varData0), 'BaseType')

------------------------------

/* AULA 16 - DATEADD e DATEDIFF
AS fun��es DATEADD e DATEDIFF s�o fun��es que nos permitem realizar c�lculos com datas.

A fun��o DATEADD adiciona ou subtrai uma determinada quantidade de dias, meses ou anos de uma data. Essa fun��o nos pede 3 argumentos.
1. Intervalo de tempo que queremos considerar (dia, m�s, ano).
2. Quantidade de intervalos que queremos considerar.
3. Data na qual vamos adicionar ou subtrair os intervalos.

J� a fun��o DATEDIFF permite o c�lculo da diferen�a entre duas datas. Essa fun��o nos pede 3 argumentos.
1. Intervalo de tempo que queremos subtrair (dia, m�s, ano)
2. Data 1 a ser considerada no c�lculo)
3. Data 2 a ser considerada no c�lculo)
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

-- AULA 17 - Explica��es Exerc�cios
-- AULA 18 - Resolu��o Exerc�cio 01
-- AULA 19 - Resolu��o Exerc�cio 02
-- AULA 20 - Resolu��o Exerc�cio 03
-- AULA 21 - Resolu��o Exerc�cio 04
-- AULA 22 - Resolu��o Exerc�cio 05
-- AULA 23 - Resolu��o Exerc�cio 06