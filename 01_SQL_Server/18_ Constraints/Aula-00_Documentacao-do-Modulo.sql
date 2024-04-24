-- M�DULO 18 [SQL SERVER] Constraints


/* AULA 01: Introdu��o
Nesso m�dulo vamos aprender a utilizar constraints no SQL

- O que s�o Constraints
- NOT NULL
- UNIQUE
- CHECK
- DEFAULT
- IDENTIFY
- PRIMARY KEY
- FOREIGN KEY
- O que muda ao criar Constrainsts
- Viola��o de Constraints
- Gerenciando Constraints
- Cuidados com Constraints

Objetivo: Entender o que s�o constraints e como trabalhar com elas na pr�tica. */

------------------------------

/* AULA 02: NOT NULL, UNIQUE, CHECK, DEFAULT, IDENTIFY, PRIMARY KEY, FOREIGN KEY
CONSTRAINTS no SQL s�o regras (restri��es) que podemos definir para uma coluna de uma tabela. Essas regras garantem integridade ao Banco de Dados, pois � atrav�s delas que garantimos que apenas os valores que atendam �s regras pr�-estabelecidas sejam inclu�dos em cada coluna.

1. NOT NULL
- Essa constraint n�o permite que sejam adicionados valores nulos na coluna.

2. UNIQUE
- Identifica uma coluna de forma �nica, sem permitir valores duplicados (mas, permite NULL).

3. CHECK
- Verifica se o valor adicionado na coluna atende a uma determinada condi��o.

4. DEFAULT
- Retorna um valor default caso a coluna n�o seja preenchida.

5. IDENTITY
- Permite que uma coluna siga uma auto numera��o (usada em colunas de ID).

6. PRIMARY KEY
- Uma CHAVE PRIM�RIA (PRIMARY KEY) � uma coluna que identifica de forma �nica as linhas de uma tabela. Nenhum dos valores de uma coluna de chave prim�ria deve ser nulo ou se repetir.
	Ser� atrav�s dessa coluna que criaremos rela��es entre as tabelas.

7. FOREIGN KEY
- Uma CHAVE ESTRANGEIRA (FOREIGN KEY) � uma coluna que ser� relacionada com a CHAVE PRIM�RIA de uma outra tabela. */

------------------------------

-- AULA 03: O que temos sem Constraints_
CREATE DATABASE Exercicios
USE Exercicios

DROP TABLE fContratos
DROP TABLE dCliente
DROP TABLE dGerente

------------------------------

-- AULA 04: Criando Constraints para a Tabela dCliente

-- A tabela dCliente deve conter as seguintes colunas:
-- Coluna 1: id_cliente do tipo INT          --> Chave Prim�ria e deve ser auto incrementada
-- Coluna 2: nome_cliente do tipo VARCHAR    --> N�o aceita valores nulos
-- Coluna 3: genero VARCHAR                  --> N�o aceita valores nulos e devem ser ('M', 'F', 'O', 'PND')
-- Coluna 4: data_nascimento DATE            --> N�o aceita valores nulos  
-- Coluna 5: cpf do tipo VARCHAR             --> N�o aceita valores duplicados nem valores nulos

CREATE TABLE dCliente(
	id_cliente INT IDENTITY(1, 1),
	nome_cliente VARCHAR(100) NOT NULL,
	genero VARCHAR (100) NOT NULL,
	data_de_nascimento DATE NOT NULL,
	cpf VARCHAR(100) NOT NULL,
	CONSTRAINT dCliente_cliente_pk PRIMARY KEY(id_cliente),
	CONSTRAINT dCliente_genero_ck CHECK(Genero IN ('M', 'F', 'O', 'PND')),
	CONSTRAINT dCliente_cpf_un UNIQUE(cpf)
)

INSERT INTO dCliente(Nome_Cliente, Genero, Data_de_Nascimento, CPF)
VALUES
	('Andr� Martins',  'M',  '12/02/1989', '839.283.190-00'),
	('B�rbara Campos',  'F', '07/05/1992', '351.391.410-02'),
	('Carol Freitas',  'F',  '23/04/1985', '139.274.921-12'),
	('Diego Cardoso',   'M', '11/10/1994', '192.371.081-17'),
	('Eduardo Pereira', 'M', '09/11/1988', '193.174.192-82'),
	('Fabiana Silva',  'F',  '02/09/1989', '231.298.471-98'),
	('Gustavo Barbosa', 'M', '27/06/1993', '240.174.171-76'),
	('Helen Viana',    'F',  '11/02/1990', '193.129.183-01'),
	('Igor Castro',    'M',  '21/08/1989', '184.148.102-29'),
	('Juliana Pires',   'F', '13/01/1991', '416.209.192-47')

SELECT * FROM dCliente

------------------------------

-- AULA 05: Criando Constraints para a Tabela dGerente

