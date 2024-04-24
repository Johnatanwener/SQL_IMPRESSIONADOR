-- M�DULO 21 - SQL SERVER - FUNCTIONS

/* AULA 01 - Introducao
Nesse m�dulo vamos aprender sobre functions no SQL.

- O que � uma Function
- Como criar uma Function
- Como alterar uma Function
- Como excluir uma Function */


/* AULA 02 - O que e uma Function

1. O que � uma Function?
Uma FUNCTION � um conjunto de comandos que executam a��es e retorna um valor escalar. As functions ajudam a simplificar um c�digo. Por exemplo, se voc� tem um c�lculo complexo que aparece diversas vezes no seu c�digo, em vez de repetir v�rias vezes aquela s�rie de comandos, voc� pode simplesmente criar uma fun��o e reaproveit�-la sempre que precisar.

O pr�prio SQL tem diversas fun��es prontas e at� agora, j� vimos v�rios exemplos de fun��es deste tipo, como fun��es de data, texto, e assim vai.

Podemos visualizar as fun��es do sistema na pasta Programa��o > Fun��es > Fun��es do Sistema */

------------------------------

-- Criar banco de dados e tabelas que ser�o utilizadas nos exemplos a seguir */
CREATE DATABASE Exercicios
USE Exercicios

-- Tabela 1: dCliente
-- A tabela dCliente deve conter as seguintes colunas:

-- Coluna 1: id_cliente do tipo INT				--> Chave Prim�ria e deve ser auto incrementada
-- Coluna 2: nome_cliente do tipo VARCHAR		--> N�o aceita valores nulos
-- Coluna 3: genero VARCHAR						--> N�o aceita valores nulos e deve ser ('M', 'F', 'O', 'PND')
-- Coluna 4: data_de_nascimento DATE			--> N�o aceita valores nulos
-- Coluna 5: cpf do tipo VARCHAR				--> N�o aceita valores nulos e nem valores duplicados

CREATE TABLE dCliente(
	id_cliente INT IDENTITY(1, 1),
	nome_cliente VARCHAR(100) NOT NULL,
	genero VARCHAR(100) NOT NULL, 
	data_de_nascimento DATE NOT NULL,
	cpf VARCHAR(100) NOT NULL,
	CONSTRAINT dcliente_id_cliente_pk PRIMARY KEY(id_cliente),
	CONSTRAINT dcliente_genero_ck CHECK(Genero IN ('M', 'F', 'O', 'PND')),
	CONSTRAINT dcliente_cpf_un UNIQUE(CPF)
)

INSERT INTO dCliente(nome_cliente, genero, data_de_nascimento, cpf) VALUES
	('Andr� Martins', 'M', '12/02/1989', '839.283.190-00'),
	('B�rbara Campos', 'F', '07/05/1992', '351.391.410-02'),
	('Carol Freitas', 'F', '23/04/1985', '139.274.921-12'),
	('Diego Cardoso', 'M', '11/10/1994', '192.371.081-17'),
	('Eduardo Pereira', 'M', '09/11/1988', '193.174.192-82'),
	('Fabiana Silva', 'F', '02/09/1989', '231.298.471-98'),
	('Gustavo Barbosa', 'M', '27/06/1993', '240.174.171-76'),
	('Helen Viana', 'F', '11/02/1990', '193.129.183-01'),
	('Igor Castro', 'M', '21/08/1989', '184.148.102-29'),
	('Juliana Pires', 'F', '13/01/1991', '419.209.192-47')

SELECT * FROM dCliente

-- Tabela 2: dGerente
-- A tabela dGerente deve conter as seguintes colunas:

