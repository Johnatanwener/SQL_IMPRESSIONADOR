-- M�DULO 23 - SQL SERVER - TRIGGERS DML


/* AULA 02 - O que � uma Trigger DML

Um TRIGGER � um gatilho que ser� disparado automaticamente quando acontecer um evento.

TRIGGERS podem ser disparadas por eventos DDL (CREATE, ALTER, DROP) e DML (INSERT, UPDATE, DELETE).

TRIGGER DML: 
1. Uma TRIGGER DML � disparada quando um comando INSERT, UPDATE ou DELETE � executado sobre uma tabela ou view.
2. Na hora de criar uma trigger, podemos definir alguns elementos:

TIPO (em rela��o ao evento): AFTER (depois) ou INSTEAD OF (no lugar de):

EVENTO: INSERT, UPDATE, DELETE
CORPO: Bloco de Comandos.
*/