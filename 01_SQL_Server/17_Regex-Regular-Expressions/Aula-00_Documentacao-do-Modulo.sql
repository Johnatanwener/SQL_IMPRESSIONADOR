-- MÓDULO 17 - SQL SERVER - Regex - Regular Expressions

/* AULA 01: Regex - Introdução ao módulo
Nesse módulo vamos aprender a utilizar expressões regulares (regular expressions) no SQL.

- O que são Regular Expressions
- COLLATE
- Aplicações

O que é e Para que Servem?
 - A expressão regular (conhecida como regex ou regexp, do inglês regular expression) permiteuma forma de identificar cadeias de caracteres de interesse, como caracteres específicos, palavras ou padrões de caracteres.
 - Em resumo, a expressão regular é uma forma de permitir realizar, de forma simples, operações bastante complexas com strings, que possivelmente exigiriam várias condições para tratar cada caso.
 - O SQL Sever já possui uma opção para tratar casos especiais de textos, por meio do comando LIKE, que já vimos anteriormente. Porém, neste módulo vamos ver diversas aplicações mais avançadas. 
 
 Relembrando o LIKE: O LIKE é um comando especial que nos permite filtrar textos de forma mais personalizada. No exemplo abaixo, estamos filtrando todas as descrições de produto que contenham o texto 'Touchpad'.   */

 
 -- Ex.: Usando o LIKE
 SELECT
	*
FROM DimProduct
WHERE ProductDescription LIKE '%Touchpad%'
-- Neste módulo iremos trabalhar com aplicações e recursos bem mais avançadas que o LIKE.

------------------------------

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

------------------------------

-- AULA 05: LIKE - Case Sensitive

CREATE TABLE Nomes(
ID INT,
Nome VARCHAR(100) COLLATE SQL_Latin1_General_CP1_CS_AS)

INSERT INTO Nomes(ID, Nome)
VALUES
	(1, 'Matheus'), (2, 'Marcela'), (3, 'marcos'), (4, 'MAuricio'), (5, 'Marta'), (6, 'Miranda'), (7, 'Melissa'), (8, 'Lucas'), (9, 'luisa'), (10, 'Pedro')

SELECT * FROM Nomes

-- Case Sensitive (diferenciando maiúsculas de minúsculas)
-- LIKE padrão como aprendemos até agora:
SELECT *
FROM Nomes
--WHERE Nome LIKE 'mar%'
WHERE Nome LIKE 'Mar%'

-- Retorna as linhas onde a primeira letra seja 'm', a segunda seja 'a' e a terceira seja 'r'
SELECT *
FROM Nomes
WHERE Nome LIKE '[m][a][r]%'

-- Retorna as linhas onde a primeira letra seja [M], a segunda seja 'a' e a terceira seja 'r'
SELECT *
FROM Nomes
WHERE Nome LIKE '[M][a][r]%'

-- Retorna as linhas onde a primeira letra seja 'M' ou 'm', e a segunda seja 'A' ou 'a'
SELECT *
FROM Nomes
WHERE Nome LIKE '[M-m][A-a]%'

------------------------------

-- AULA 06: LIKE - Filtrando os primeiros caracteres + Case Sensitive

USE BD_Collation
CREATE TABLE Textos(
ID INT,
Texto VARCHAR(100) COLLATE SQL_Latin1_General_CP1_CS_AS)

INSERT INTO Textos(ID, Texto)
VALUES
	(1, 'Marcos'), (2, 'Excel'), (3, 'leandro'), (4, 'K'), (5, 'X7'), (6, 'l9'), (7, '#M'), (8, '@9'), (9, 'M'), (10, 'RT')

SELECT * FROM Textos

-- Retornando nomes que começam com a letra 'M', 'E' ou 'K'
SELECT *
FROM Textos
WHERE Texto LIKE '[MEK]%'

-- Retornando nomes que possuem apenas 1 caracteres
SELECT *
FROM Textos
WHERE Texto LIKE '[A-z]'

