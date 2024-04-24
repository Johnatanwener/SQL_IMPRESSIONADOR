-- MÓDULO 21 - SQL SERVER - FUNCTIONS

/* AULA 01 - Introducao
Nesse módulo vamos aprender sobre functions no SQL.

- O que é uma Function
- Como criar uma Function
- Como alterar uma Function
- Como excluir uma Function */


/* AULA 02 - O que e uma Function

1. O que é uma Function?
Uma FUNCTION é um conjunto de comandos que executam ações e retorna um valor escalar. As functions ajudam a simplificar um código. Por exemplo, se você tem um cálculo complexo que aparece diversas vezes no seu código, em vez de repetir várias vezes aquela série de comandos, você pode simplesmente criar uma função e reaproveitá-la sempre que precisar.

O próprio SQL tem diversas funções prontas e até agora, já vimos vários exemplos de funções deste tipo, como funções de data, texto, e assim vai.

Podemos visualizar as funções do sistema na pasta Programação > Funções > Funções do Sistema */

------------------------------

-- Criar banco de dados e tabelas que serão utilizadas nos exemplos a seguir */
CREATE DATABASE Exercicios
USE Exercicios

-- Tabela 1: dCliente
-- A tabela dCliente deve conter as seguintes colunas:

-- Coluna 1: id_cliente do tipo INT				--> Chave Primária e deve ser auto incrementada
-- Coluna 2: nome_cliente do tipo VARCHAR		--> Não aceita valores nulos
-- Coluna 3: genero VARCHAR						--> Não aceita valores nulos e deve ser ('M', 'F', 'O', 'PND')
-- Coluna 4: data_de_nascimento DATE			--> Não aceita valores nulos
-- Coluna 5: cpf do tipo VARCHAR				--> Não aceita valores nulos e nem valores duplicados

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
	('André Martins', 'M', '12/02/1989', '839.283.190-00'),
	('Bárbara Campos', 'F', '07/05/1992', '351.391.410-02'),
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

-- Coluna 1: id_gerente do tipo INT				--> Chave Primária e deve ser auto incrementada
-- Coluna 2: nome_gerente do tipo VARCHAR		--> Não aceita valores nulos
-- Coluna 3: genero VARCHAR						--> Não aceita valores nulos e deve ser ('M', 'F', 'O', 'PND')
-- Coluna 4: data_da_contratacao DATE			--> Não aceita valores nulos
-- Coluna 5: salario do tipo FLOAT				--> Não aceita valores nulos e nem valores abaixo de zero

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
	('Nathália Santos', '03/10/2018', 7200),
	('Otávio Costa', '18/04/2017', 11000)

SELECT * FROM dGerente

-- Tabela 3: fContratos
-- A tabela fContratos deve conter as seguintes colunas:

-- Coluna 1: id_contrato do tipo INT			--> Chave Primária e deve ser auto incrementada
-- Coluna 2: data_assinatura do tipo DATE		--> Valor Padrão (GETDATE) caso não seja preenchida
-- Coluna 3: id_cliente do tipo INT				--> Chave Estrangeira
-- Coluna 4: id_gerente do tipo INT				--> Chave Estrangeira
-- Coluna 5: valor_contrato do tipo FLOAT		--> Não aceita valores nulos e nem valores abaixo de zero

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
Vamos imaginar que agente queira fazer uma formatação diferenciada na coluna data_de_nascimento da tabela dCliente. Em vez de retornar apenas a data conforme ela está armazenada (por exemplo, ‘1989-02-12’), queremos retorná-la por extenso(assim: ‘Domingo, 12 de Fevereiro de 1989’)

Podemos fazer isso por meio da função DATENAME */

SELECT * FROM dCliente

SELECT 
	nome_cliente,
	data_de_nascimento,
	DATENAME(DW, data_de_nascimento) + ', ' +
	DATENAME(D, data_de_nascimento) + ' de ' +
	DATENAME(M, data_de_nascimento) + ' de ' +
	DATENAME(YY, data_de_nascimento)
FROM dCliente

/* Porém, para facilitar para gente, nós podemos criar uma function que utilize a DATENAME e retorne este mesmo resultado para qualquer coluna de data de qualquer tabela. Assim, quando formos efetuar a consulta a uma tabela que contenha uma coluna de data que precisemos retornar por extenso (como no caso da coluna data_de_nascimento da tabela dCliente), nós não precisamos recriar todo o código com a DATENAME. Tudo que precisamos fazer é “chamar” dentro do nosso SELECT a função que tivermos criado. Portando, criaremos a função, que chamaremos de fnDataCompleta. */

-- Criando uma função para formatação de data usando a DATENAME

