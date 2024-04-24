-- MÓDULO 23 - SQL SERVER - TRIGGERS DML


/* AULA 02 - O que é uma Trigger DML

Um TRIGGER é um gatilho que será disparado automaticamente quando acontecer um evento.

TRIGGERS podem ser disparadas por eventos DDL (CREATE, ALTER, DROP) e DML (INSERT, UPDATE, DELETE).

TRIGGER DML: 
1. Uma TRIGGER DML é disparada quando um comando INSERT, UPDATE ou DELETE é executado sobre uma tabela ou view.
2. Na hora de criar uma trigger, podemos definir alguns elementos:

TIPO (em relação ao evento): AFTER (depois) ou INSTEAD OF (no lugar de):

EVENTO: INSERT, UPDATE, DELETE
CORPO: Bloco de Comandos.
*/