-- Coluna 1: id_gerente do tipo INT				--> Chave Prim�ria e deve ser auto incrementada
-- Coluna 2: nome_gerente do tipo VARCHAR		--> N�o aceita valores nulos
-- Coluna 3: genero VARCHAR						--> N�o aceita valores nulos e deve ser ('M', 'F', 'O', 'PND')
-- Coluna 4: data_da_contratacao DATE			--> N�o aceita valores nulos
-- Coluna 5: salario do tipo FLOAT				--> N�o aceita valores nulos e nem valores abaixo de zero

CREATE TABLE dGerente(
	id_gerente INT IDENTITY(1, 1),
	nome_gerente VARCHAR(100) NOT NULL,
	data_contratacao DATE NOT NULL,
	salario FLOAT NOT NULL,
	CONSTRAINT dGerente_id_gerente_pk PRIMARY KEY(id_gerente),
	CONSTRAINT dgerente_salario_ck CHECK(salario > 0)
)

INSERT INTO dGerente(nome_gerente, data_contratacao, salario) VALUES
	('Lucas Sampaio', '21/03/2015', 6700),
	('Mariana Padilha', '10/01/2011', 9900),
	('Nath�lia Santos', '03/10/2018', 7200),
	('Ot�vio Costa', '18/04/2017', 11000)

SELECT * FROM dGerente

-- Tabela 3: fContratos
-- A tabela fContratos deve conter as seguintes colunas:

-- Coluna 1: id_contrato do tipo INT			--> Chave Prim�ria e deve ser auto incrementada
-- Coluna 2: data_assinatura do tipo DATE		--> Valor Padr�o (GETDATE) caso n�o seja preenchida
-- Coluna 3: id_cliente do tipo INT				--> Chave Estrangeira
-- Coluna 4: id_gerente do tipo INT				--> Chave Estrangeira
-- Coluna 5: valor_contrato do tipo FLOAT		--> N�o aceita valores nulos e nem valores abaixo de zero

CREATE TABLE fContratos(
	id_contrato INT IDENTITY(1, 1),
	data_assinatura DATE DEFAULT GETDATE(),
	id_cliente INT,
	id_gerente INT,
	valor_contrato FLOAT,
	CONSTRAINT fContratos_id_contrato_pk PRIMARY KEY(id_contrato),
	CONSTRAINT fContratos_id_cliente_fk FOREIGN KEY(id_cliente) REFERENCES dCliente(id_cliente),
	CONSTRAINT fContratos_id_gerente_fk FOREIGN KEY(id_Gerente) REFERENCES dGerente(id_gerente),
	CONSTRAINT fContratos_valor_contrato_ck CHECK(valor_contrato > 0) 
)

INSERT INTO fContratos(data_assinatura, id_cliente, id_gerente, valor_contrato) VALUES
	('12/01/2019', 8, 1, 23000),
	('10/02/2019', 3, 2, 15500),
	('07/03/2019', 7, 2, 6500),
	('15/03/2019', 1, 3, 33000),
	('21/03/2019', 5, 4, 11100),
	('23/03/2019', 4, 2, 5500),
	('28/03/2019', 9, 3, 55000),
	('04/04/2019', 2, 1, 31000),
	('05/04/2019', 10, 4, 3400),
	('05/04/2019', 6, 2, 9200)

SELECT * FROM fContratos
------------------------------

/* AULA 03 - Como criar e utilizar uma Function
Vamos imaginar que agente queira fazer uma formata��o diferenciada na coluna data_de_nascimento da tabela dCliente. Em vez de retornar apenas a data conforme ela est� armazenada (por exemplo, �1989-02-12�), queremos retorn�-la por extenso(assim: �Domingo, 12 de Fevereiro de 1989�)

Podemos fazer isso por meio da fun��o DATENAME */

SELECT * FROM dCliente

SELECT 
	nome_cliente,
	data_de_nascimento,
	DATENAME(DW, data_de_nascimento) + ', ' +
	DATENAME(D, data_de_nascimento) + ' de ' +
	DATENAME(M, data_de_nascimento) + ' de ' +
	DATENAME(YY, data_de_nascimento)