-- Retornando nomes que possuem apenas 2 caracteres
SELECT *
FROM Textos
WHERE Texto LIKE '[A-z][A-z]'

-- Retornando nomes que possuem apenas 2 caracteres: o primeiro uma letra, o segundo um número
SELECT *
FROM Textos
WHERE Texto LIKE '[A-z][0-9]'

------------------------------

-- AULA 07: LIKE - Aplicando filtros mais personalizados
CREATE TABLE Nomes(
ID INT,
Nome VARCHAR(100) COLLATE SQL_Latin1_General_CP1_CS_AS)

INSERT INTO Nomes(ID, Nome)
VALUES
	(1, 'Matheus'), (2, 'Marcela'), (3, 'marcos'), (4, 'MAuricio'), (5, 'Marta'), (6, 'Miranda'), (7, 'Melissa'), (8, 'Lucas'), (9, 'luisa'), (10, 'Pedro')

SELECT * FROM Nomes

-- Retorna os nomes que:
-- 1. Começam com a letra 'M' ou 'm'
-- 2. O segundo caractere pode ser qualquer coisa ('_' é um curinga)
-- 3. O terceiro caractere pode ser a letra 'R' ou a letra 'r'
-- 4. Possui uma quantidade qualquer de caracteres depois do terceiro (por conta do '%')

SELECT *
FROM Nomes
WHERE Nome LIKE '[Mm]_[Rr]%'

------------------------------

-- AULA 08: LIKE - Utilizando o operador de negação
CREATE TABLE Nomes(
ID INT,
Nome VARCHAR(100) COLLATE SQL_Latin1_General_CP1_CS_AS)

INSERT INTO Nomes(ID, Nome)
VALUES
	(1, 'Matheus'), (2, 'Marcela'), (3, 'marcos'), (4, 'MAuricio'), (5, 'Marta'), (6, 'Miranda'), (7, 'Melissa'), (8, 'Lucas'), (9, 'luisa'), (10, 'Pedro')

-- Retorna nomes que não começa com as letras 'L' ou 'l'
SELECT *
FROM Nomes
WHERE Nome LIKE '[^Ll]%'

-- Retorna nomes que começa com qualquer caractere (caractere curinga) e a segunda letra não é um 'E' ou 'e'
SELECT *
FROM Nomes
WHERE Nome LIKE '_[^Ee]%'

------------------------------

-- AULA 09: LIKE - Identificando Caracteres especiais
USE BD_Collation
CREATE TABLE Textos(
ID INT,
Texto VARCHAR(100) COLLATE SQL_Latin1_General_CP1_CS_AS)

INSERT INTO Textos(ID, Texto)
VALUES
	(1, 'Marcos'), (2, 'Excel'), (3, 'leandro'), (4, 'K'), (5, 'X7'), (6, 'l9'), (7, '#M'), (8, '@9'), (9, 'M'), (10, 'RT')

SELECT * FROM Textos

-- Identificando caracteres especiais
SELECT *
FROM Textos
WHERE Texto LIKE '%[^A-z0-9]%'

------------------------------

-- AULA 10: LIKE - Aplicações com Números
USE BD_Collation
CREATE TABLE Numeros(
Numero DECIMAL(20, 2))

INSERT INTO Numeros(Numero)
VALUES
	(50), (30.23), (9), (100.54), (15.9), (6.5), (10), (501.76), (1000.56), (31)

SELECT * FROM Numeros

-- Retornando os números que possuem 2 dígitos na parte inteira
SELECT *
FROM Numeros
WHERE Numero LIKE '[0-9][0-9].[0][0]'

-- Retornando linhas que:
-- 1. Possuem 3 dígitos na parte inteira, sendo o primeiro dígito igual a 5
-- 2. O primeiro número da parte decimal seja 7.
-- 3. O segundo número da parte decimal seja um número entre 0 e 9.

SELECT *
FROM Numeros
WHERE Numero LIKE '[5]__.[7][0-9]'