-- 1. Iniciamos com o comando CREATE FUNCTION, damos um nome à function (fnDataCompleta), assim como ao parâmetro que será recebido por ela (no caso @data, que será do tipo DATE);
-- 2. Em seguida, informamos o tipo de dado que a function deverá retornar que, neste caso, será do tipo VARCHAR. Repare que no parâmetro a function receberá um dado do tipo DATE (YYYY-MM-DD), fará o tratamento necessário nesse dado  (cujos comandos serão passados logo mais dentro do bloco de execução que inicia com BEGIN) e retornará um dado do tipo VARCHAR(a string da data por extenso);
-- 3. Depois, abrimos o bloco de execução e, dentro dele, passamos os comandos do que a função deve ser capaz de fazer (no caso, transformar uma data em uma string desta data por extenso);
-- 4.  Finalizamos o bloco de execução com o comando END.

CREATE FUNCTION fnDataCompleta(@data AS DATE)
RETURNS VARCHAR(MAX)
AS
BEGIN
	RETURN DATENAME(DW, @Data) + ', ' +
			DATENAME(D, @Data) + ' de ' +
			DATENAME(M, @Data) + ' de ' +
			DATENAME(YY, @Data)
END

/* Repare que nossa function recém-criada agora está salva na pasta Programação > Funções > Funções com Valor  Escalar, como havíamos mencionado anteriormente.
Note que, ao nome da function, o sistema acrescentou o prefixo “dbo”. Este termo significa “database owner”  (proprietário do banco de dados) e é anexado a todo objeto criado pelo administrador do banco de dados.
Por isso, se tratando de functions, quando formos utilizá-las nas consultas que efetuarmos, devemos sempre nos lembrar de acrescentar o prefixo “dbo.” ao seu nome, caso contrário, o sistema retornará um erro.

Criada nossa function fnDataCompleta, agora podemos utilizá-la todas as vezes que precisarmos pegar um valor do tipo DATE e transformá-lo em uma string dessa data por extenso. 

Então, para executar esse procedimento com a coluna data_de_nascimento da tabela dCliente, podemos fazer como no
 código abaixo */

-- Refazendo o SELECT sem a necessidade de utilizar a função DATENAME varias vezes.
SELECT
	nome_cliente,
	data_de_nascimento,
	[dbo].[fnDataCompleta](data_de_nascimento)
FROM
	dCliente

--  Perceba que informamos o nome da função (dbo.fnDataCompleta) e, entre parênteses, passamos o nome da coluna que servirá de parâmetro para a função. Neste caso, é a coluna  data_de_nascimento da tabela dCliente.
-- Obs: Teremos o mesmo resultado que a consulta anterior, só que dessa vez ficará salvo como uma FUNCTION então, toda vez que precisar realizar uma QUERY neste formato eu poderei utilizar esta FUNCTION ao invés de escrever todo o código.

------------------------------

/* AULA 04 - Adicionando uma estrutura condicional em nossa Function
- Alterando e excluindo uma function

Para alterar uma function, devemos, na primeira linha do nosso código, utilizar o comando ALTER FUNCTION: 

Recomendado: Quando for criar uma FUNCTION, utilizar o comando CREATE OR ALTER FUNCTION, pois se a função não existir no banco de dados, será criada porém, se ela já existe será alterada. Poderiamos usar CREATE FUNCTION e depois ALTER FUNCTION porém, desta forma fica os dois comandos de uma vez só. 

Obs.: Se errar ao criar uma Function ou quiser exclui-lá do banco de dados basta usar o comando DROP */

DROP FUNCTION 'nome da function'

-- Imagine que queiramos adicionar na coluna de data por extenso que criamos anteriormente a informação de semestre, de acordo com o mês, utilizariamos o comando CASE e fariamos da seguinte forma:
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
					'(1º Semestre)'
				ELSE
					'(2º Semestre)'
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
- Crie uma função para retornar o primeiro nome de cada gerente. */

SELECT * FROM dGerente

SELECT 
	nome_gerente,
	LEFT(nome_gerente, CHARINDEX(' ', nome_gerente) - 1) AS primeiro_nome
FROM dGerente

-- Obs¹.: Se eu criar um gerente que só tenha o nome inserido, e executar a função acima novamente, será apresentado um erro.
INSERT INTO dGerente(nome_gerente, data_contratacao, salario) VALUES
	('João', '10/01/2019', 3100)

-- O que ocorreu?: A função percorreu toda nossa tabela dGerente e localizou o primeiro nome de todos os nossos gerentes corretamente a partir do espaço (CHARINDEX) porém, ao chegar no João, a nossa consulta não localizou o espaço (CHARINDEX), e por isso retornou zero e ao finalizar a função subtraiu - 1, o que fez com que o zero fosse excluído, o que fez com que toda a consulta perdesse o sentido e desse um erro. 
-- Obs².: Para contornar o erro apresentado, será necessário criarmos uma Function.

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