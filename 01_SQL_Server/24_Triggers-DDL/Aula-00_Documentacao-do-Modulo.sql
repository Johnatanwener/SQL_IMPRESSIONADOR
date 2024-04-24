-- M�DULO 24 - SQL SERVER - TRIGGERS DDL

/* AULA 01 - Introdu��o
Nesse m�dulo vamos aprender sobre as triggers DDL no SQL

- O que � uma Trigger DDL
- Criando uma Trigger DDL
- CREATE_TABLE, ALTER_TABLE e DROP_TABLE
- Habilitando e Desabilitando Triggers DDL
- Excluindo Triggers DDL		*/

------------------------------

/* AULA 02 - O que � uma Trigger DDL

- Uma TROGGER � um gatilho que ser� disparado automaticamente quando acontecer um evento.
- Triggers podem ser disparadas por eventos DDL (CREATE, ALTER, DROP) e DML (INSERT, UPDATE, DELETE).

Vimos no m�dulo anterior as TRIGGERS DML, que podem ser disparadas quando os comandos DML (INSERT, UPDATE e DELETE) s�o executados em uma Tabela ou View.

Agora, veremos como funcionam as TRIGGERS DDL:
Uma TRIGGER DDL � disparada quando um comando CREATE, ALTER ou DROP � executado.
*/

------------------------------

/* AULA 03 - Criando uma Trigger DDL simples
Para configurarmos as triggers DML, levamos em considera��o uma Tabela ou View; 
Enquanto que, para criarmos uma TRIGGERS DDL, n�s levamos em considera��o o banco de dados em si.

Vejamos um exemplo:
Queremos agora criar uma trigger que impe�a o INSERT, UPDATE ou DELETE de tabelas no banco de dados Exerc�cios;
Portando, primeiro devemos ter a certeza que o banco de dados Exerc�cios est� selecionado. */

USE Exercicios

/* Vejamos o passo a passo para criar o c�digo:

- 1. Iniciamos a nossa trigger com o comando CREATE OR ALTER TRIGGER e damos um nome a ela;
- 2. Inclu�mos o comando ON DATABASE que indica que se trata de uma TRIGGER DDL (n�o precisamos informar o nome do banco de dados, pois a trigger ser� criada dentro do banco de dados que estiver selecionado);
- 3. Acrescentamos o comando FOR e informamos os comandos DDL que ser�o capazes de disparar a nossa trigger quando forem executados. No caso CREATE_TABLE, ALTER_TABLE e DROP_TABLE;
- 4. Iniciamos o bloco de comandos com o comando BEGIN;
- 5. Inserimos, dentro do bloco de comandos, um PRINT para informar na tela que 'N�o � permitido cria��o, altera��o ou exclus�o de tabelas', al�m disso, efetuamos um ROLLBACK para desfazer a tentativa de cria��o, altera��o ou exclus�o de tabela que havia sido executada, causando o disparo da trigger.
- 6. Finalizamos o bloco de comandos com o comando END;	*/

CREATE OR ALTER TRIGGER tgRecusarTabelas
ON DATABASE
FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE
AS
BEGIN

	PRINT 'N�o � permitido cria��o, altera��o ou exclus�o de tabelas'
	ROLLBACK
	
END

-- Para testar nossa trigger tgRecusarTabelas, vamos tentar criar a tabela abaixo; Repare que a mensagem configurada no PRINT da trigger aparecer� na tela;

CREATE TABLE teste(ID INT)

-- Se visualizarmos as tabelas do banco de dados Exerc�cios, perceberemos que realmente a tabela teste n�o foi criada.

------------------------------

/* AULA 04 - Habilitando, Desabilitando e Excluindo uma Trigger DDL
Al�m de, podermos excluir uma TRIGGER DDL, tamb�m temos a op��o de apenas desabilit�-la. Desta forma, ela continua salva no banco de dados por�m, deixa de ser disparada. Se porventura precisarmos, podemos habilit�-la novamente. */

-- Para desabilitar uma trigger DDL, utilizamos o comando DISABLE:
DISABLE TRIGGER nome_da_trigger ON DATABASE

-- Para habilitar uma trigger DDL novamente, utilizamos o comando ENABLE:
ENABLE TRIGGER nome_da_trigger ON DATABASE

-- Para desabilitar TODAS as trigger DDL de um banco de dados utilizamos a seguinte sintaxxe:
DISABLE TRIGGER ALL ON DATABASE

-- Para habilitar novamente TODAS as trigger DDL de um banco de dados utilizamos a seguinte sintaxe:
ENABLE TRIGGER ALL ON DATABASE

-- Por fim, para excluir uma trigger DDL, utilizamos a sintaxe:
DROP TRIGGER nome_da_trigger DATABASE


-- Desabilitando e Habilitando a Trigger DDL tgRecusarTabelas
DISABLE TRIGGER tgRecusarTabelas ON DATABASE -- Desabilitando uma Trigger DDL
CREATE TABLE teste1(ID INT)

ENABLE TRIGGER tgRecusarTabelas ON DATABASE -- Habilitando uma Trigger DDL
CREATE TABLE teste2(ID INT)


-- Desabilitando e Habilitando TODAS as Triggers DDL do banco de dados
DISABLE TRIGGER ALL ON DATABASE
ENABLE TRIGGER ALL ON DATABASE


-- Excluindo a Trigger DDL tgRecusarTabelas
DROP TRIGGER tgRecusarTabelas ON DATABASE