FROM dCliente

/* Por�m, para facilitar para gente, n�s podemos criar uma function que utilize a DATENAME e retorne este mesmo resultado para qualquer coluna de data de qualquer tabela. Assim, quando formos efetuar a consulta a uma tabela que contenha uma coluna de data que precisemos retornar por extenso (como no caso da coluna data_de_nascimento da tabela dCliente), n�s n�o precisamos recriar todo o c�digo com a DATENAME. Tudo que precisamos fazer � �chamar� dentro do nosso SELECT a fun��o que tivermos criado. Portando, criaremos a fun��o, que chamaremos de fnDataCompleta. */

-- Criando uma fun��o para formata��o de data usando a DATENAME

-- 1. Iniciamos com o comando CREATE FUNCTION, damos um nome � function (fnDataCompleta), assim como ao par�metro que ser� recebido por ela (no caso @data, que ser� do tipo DATE);
-- 2. Em seguida, informamos o tipo de dado que a function dever� retornar que, neste caso, ser� do tipo VARCHAR. Repare que no par�metro a function receber� um dado do tipo DATE (YYYY-MM-DD), far� o tratamento necess�rio nesse dado  (cujos comandos ser�o passados logo mais dentro do bloco de execu��o que inicia com BEGIN) e retornar� um dado do tipo VARCHAR(a string da data por extenso);
-- 3. Depois, abrimos o bloco de execu��o e, dentro dele, passamos os comandos do que a fun��o deve ser capaz de fazer (no caso, transformar uma data em uma string desta data por extenso);
-- 4.  Finalizamos o bloco de execu��o com o comando END.

CREATE FUNCTION fnDataCompleta(@data AS DATE)
RETURNS VARCHAR(MAX)
AS
BEGIN
	RETURN DATENAME(DW, @Data) + ', ' +
			DATENAME(D, @Data) + ' de ' +
			DATENAME(M, @Data) + ' de ' +
			DATENAME(YY, @Data)
END

/* Repare que nossa function rec�m-criada agora est� salva na pasta Programa��o > Fun��es > Fun��es com Valor  Escalar, como hav�amos mencionado anteriormente.
Note que, ao nome da function, o sistema acrescentou o prefixo �dbo�. Este termo significa �database owner�  (propriet�rio do banco de dados) e � anexado a todo objeto criado pelo administrador do banco de dados.
Por isso, se tratando de functions, quando formos utiliz�-las nas consultas que efetuarmos, devemos sempre nos lembrar de acrescentar o prefixo �dbo.� ao seu nome, caso contr�rio, o sistema retornar� um erro.

Criada nossa function fnDataCompleta, agora podemos utiliz�-la todas as vezes que precisarmos pegar um valor do tipo DATE e transform�-lo em uma string dessa data por extenso. 

Ent�o, para executar esse procedimento com a coluna data_de_nascimento da tabela dCliente, podemos fazer como no
 c�digo abaixo */

-- Refazendo o SELECT sem a necessidade de utilizar a fun��o DATENAME varias vezes.
SELECT
	nome_cliente,
	data_de_nascimento,
	[dbo].[fnDataCompleta](data_de_nascimento)
FROM
	dCliente

--  Perceba que informamos o nome da fun��o (dbo.fnDataCompleta) e, entre par�nteses, passamos o nome da coluna que servir� de par�metro para a fun��o. Neste caso, � a coluna  data_de_nascimento da tabela dCliente.
-- Obs: Teremos o mesmo resultado que a consulta anterior, s� que dessa vez ficar� salvo como uma FUNCTION ent�o, toda vez que precisar realizar uma QUERY neste formato eu poderei utilizar esta FUNCTION ao inv�s de escrever todo o c�digo.

------------------------------

