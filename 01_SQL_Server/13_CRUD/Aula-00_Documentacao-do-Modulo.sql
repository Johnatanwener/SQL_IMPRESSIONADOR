-- M�DULO 13 - SQL SERVER - CRUD


/* AULA 01 - Introdu��o ao M�dulo
Nesse m�dulo vamos aprender a criar banco de dados e tabelas dentro do SQL Server

- O que � CRUD?
- CREATE/DROP DATABASE
- CREATE TABLE
- INSERT SELECT
- INSERT INTO
- UPDATE
- DELETE
- DROP TABLE
- ALTER TABLE */

------------------------------

/* AULA 02 - O que � CRUD?
Opera��es CRUD s�o opera��es que conseguimos fazer em um Banco de Dados. Essa sigla significa:

C > CREATE	- Permite criar Banco de Dados, Tabelas ou Exibi��es (Views)
R > READ	- Permite ler os dados do banco de dados. Basicamente foi o que mais fizemos no Curso, atrav�s do SELECT
U > UPDATE	- Permite atualizar os dados do banco de dados, tabelas ou views. 
D > UELETE	- Permite deletar dados de um banco de dados, tabelas ou views.

Com os comandos acima, conseguimos Criar, Ler, Atualizar e Deletar dados do nosso Banco de Dados. 

Lembrando:
- Um banco de dados � composto por um conjunto de tabelas (exemplo Contoso)
- As tabelas armazenam dados em linhas e colunas.
- Uma linha abrange v�rias colunas que juntas descrevem alguma caracter�stica de um objeto. Desta forma, uma coluna � como se fosse uma categoria.
- Portando, cada objeto (registro/record) possui caracter�sticas que pertencem a essas categorias. 

- Um Banco de Dados ser� usado para guardar todas as tabelas criadas. E � importante entender que as tabelas de um banco de dados precisam ter algum tipo de rela��o.

- Para criar um Banco de Dados existem 2 formas.
1. Manualmente, atrav�s do menu "Pesquisador de Objetos" clicando com o bot�o direito do mouse em cima de Banco de Dados e em seguida Novo Banco de Dados...
2. Usando o SQL, atrav�s do comando CREATE DATABASE, seguido do nome que quer dar ao banco de dados.

- Para deletar um Banco de Dados existem 2 formas.
1. Manualmente, atrav�s do menu "Pesquisador de Objetos" clicando com o bot�o direito do mouse em cima do nome do Banco de Dados e em seguida Excluir.
2. Usando o SQL, atrav�s do comando DROP DATABASE, seguido do nome do banco de dados que quer excluir.

Obs: Sempre que fizer uma altera��o no Banco de Dados ou sempre que criar ou excluir um Banco de Dados, n�o esque�a de clicar em atualizar no menu "Pesquisador de Objetos" */

------------------------------

/* AULA 03 - CREATE e DROP DATABASE
Criando e deletando nosso primeiro Banco de Dados */

CREATE DATABASE Teste --  Criando o Banco de Dados
DROP DATABASE Teste -- Excluindo o Banco de Dados

CREATE DATABASE BDImpressionador

------------------------------

/* AULA 04 - CRUD em Tabelas - Como criar uma Tabela

Observa��es:
1. Cada coluna da tabela que criarmos ter� sempre o mesmo tipo de informa��o.
2. Para adicionar uma informa��o em nossa tabela, adicionaremos uma nova linha.
3. Cada coluna ter� um �nico tipo de dado. Ou seja, na coluna de ID, sempre teremos um n�mero; na coluna de Nome, sempre teremos textos; na coluna de data, sempre teremos datas; etc.
4. Para as tabelas, utilizaremos as opera��es CRUD da seguinte maneira: 
	1: Utilizaremos o comando CREATE TABLE para criar tabelas, da seguinte forma: DROP TABLE, seguido do nome da tabela e entre parenteses os nomes das colunas da nossa tabela e o tipo de dado de cada tabela, exemplo: */
CREATE TABLE nome_tabela(
	coluna1 TIPO1,
	coluna2 TIPO2,
	coluna3 TIPO3,
	coluna4 TIPO4
)

