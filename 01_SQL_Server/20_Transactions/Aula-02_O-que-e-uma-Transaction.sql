-- MODULO 20 - SQL SERVER - TRANSACTIONS


/* AULA 02 - O que e uma Transaction

1. O que é uma transaction?
Uma TRANSACTION é uma ação realizada dentro do banco de dados. Essa ação pode ser uma: atualização (UPDATE), inserção (INSERT INTO) ou exclusão (DELETE) de dados do banco. Precisamos de transações quando estamos alterando o banco de dados de alguma forma, seja inserindo, atualizando ou excluindo dados.

Normalmente, não temos muito "controle" sobre transações, a menos que a gente explicite no nosso código que queremos fazer isso. Assim, a ideia de uma transação é agrupar um conjunto de instruções a serem executadas no banco de dados, e ter a flexibilidade de:

a. Se algo der errado, desfazer aquela transação
b. Se tudo der certo, salvar aquela transação

Até agora vimos como inserir, alterar e excluir dados no banco de dados com comandos como estes abaixo: */

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


/* Quando executamos as ações acima, desta forma, não temos controle sobre desfazê-las ou salvá-las no banco de dados, pois as transações efetuadas estão implícitas (não declaradas). Mas, quando usamos transações explícitas, conseguimos controlar melhor essas ações.

E este controle é possível por meio dos comandos:

BEGIN TRANSACTION		- Com ele informamos ao sistema que estamos iniciando uma transação;
ROLLBACK TRANSACTION	- Comando TCL que usamos para desfazer uma transação no banco;
COMMIT (TRANSACTION)	- Comando TCL por meio do qual salvamos uma transação no banco;
*/