/* AULA 04 - Adicionando uma estrutura condicional em nossa Function
- Alterando e excluindo uma function

Para alterar uma function, devemos, na primeira linha do nosso c�digo, utilizar o comando ALTER FUNCTION: 

Recomendado: Quando for criar uma FUNCTION, utilizar o comando CREATE OR ALTER FUNCTION, pois se a fun��o n�o existir no banco de dados, ser� criada por�m, se ela j� existe ser� alterada. Poderiamos usar CREATE FUNCTION e depois ALTER FUNCTION por�m, desta forma fica os dois comandos de uma vez s�. 

Obs.: Se errar ao criar uma Function ou quiser exclui-l� do banco de dados basta usar o comando DROP */

DROP FUNCTION 'nome da function'

-- Imagine que queiramos adicionar na coluna de data por extenso que criamos anteriormente a informa��o de semestre, de acordo com o m�s, utilizariamos o comando CASE e fariamos da seguinte forma:
CREATE OR ALTER FUNCTION fnDataCompleta(@data AS DATE)
RETURNS VARCHAR(MAX)
AS
BEGIN

	RETURN DATENAME(DW, @Data) + ', ' +
			DATENAME(D, @Data) + ' de ' +
			DATENAME(M, @Data) + ' de ' + 
			DATENAME(YY, @Data) + ' - ' +
			CASE
				WHEN MONTH(@Data) <= 6 THEN
					'(1� Semestre)'
				ELSE
					'(2� Semestre)'
			END

END
-----
SELECT
	nome_cliente,
	data_de_nascimento,
	[dbo].[fnDataCompleta](data_de_nascimento)
FROM
	dCliente

DROP FUNCTION fnDataCompleta
------------------------------

/* AULA 05 - Criando funcoes complexas pt. 01
- Crie uma fun��o para retornar o primeiro nome de cada gerente. */

SELECT * FROM dGerente

SELECT 
	nome_gerente,
	LEFT(nome_gerente, CHARINDEX(' ', nome_gerente) - 1) AS primeiro_nome
FROM dGerente

-- Obs�.: Se eu criar um gerente que s� tenha o nome inserido, e executar a fun��o acima novamente, ser� apresentado um erro.
INSERT INTO dGerente(nome_gerente, data_contratacao, salario) VALUES
	('Jo�o', '10/01/2019', 3100)

-- O que ocorreu?: A fun��o percorreu toda nossa tabela dGerente e localizou o primeiro nome de todos os nossos gerentes corretamente a partir do espa�o (CHARINDEX) por�m, ao chegar no Jo�o, a nossa consulta n�o localizou o espa�o (CHARINDEX), e por isso retornou zero e ao finalizar a fun��o subtraiu - 1, o que fez com que o zero fosse exclu�do, o que fez com que toda a consulta perdesse o sentido e desse um erro. 
-- Obs�.: Para contornar o erro apresentado, ser� necess�rio criarmos uma Function.

------------------------------

-- AULA 06 - Criando funcoes complexas pt. 02

CREATE OR ALTER FUNCTION fnPrimeiroNome(@nomeCompleto AS VARCHAR(MAX))
RETURNS VARCHAR(MAX)
AS
BEGIN

	DECLARE @posicaoEspaco AS INT
	DECLARE @resposta AS VARCHAR(MAX)

	SET @posicaoEspaco = CHARINDEX(' ', @nomeCompleto)

	IF @posicaoEspaco = 0
		SET @resposta = @nomeCompleto
	ELSE
		SET @resposta = LEFT(@nomeCompleto, @posicaoEspaco - 1)

	RETURN @resposta

END

SELECT
	nome_gerente,
	dbo.fnPrimeiroNome(nome_gerente) AS primeiro_nome
FROM dGerente

------------------------------

-- AULA 07 - Explicacao Exercicios
-- AULA 08 - Resolucao Exercicio 01
-- AULA 09 - Resolucao Exercicio 02
-- AULA 10 - Resolucao Exercicio 03
-- AULA 11 - Resolucao Exercicio 04