--	2: Utilizaremos o comando INSERT INTO para inserir informa��es na tabela, da seguinte forma: INSERT INTO, seguido do nome da tabela e entre parenteses o nome das colunas, seguido do comando VALUES e dentro deste comando entre parenteses as informa��es em cada linha da tabela, exemplo: */
INSERT INTO nome_tabela (coluna1, coluna2, coluna3, coluna4)
VALUES
	(1, 'Arroz', '2021-12-31', 22.50),
	(2, 'Feij�o', '2021-12-31', 8.99)

--	3: Utilizaremos o comando UPDATE para atualizar informa��es na tabela da seguinte forma:
UPDATE Produtos
SET nome_produto = 'Macarr�o'
WHERE id_produto = 3

--	4: Utilizaremos o comando DELETE para deletar dados em nossa tabela da seguinte forma:
DELETE
FROM nome_tabela
WHERE id_produto = 3

--	5: Utilizaremos o comando DROP TABLE para deletar toda a nossa tabela, exemplo:
DROP TABLE Produtos 


------------------------------

/* AULA 05 - Cuidado antes de criar uma Tabela em um Banco de Dados
Antes de criar uma tabela em um banco de dados � importante verificar se o banco de dados correto est� selecionado, para que n�o ocorra o equ�voco de criar a tabela no banco de dados errado.
Para isso basta alterar o banco de dados, manualmente na sele��o de banco de dados ou usando o comando USE seguido do nome do banco de dados que quer utilizar, exemplo:

USE NomeDoBancoDeDados */

------------------------------

/* AULA 06 - CREATE TABLE - Criando a primeira tabela
Utilize o comando CREATE TABLE para criar uma Tabela.

1. Crie uma tabela chamada 'Produtos'
2. Essa abela deve conter 4 colunas: id_produt, nome_produto, data_validade e preco_produto
3. Certifique-se de que o tipo das colunas est� correto. */

USE BDImpressionador

CREATE TABLE Produtos(
	id_produto INT,
	nome_produto VARCHAR(MAX),
	data_validade DATETIME,
	preco_produto FLOAT
)

SELECT * FROM Produtos

------------------------------

/* AULA 07 - INSERT SELECT - Adicionando dados de outra tabela
Com o comando INSERT INTO SELECT � poss�vel adicionar dados de um outro banco de dados � nossa tabela rec�m criada. */

-- Adicionando valores de outra tabela.
INSERT INTO Produtos(id_produto, nome_produto, data_validade, preco_produto)
SELECT
	ProductKey,
	ProductName,
	AvailableForSaleDate,
	UnitPrice
FROM
	ContosoRetailDW.dbo.DimProduct

SELECT * FROM Produtos

------------------------------

/* AULA 08 - INSERT INTO - Adicionando novos valores na tabela
Uutilize o comando INSERT INTO para aicionar novos valores � tabela.

Obs.: N�o faz diferen�a a ordem em que os valores s�o adicionados dentro do comando VALUES, desde que, essa ordem respeite a ordem das colunas dentro do par�nteses, logo ap�s o nome da tabela. */

INSERT INTO Produtos(id_produto, nome_produto, data_validade, preco_produto)
VALUES
	(1, 'Arroz', '31/12/2021', 22.50),
	(2, 'Feij�o', '20/11/2022', 8.99)

SELECT * FROM Produtos

------------------------------

-- AULA 09 - Ordem correta para adicionar dados com o INSERT
-- Pergunta: Ser� que faz diferen�a adicionar um novo dado com a ordem das colunas invertida?
-- Resposta: N�o haver� problema desde que, na hora de informar os valores eu respeite a ordem que foi colocada no comando INSERT
-- 1. Ordem utilizada anteriorment: (id_produto, nome_produto, data_validade, preco_produto)
-- 2. Ordem que ser� utilizada: (data_validade, id_produto, preco_produto)
INSERT INTO Produtos(data_validade, id_produto, preco_produto)
VALUES
	('31/05/2023', 3, 33.99)

-- Obs.: Uma nova linha foi adicionada de forma correta por�m, como n�o foi informada a informa��o de 'nome do produto', esse valor ser� interpretado como NULL

