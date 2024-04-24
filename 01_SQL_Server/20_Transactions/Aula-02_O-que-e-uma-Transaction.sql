-- MODULO 20 - SQL SERVER - TRANSACTIONS


/* AULA 02 - O que e uma Transaction

1. O que � uma transaction?
Uma TRANSACTION � uma a��o realizada dentro do banco de dados. Essa a��o pode ser uma: atualiza��o (UPDATE), inser��o (INSERT INTO) ou exclus�o (DELETE) de dados do banco. Precisamos de transa��es quando estamos alterando o banco de dados de alguma forma, seja inserindo, atualizando ou excluindo dados.

Normalmente, n�o temos muito "controle" sobre transa��es, a menos que a gente explicite no nosso c�digo que queremos fazer isso. Assim, a ideia de uma transa��o � agrupar um conjunto de instru��es a serem executadas no banco de dados, e ter a flexibilidade de:

a. Se algo der errado, desfazer aquela transa��o
b. Se tudo der certo, salvar aquela transa��o

At� agora vimos como inserir, alterar e excluir dados no banco de dados com comandos como estes abaixo: */

SELECT *
INTO cliente_aux
FROM dCliente

-- 1. Adicionamos novas linhas (registros) na tabela
INSERT INTO cliente_aux(nome_cliente, genero, data_de_nascimento, cpf) VALUES
	('Maria Julia', 'F', '30/04/1995', '987.654.321-00')


-- 2. Atualizamos linhas (registros) da tabela
UPDATE cliente_aux
	SET nome_cliente = LOWER(nome_cliente)


-- 3. Excluimos linhas (registros) da tabela
DELETE FROM dCliente
	WHERE id_cliente = 1


/* Quando executamos as a��es acima, desta forma, n�o temos controle sobre desfaz�-las ou salv�-las no banco de dados, pois as transa��es efetuadas est�o impl�citas (n�o declaradas). Mas, quando usamos transa��es expl�citas, conseguimos controlar melhor essas a��es.

E este controle � poss�vel por meio dos comandos:

BEGIN TRANSACTION		- Com ele informamos ao sistema que estamos iniciando uma transa��o;
ROLLBACK TRANSACTION	- Comando TCL que usamos para desfazer uma transa��o no banco;
COMMIT (TRANSACTION)	- Comando TCL por meio do qual salvamos uma transa��o no banco;
*/