-- A tabela dGerente deve conter as seguintes colunas:
-- Coluna 1: id_gerente do tipo INT            --> Chave Prim�ria e auto incrementada
-- Coluna 2: nome_gerente do tipo VARCHAR      --> N�o aceita valores nulos
-- Coluna 3: data_contratacao VARCHAR          --> N�o aceita valores nulos
-- Coluna 4: salario do tipo FLOAT             --> N�o aceita valores nulos nem abaixo de zero

CREATE TABLE dGerente(
	id_gerente INT IDENTITY(1, 1),
	nome_gerente VARCHAR(100) NOT NULL,
	data_contratacao VARCHAR(100) NOT NULL,
	salario FLOAT NOT NULL,
	CONSTRAINT dGerente_id_derente_pk PRIMARY KEY(id_gerente),
	CONSTRAINT dGerente_salario_ck CHECK(salario > 0)
)

INSERT INTO dGerente(Nome_Gerente, Data_Contratacao, Salario)
VALUES
	('Lucas Sampaio',   '21/03/2015', 6700),
	('Mariana Padilha', '10/01/2011', 9900),
	('Nath�lia Santos', '03/10/2018', 7200),
	('Ot�vio Costa',    '18/04/2017', 11000)

SELECT * FROM dGerente

------------------------------

-- AULA 06: Criando Constraints para a Tabela fContratos

-- A tabela fContratos deve conter as seguintes colunas:
-- Coluna 1: id_contrato do tipo INT           --> Chave Prim�ria e auto incremental
-- Coluna 2: data_assinatura do tipo DATE      --> Valor Padr�o (GETDATE) caso n�o seja preenchida
-- Coluna 3: id_cliente do tipo INT            --> Chave Estrangeira
-- Coluna 4: id_gerente do tipo INT            --> Chave Estrangeira
-- Coluna 5: valor_contrato do tipo FLOAT      --> N�o aceita valores nulos e deve ser maior que zero

CREATE TABLE fContratos(
	id_contrato INT IDENTITY(1, 1),
	data_assinatura DATE DEFAULT GETDATE(),
	id_cliente INT,
	id_gerente INT,
	valor_contrato FLOAT,
	CONSTRAINT fContratos_id_contrato_pk PRIMARY KEY(id_contrato),
	CONSTRAINT fContratos_id_cliente_fk FOREIGN KEY(id_cliente) REFERENCES dCliente(id_cliente),
	CONSTRAINT fContratos_id_gerente_fk FOREIGN KEY(id_gerente) REFERENCES dGerente(id_gerente),
	CONSTRAINT fContratos_valor_contrato_ck CHECK(valor_contrato > 0)
)

INSERT INTO fContratos(Data_Assinatura, ID_Cliente, ID_Gerente, Valor_Contrato)
VALUES
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

-- AULA 07: O que muda ao criar Constraints_

------------------------------

/* AULA 08: Viola��o de Constraints Pt. 01

- Viola��o NOT NULL
Recapitulando, a CONSTRAINT NOT NULL n�o permite que sejam adicionados valores nulos � coluna.
Definimos a CONSTRAINT NOT NULL em diversas colunas da tabela dCliente e entre elas a coluna nome_cliente.

Isso significa que a coluna nome_cliente precisa ser devidamente preenchida quando inserimos um novo registro (linha) na tabela dCliente. Portanto, se tentarmos executar, por exemplo, o INSERT INTO abaixo, teremos um problema. */
INSERT INTO dCliente(Genero, Data_de_Nascimento, CPF) VALUES
	('F', '10/01/1989', '123.234.812-20');

/* Quando deixamos de informar uma coluna na hora de inserir novos dados, o sistema entende que aquela coluna deve ser deixada vazia (preenchida como NULL). Como definimos, quando criamos nossa tabela dCliente, a restri��o NOT NULL para a coluna nome_cliente, o sistema vai retornar o erro de c�digo. Desta forma, a tentativa de inser��o de um novo registro � considerada falha, e nenhum dado deste novo registro � salvo no banco de dados, nem mesmo nas outras colunas que atendiam �s especifica��es.


-  Viola��o CHECK
Recapitulando, a CONSTRAINT CHECK verifica se o valor adicionado na coluna atende a uma determinada condi��o.
Definimos a CONSTRAINT CHECK para a coluna genero da tabela dCliente, estabelecendo a condi��o: 
Genero IN ('M', 'F', 'O', 'PND')

Isso significa que a coluna genero s� pode ser preenchida com os valores 'M' (para masculino), 'F' (para feminino), 'O' (para outros) ou 'PND' (para prefiro n�o declarar) quando inserimos um novo registro (linha) na tabela dCliente. Portanto, se tentarmos executar, por exemplo, o INSERT INTO abaixo, teremos um problema. */
INSERT INTO dCliente(Nome_Cliente, Genero, Data_de_Nascimento, CPF) VALUES
	('Katia Lopes',  'Feminino', '10/01/1989', '123.234.812-20');

