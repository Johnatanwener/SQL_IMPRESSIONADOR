-- MÓDULO 13 - SQL SERVER - CRUD


/* AULA 04 - CRUD em Tabelas - Como criar uma Tabela

Observações:
1. Cada coluna da tabela que criarmos terá sempre o mesmo tipo de informação.
2. Para adicionar uma informação em nossa tabela, adicionaremos uma nova linha.
3. Cada coluna terá um único tipo de dado. Ou seja, na coluna de ID, sempre teremos um número; na coluna de Nome, sempre teremos textos; na coluna de data, sempre teremos datas; etc.
4. Para as tabelas, utilizaremos as operações CRUD da seguinte maneira: 
	1: Utilizaremos o comando CREATE TABLE para criar tabelas, da seguinte forma: DROP TABLE, seguido do nome da tabela e entre parenteses os nomes das colunas da nossa tabela e o tipo de dado de cada tabela, exemplo: */
CREATE TABLE nome_tabela(
	coluna1 TIPO1,
	coluna2 TIPO2,
	coluna3 TIPO3,
	coluna4 TIPO4
)

--	2: Utilizaremos o comando INSERT INTO para inserir informações na tabela, da seguinte forma: INSERT INTO, seguido do nome da tabela e entre parenteses o nome das colunas, seguido do comando VALUES e dentro deste comando entre parenteses as informações em cada linha da tabela, exemplo: */
INSERT INTO nome_tabela (coluna1, coluna2, coluna3, coluna4)
VALUES
	(1, 'Arroz', '2021-12-31', 22.50),
	(2, 'Feijão', '2021-12-31', 8.99)

--	3: Utilizaremos o comando UPDATE para atualizar informações na tabela da seguinte forma:
UPDATE Produtos
SET nome_produto = 'Macarrão'
WHERE id_produto = 3

--	4: Utilizaremos o comando DELETE para deletar dados em nossa tabela da seguinte forma:
DELETE
FROM nome_tabela
WHERE id_produto = 3

--	5: Utilizaremos o comando DROP TABLE para deletar toda a nossa tabela, exemplo:
DROP TABLE Produtos

------------------------------

/* AULA 05 - Cuidado antes de criar uma Tabela em um Banco de Dados
Antes de criar uma tabela em um banco de dados é importante verificar se o banco de dados correto está selecionado, para que não ocorra o equívoco de criar a tabela no banco de dados errado.
Para isso basta alterar o banco de dados, manualmente na seleção de banco de dados ou usando o comando USE seguido do nome do banco de dados que quer utilizar, exemplo:

USE NomeDoBancoDeDados */