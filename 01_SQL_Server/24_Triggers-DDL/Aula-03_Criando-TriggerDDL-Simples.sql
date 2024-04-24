-- MÓDULO 24 - SQL SERVER - TRIGGERS DDL


/* AULA 03 - Criando uma Trigger DDL simples
Para configurarmos as triggers DML, levamos em consideração uma Tabela ou View; 
Enquanto que, para criarmos uma TRIGGERS DDL, nós levamos em consideração o banco de dados em si.

Vejamos um exemplo:
Queremos agora criar uma trigger que impeça o INSERT, UPDATE ou DELETE de tabelas no banco de dados Exercícios;
Portando, primeiro devemos ter a certeza que o banco de dados Exercícios está selecionado. */

USE Exercicios

/* Vejamos o passo a passo para criar o código:

- 1. Iniciamos a nossa trigger com o comando CREATE OR ALTER TRIGGER e damos um nome a ela;
- 2. Incluímos o comando ON DATABASE que indica que se trata de uma TRIGGER DDL (não precisamos informar o nome do banco de dados, pois a trigger será criada dentro do banco de dados que estiver selecionado);
- 3. Acrescentamos o comando FOR e informamos os comandos DDL que serão capazes de disparar a nossa trigger quando forem executados. No caso CREATE_TABLE, ALTER_TABLE e DROP_TABLE;
- 4. Iniciamos o bloco de comandos com o comando BEGIN;
- 5. Inserimos, dentro do bloco de comandos, um PRINT para informar na tela que 'Não é permitido criação, alteração ou exclusão de tabelas', além disso, efetuamos um ROLLBACK para desfazer a tentativa de criação, alteração ou exclusão de tabela que havia sido executada, causando o disparo da trigger.
- 6. Finalizamos o bloco de comandos com o comando END;	*/

CREATE OR ALTER TRIGGER tgRecusarTabelas
ON DATABASE
FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE
AS
BEGIN

	PRINT 'Não é permitido criação, alteração ou exclusão de tabelas'
	ROLLBACK
	
END

-- Para testar nossa trigger tgRecusarTabelas, vamos tentar criar a tabela abaixo; Repare que a mensagem configurada no PRINT da trigger aparecerá na tela;

CREATE TABLE teste(ID INT)

-- Se visualizarmos as tabelas do banco de dados Exercícios, perceberemos que realmente a tabela teste não foi criada.