-- Quando violamos uma restri��o CHECK, o sistema retorna um erro informando os nomes da constraint, do banco de dados, da tabela e da coluna violada. Desta forma, a tentativa de inser��o de um novo registro � considerada falha, e nenhum dado deste novo registro � salvo no banco de dados, nem mesmo nas outras colunas que atendiam �s especifica��es.

------------------------------

/*  AULA 09: Viola��o de Constraints Pt. 02

- Viola��o UNIQUE
 Recapitulando, a CONSTRAINT UNIQUE identifica uma coluna de forma �nica, sem permitir valores duplicados. 
 Definimos a CONSTRAINT UNIQUE para a coluna cpf da tabela dCliente.

 Isso significa que a coluna cpf n�o pode receber um valor que j� conste na coluna como pertencente a algum outro registro (cliente) da tabela dCliente. Portanto, se tentarmos executar, por exemplo, o INSERT INTO abaixo, teremos mais um problema, pois o CPF informado j� foi informado como sendo de outro cliente. */

INSERT INTO dCliente(Nome_Cliente, Genero, Data_de_Nascimento, CPF) VALUES
	('Katia Lopes',  'F', '10/01/1989', '839.283.190-00');

-- Quando violamos uma restri��o UNIQUE, o sistema retorna um erro informando os nomes da constraint e da tabela, assim como o valor da chave duplicada. Desta forma, a tentativa de inser��o de um novo registro � considerada falha, e nenhum dado deste novo registro � salvo no banco de dados, nem mesmo nas outras colunas que atendiam �s especifica��es.

------------------------------

/* AULA 10: Viola��o de Constraints Pt. 03

- Viola��o PRIMARY KEY e FOREIGN KEY
Recapitulando, a CONSTRAINT PRYMARY KEY torna uma coluna prim�ria da tabela, ao passo que a CONSTRAINT FOREIGN KEY torna uma coluna uma chave estrangeira da tabela, que ser� relacionada � chave prim�ria (PRIMARY KEY) de outra tabela.

Definimos a CONSTRAINT FOREIGN KEY para a coluna id_gerente, que faz refer�ncia a PRIMARY KEY id_gerente estabelecida na tabela dGerente.

Isso significa que a coluna id_gerente da tabela fContratos n�o pode receber um ID de um gerente que n�o exista na coluna id_gerente da tabela dGerente. Portanto, se tentarmos executar, por exemplo, o INSERT INTO abaixo, teremos outro problema. Pois o id_gerente informado (10) n�o existe na tabela dGerente */

INSERT INTO fContratos(Data_Assinatura, ID_Cliente, ID_Gerente, Valor_Contrato) VALUES
    ('12/03/2022', 4, 10, 1500);

-- Quando violamos as restri��es PRIMARY KEY e FOREIGN KEY, o sistema retorna um erro informando os nomes da constraint, do banco de dados, da tabela e da coluna violada. Desta forma, a tentativa de inser��o de um novo registro � considerada falha, e nenhum dado deste novo registro � salvo no banco de dados, nem mesmo nas outras colunas que atendiam �s especifica��es.

------------------------------

-- AULA 11: Gerenciando CONSTRAINTS
-- Vejamos agora como fazemos para adicionar, renomear e remover CONSTRAINTS.

/* 1. Adicionar constraints
Para ADICIONAR uma nova CONSTRAINT a uma tabela, utilizamos a seguinte sintaxe: 
ALTER TABLE nome_da_tabela
ADD CONSTRAINT nome_da_nova_constraint tipo_da_nova_constraint (nome_da_coluna);
Exemplos: */

-- Adicione a constraint PK id_venda na tabela fContratos.
ALTER TABLE fContratos
ADD CONSTRAINT fcontratos_id_contrato_pk PRIMARY KEY(id_contrato)

-- Adicione a constraint FK id_cliente na tabela fContratos.
ALTER TABLE fContratos
ADD CONSTRAINT fcontratos_id_cliente_fk FOREIGN KEY(id_cliente) REFERENCES dCliente(id_cliente)

/* 2. Renomear constraints
Para RENOMEAR uma CONSTRAINT de uma tabela, devemos clicar com o bot�o direito sobre o nome constraint no menu lateral esquerdo da tela (Bancos de Dados > Nome_do_Banco_de_Dados > Tabelas > Nome_da_Tabela > Chaves > Nome_da_Constraint), ap�s em Renomear: */

/* 3. Remover constraints
Para REMOVER uma CONSTRAINT de uma tabela, utilizamos a seguinte sintaxe:

ALTER TABLE nome_da_tabela
DROP CONSTRAINT nome_da_constraint;
Exemplos:	*/

-- Remova a constraint PK da tabela fContratos.
ALTER TABLE fContratos
DROP CONSTRAINT fcontratos_id_contrato_pk

-- Remova a constraint FK Cliente da tabela fContratos.
ALTER TABLE fContratos
DROP CONSTRAINT fcontratos_id_cliente_fk

------------------------------

-- AULA 12: Explica��o Exerc�cios
-- AULA 13: Resolu��o Exerc�cio 01
-- AULA 14: Resolu��o Exerc�cio 02