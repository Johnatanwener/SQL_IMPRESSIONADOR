-- MÓDULO 24 - SQL SERVER - TRIGGERS DDL


/* AULA 04 - Habilitando, Desabilitando e Excluindo uma Trigger DDL
Além de, podermos excluir uma TRIGGER DDL, também temos a opção de apenas desabilitá-la. Desta forma, ela continua salva no banco de dados porém, deixa de ser disparada. Se porventura precisarmos, podemos habilitá-la novamente. */

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