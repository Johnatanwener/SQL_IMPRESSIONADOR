-- MÓDULO 17 [SQL SERVER] Regex - Regular Expressions

/* AULA 02: COLLATE - Introdução

- O que é?: 
 COLLATION é um conjunto de regras que informam ao mecanismo de banco de dados como comparar e classificar os dados 
de caracteres no SQL Server.

Em resumo, ele serve para indicar se um determinado campo será CASE INSENSITIVE e também a forma como interpreta a 
acentuação das palavras. Observe os exemplos abaixo.

- Exemplo: 
Imagine que temos uma tabela com as colunas (ID e Nome), apenas contendo dois nomes, (Marcus e André).
Porém, com cada nome escrito duas vezes de formas diferentes. (marcus e MARCUS), (André e andre).
Se quisermos filtrar essa tabela pelos nomes teríamos alguns resultados interessantes. */

SELECT
	ID,
	Nome
FROM Teste
WHERE Nome = 'MARCUS'
-- Observação 1: Neste exemplo acima, teriamos o resultado do nome Marcus escrito das duas formas (marcus e MARCUS) pois por padrão o SQL não diferencia letras maiúsculas de minúsculas.

SELECT
	ID,
	Nome
FROM Teste
WHERE Nome = 'andre'
-- Observação 2: Já neste exemplo, teríamos o resultado apenas do nome Andre escrito em letra minúscula e sem acento, pois o SQL por padrão diferencia a acentuação nas palavras.

/* Quando usamos o COLLATE, conseguimos configurar duas coisas na hora de criar os filtros de textos:
1. Se haverá ou não diferenciação entre letras maiúsculas e minúsculas.
2. Se haverá ou não diferenciação entre letras acentuadas e não acentuada. */

COLLATE Latin1_General_CI_AI

/*
_CI Identifica se a configuração será 'case insensitive' ou 'case sensitive':
	- CI: Case Insensitive (não diferencia maúsculas de minúsculas)
	- CS: Case Sensitive (diferencia maiúsculas de minúsculas)

_AI Identifica se a configuração será 'accent insensitive' ou 'accent sensitive':
	- AI: Accent Insensitive (não diferencia palavras acentuadas de não acentuadas)
	- AS: Accent Sensitive (diferencia palavras acentuadas de não acentuadas) */

------------------------------

/* AULA 03: Um pouco mais sobre COLLATE

O COLLATION nos permite configurar se teremos diferenciação entre maiúsculas e minúsculas, ou entre palavras acentuadas.

O COLLATION pode ser definido em níveis diferentes no SQL Server. Abaixo estão os três níveis:
1. A nível de programa (SQL Server)
2. A nível de Bancos de Dados
3. A nível de tabelas/colunas

1. A nível SQL Server
O COLLATION a princípio é definido durante a instalação do programa.
Por padrão, o COLLATION padrão é: Latin1_General_CI_AS

Ou seja: 
CI: Case Insensitive (não diferencia maiúsculas de minúsculas) 
AS: Accent Sensitive (sensível ao sotaque).

Para descobrir o COLLATION configurado, podemos utilizar o comando abaixo: */
SELECT SERVERPROPERTY('collation')

/* 2. A nível de Banco de Dados
Por padrão, todos os bancos de dados vão herdar a configuração do COLLATION do SQL Server feito durante a instalação.
Em Propriedades, conseguimos visualizar o COLLATION configurado.

Nós podemos também especificar o COLLATION do Banco de Dados no momento da sua criação. */
CREATE DATABASE BD_Collation
COLLATE Latin1_General_CS_AS

-- Podemos também alterar o COLLATE após criar um banco de dados. Neste caso, usamos o comando abaixo:*/
ALTER DATABASE BD_Collation COLLATE Latin1_General_CI_AS

-- Para saber o COLLATION de um Banco de Dados específico, podemos usar o comando abaixo:*/
SELECT DATABASEPROPERTYEX('BD_Collation','collation')

/*3. A nível de Coluna/Tabela
Por padrão, uma nova coluna de tipo VARCHAR herda o COLLATION do banco de dados, a menos que você especifique o COLLATION explicitamente ao criar a tabela.
Para criar uma coluna com um COLLATION diferente, você pode especificar o agrupamento usando o comando Collate SQL.*/

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

-- Se eu criar minha tabela e especificar que eu quero o COLLATION CS, o meu filtro irá diferenciar as palavras escritas com letras maiúsculas de minúsculas, ou seja, no caso do filtro acima o nome 'marcela' não seria encontrado, pois na coluna nome esta escrito como 'Marcela' e a nossa coluna foi definica como CS (Case Sensitive) logo diferencia letras maiúsculas de minúsculas. 
-- Para contorar essa diferenciação poderia adicionar o COLLATE correto no filtro, exemplo:
SELECT
	ID,
	Nome
FROM Tabela
WHERE Nome COLLATE SQL_Latin1_General_CP1_CI_AS = 'marcela'

-- Porém, o ideal seria configurar o COLLATE na criação da tabela, para que não precise ficar especificando em cada filtro o COLLATE que deseja.