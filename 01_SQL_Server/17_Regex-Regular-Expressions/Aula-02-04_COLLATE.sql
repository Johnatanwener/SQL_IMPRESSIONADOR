-- M�DULO 17 [SQL SERVER] Regex - Regular Expressions

/* AULA 02: COLLATE - Introdu��o

- O que �?: 
 COLLATION � um conjunto de regras que informam ao mecanismo de banco de dados como comparar e classificar os dados 
de caracteres no SQL Server.

Em resumo, ele serve para indicar se um determinado campo ser� CASE INSENSITIVE e tamb�m a forma como interpreta a 
acentua��o das palavras. Observe os exemplos abaixo.

- Exemplo: 
Imagine que temos uma tabela com as colunas (ID e Nome), apenas contendo dois nomes, (Marcus e Andr�).
Por�m, com cada nome escrito duas vezes de formas diferentes. (marcus e MARCUS), (Andr� e andre).
Se quisermos filtrar essa tabela pelos nomes ter�amos alguns resultados interessantes. */

SELECT
	ID,
	Nome
FROM Teste
WHERE Nome = 'MARCUS'
-- Observa��o 1: Neste exemplo acima, teriamos o resultado do nome Marcus escrito das duas formas (marcus e MARCUS) pois por padr�o o SQL n�o diferencia letras mai�sculas de min�sculas.

SELECT
	ID,
	Nome
FROM Teste
WHERE Nome = 'andre'
-- Observa��o 2: J� neste exemplo, ter�amos o resultado apenas do nome Andre escrito em letra min�scula e sem acento, pois o SQL por padr�o diferencia a acentua��o nas palavras.

/* Quando usamos o COLLATE, conseguimos configurar duas coisas na hora de criar os filtros de textos:
1. Se haver� ou n�o diferencia��o entre letras mai�sculas e min�sculas.
2. Se haver� ou n�o diferencia��o entre letras acentuadas e n�o acentuada. */

COLLATE Latin1_General_CI_AI

/*
_CI Identifica se a configura��o ser� 'case insensitive' ou 'case sensitive':
	- CI: Case Insensitive (n�o diferencia ma�sculas de min�sculas)
	- CS: Case Sensitive (diferencia mai�sculas de min�sculas)

_AI Identifica se a configura��o ser� 'accent insensitive' ou 'accent sensitive':
	- AI: Accent Insensitive (n�o diferencia palavras acentuadas de n�o acentuadas)
	- AS: Accent Sensitive (diferencia palavras acentuadas de n�o acentuadas) */

------------------------------

/* AULA 03: Um pouco mais sobre COLLATE

O COLLATION nos permite configurar se teremos diferencia��o entre mai�sculas e min�sculas, ou entre palavras acentuadas.

O COLLATION pode ser definido em n�veis diferentes no SQL Server. Abaixo est�o os tr�s n�veis:
1. A n�vel de programa (SQL Server)
2. A n�vel de Bancos de Dados
3. A n�vel de tabelas/colunas

1. A n�vel SQL Server
O COLLATION a princ�pio � definido durante a instala��o do programa.
Por padr�o, o COLLATION padr�o �: Latin1_General_CI_AS

Ou seja: 
CI: Case Insensitive (n�o diferencia mai�sculas de min�sculas) 
AS: Accent Sensitive (sens�vel ao sotaque).

Para descobrir o COLLATION configurado, podemos utilizar o comando abaixo: */
SELECT SERVERPROPERTY('collation')

/* 2. A n�vel de Banco de Dados
Por padr�o, todos os bancos de dados v�o herdar a configura��o do COLLATION do SQL Server feito durante a instala��o.
Em Propriedades, conseguimos visualizar o COLLATION configurado.

N�s podemos tamb�m especificar o COLLATION do Banco de Dados no momento da sua cria��o. */
CREATE DATABASE BD_Collation
COLLATE Latin1_General_CS_AS

-- Podemos tamb�m alterar o COLLATE ap�s criar um banco de dados. Neste caso, usamos o comando abaixo:*/
ALTER DATABASE BD_Collation COLLATE Latin1_General_CI_AS

-- Para saber o COLLATION de um Banco de Dados espec�fico, podemos usar o comando abaixo:*/
SELECT DATABASEPROPERTYEX('BD_Collation','collation')

/*3. A n�vel de Coluna/Tabela
Por padr�o, uma nova coluna de tipo VARCHAR herda o COLLATION do banco de dados, a menos que voc� especifique o COLLATION explicitamente ao criar a tabela.
Para criar uma coluna com um COLLATION diferente, voc� pode especificar o agrupamento usando o comando Collate SQL.*/

CREATE TABLE Nomes(
ID INT,
Nome1 VARCHAR(100), 
Nome2 VARCHAR(100) COLLATE Latin1_General_CS_AS)

-- Podemos ver o COLLATION de cada coluna da tabela usando o comando abaixo:*/
sp_help Nomes

------------------------------

-- AULA 04: COLLATE - Exemplo
CREATE DATABASE BD_Collation
COLLATE SQL_Latin1_General_CP1_CI_AS

CREATE TABLE Tabela(
ID INT,
Nome VARCHAR(100) COLLATE SQL_Latin1_General_CP1_CS_AS)


INSERT INTO Tabela(ID, Nome)
VALUES
	(1, 'Matheus'), (2, 'Marcela'), (3, 'marcos'), (4, 'MAuricio'), (5, 'Marta'), (6, 'Miranda'), (7, 'Melissa'), (8, 'Lucas'), (9, 'luisa'), (10, 'Pedro')

SELECT * FROM Tabela

SELECT
	ID,
	Nome
FROM Tabela
WHERE Nome = 'marcela'

-- Se eu criar minha tabela e especificar que eu quero o COLLATION CS, o meu filtro ir� diferenciar as palavras escritas com letras mai�sculas de min�sculas, ou seja, no caso do filtro acima o nome 'marcela' n�o seria encontrado, pois na coluna nome esta escrito como 'Marcela' e a nossa coluna foi definica como CS (Case Sensitive) logo diferencia letras mai�sculas de min�sculas. 
-- Para contorar essa diferencia��o poderia adicionar o COLLATE correto no filtro, exemplo:
SELECT
	ID,
	Nome
FROM Tabela
WHERE Nome COLLATE SQL_Latin1_General_CP1_CI_AS = 'marcela'

-- Por�m, o ideal seria configurar o COLLATE na cria��o da tabela, para que n�o precise ficar especificando em cada filtro o COLLATE que deseja.