SELECT * FROM Produtos

------------------------------

/* AULA 10 - UPDATE - Atualizando o dado de uma tabela
Utilize o comando UPDATE para atualizar um dado dentro de uma tabela. O comando WHERE ser� fundamental para que a gente possa especificar ecatamente qual � o ID que queremos alterar. */

UPDATE Produtos
SET nome_produto = 'Macarr�o'
WHERE id_produto = 3

-- Obs.: Agora, a informa��o de 'nome do produto' que antes estava como NULL ser� preenchida com a informa��o 'Macarr�o' informada nessa consulta.

SELECT * FROM Produtos

------------------------------

/* AULA 11 - DELETE - Deletando dados
Utilize o comando DELETE para deletar um dado dentro de uma tabela. O comando WHERE ser� fundamental para que a gente possa especificar exatamente qual � o id que queremos deletar. */

DELETE
FROM Produtos
WHERE id_produto = 3

-- Obs.: Agora, a informa��o da tabela referente a linha onde o id_produto for igual a 3 foi deletada.

SELECT * FROM Produtos

------------------------------

/* AULA 12 - DROP TABLE - Excluindo uma tabela

Existe 2 formas de excluir uma tabela.
1. Navegando at� o menu 'Pesquisador de Objetos' > selecionando o banco de dados onde est� a tabela que quer excluir > tabelas >  clique com o bot�o direito do mouse na tabela e excluir.
2. Utilizando o comando DROP TABLE */

DROP TABLE Produtos

------------------------------

/* AULA 13 - C�digo da tabela utilizada nos pr�ximos exemplos
Utilize o c�digo abaixo para criar uma tabela exemplo de Funcion�rios. Essa tabela ser� usada para as pr�ximas aplica��es, onde veremos como alterar colunas de uma tabela. */

USE BDImpressionador

CREATE TABLE Funcionarios(
	id_funcionario int,
	nome_funcionario varchar(100),
	salario float,
	data_nascimento date
)

INSERT INTO Funcionarios(id_funcionario, nome_funcionario, salario, data_nascimento)
VALUES
	(1, 'Lucas'		, 1500, '20/03/1990'),
	(2, 'Andressa'	, 2300, '07/12/1988'),
	(3, 'Felipe'	, 4000, '13/02/1993'),
	(4, 'Marcelo'	, 7100, '10/04/1993'),
	(5, 'Carla'		, 3200, '02/09/1986'),
	(6, 'Juliana'	, 5500, '21/01/1989'),
	(7, 'Mateus'	, 1900, '02/11/1993'),
	(8, 'Sandra'	, 3900, '09/05/1990'),
	(9, 'Andr�'		, 1000, '13/03/1994'),
	(10, 'Julio'	, 4700, '05/07/1992')

SELECT * FROM Funcionarios

------------------------------

/* AULA 14 - ALTER TABLE - Adicionar, deletar ou modificar o tipo de dados de uma coluna
Para adicionar uma nova coluna na tabela, utilizamos o comando ALTER TABLE em conjutndo com o comando ADD.
Em seguida, utilizamos o comando UPDATE em conjunto com o comando WHERE para atualizar os valores dessa coluna. */

-- Adicionar coluna:
ALTER TABLE Funcionarios
ADD cargo varchar(100), bonus decimal(10,2)

UPDATE Funcionarios
SET cargo = 'Analista', bonus = 0.15
WHERE id_funcionario = 1

SELECT * FROM Funcionarios

-- Alterar tipo de dados de uma coluna:
ALTER TABLE Funcionarios
ALTER COLUMN salario int

-- Deletar coluna:
ALTER TABLE Funcionarios
DROP COLUMN cargo, bonus

------------------------------

-- AULA 15 - Explica��o Exerc�cios
-- AULA 16 - Resolu��o Exerc�cio 01
-- AULA 17 - Resolu��o Exerc�cio 02
-- AULA 18 - Resolu��o Exerc�cio 03
-- AULA 19 - Resolu��o Exerc�cio 04
-- AULA 20 - Resolu��o Exerc�cio 05
-- AULA 21 - Resolu��o Exerc�cio 06