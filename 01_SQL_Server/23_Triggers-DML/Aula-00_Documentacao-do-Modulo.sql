-- MÓDULO 23 - SQL SERVER - TRIGGERS DML

/* AULA 01 - Introdução
Nesse módulo vamos aprender sobre triggers DML no SQL.

- O que é uma Trigger DML
- Criando uma Trigger DML
- Evento AFTER
- Evento INSTEAD OF
- Habilitando/Desabilitando Triggers DML
- Excluindo Triggers DML		*/

------------------------------

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

------------------------------

/* AULA 03 - Criando uma Trigger DML - AFTER

- Criando uma TRIGGER DML simples
Essa trigger será disparada após (AFTER) um evento INSERT, UPDATE ou DELETE ser executado na tabela dCliente e imprimirá na tela uma mensagem informando que os dados dessa tabela foram alterados.

Veja o passo a passo:

- 1. Iniciamos a nossa trigger com o comando CREATE OR ALTER TRIGGER e damos um nome a ela;
- 2. Informamos o nome da tabela que fará a trigger ser disparada toda vez que for alterada. No caso, será a dCliente.
- 3. Determinamos se a trigger será do tipo AFTER ou INSTEAD OF e quais comandos que dispararão quando forem executados.
- 4. Iniciamos o bloco de comandos com o comando BEGIN;
- 5. Incluímos todos os comandos que deverão ser executados quando a trigger for disparada. Aqui, apenas um PRINT na tela com a mensagem 'Os dados da tabela dCliente foram alterados!';
- 6. Finalizamos o bloco de comandos com o comando END.

*/
USE Exercicios

CREATE OR ALTER TRIGGER tgClienteAlterado
ON dCliente
AFTER INSERT, UPDATE, DELETE
AS
BEGIN

	PRINT 'Os dados da tabela dCliente foram alterados!'

END


SELECT * FROM dCliente

--  Com a nossa trigger tgClienteAlterado criada, repare que toda vez que efetuarmos um INSERT, UPDATE ou um DELETE na tabela dCliente, aparecerá na tela a mensagem configurada no PRINT.

INSERT INTO dCliente(nome_cliente, genero, data_de_nascimento, cpf)	VALUES
	('Zacarias Neto', 'M', '13/02/1999', '139.543.189-00')

UPDATE dCliente
SET cpf = '130.451.892-10'
WHERE id_cliente = 11

DELETE FROM dCliente
WHERE id_cliente = 11

------------------------------

/* AULA 04 - Tabelas INSERTED e DELETED
- Vamos alterar a trigger anterior para deixá-la mais clara. 

Quando executarmos um comando a mensagem que aparecerá será personalizada para aquele comando. 

INSERT INTO: Os dados foram inseridos na tabela!
UPDATE: Os dados foram atualizados na tabela!
DELETE: Os dados foram excluídos da tabela!

Antes, vamos entender a existência das tabelas INSERTED e DELETED.

No SQL Server, existem duas tabelas pré-configuradas, chamadas INSERTED e DELETED que, todas as vezes que efetuamos um comando DML (INSERT, UPDATE ou DELETE) elas recebem os dados que foram inseridos, atualizados ou excluídos, a depender do comando que foi utilizado.

Exemplos: 
*/

SELECT * FROM dCliente

-- INSERT
-- Ao invés de mostrar na tela a mensagem genérica que os dados foram inseridos, mostrar os próprios dados que foram inseridos na tabela;
CREATE OR ALTER TRIGGER tgClienteAlterado
ON dCliente
AFTER INSERT
AS
BEGIN
	SELECT * FROM INSERTED
		-- PRINT 'Os dados da tabela dCliente foram alterados!'
END

-- Repare que no bloco de comandos, no lugar do comando PRINT, inserimos o SELECT * FROM INSERTED. Com essa alteração na nossa trigger, se efetuarmos o INSERT abaixo, repare que o resultado mostrado serão os próprios dados que foram inseridos na tabela dCliente, ao invés da mensagem que tínhamos.

INSERT INTO dCliente(nome_cliente, genero, data_de_nascimento, cpf)	VALUES
	('Zacarias Neto', 'M', '13/02/1999', '139.543.189-00')

-- Isso aconteceu porque, toda vez que inserimos um dado em alguma tabela, esse registro também fica temporariamente armazenado na tabela INSERTED. Como incluímos um SELECT a essa tabela (INSERTED) no bloco de comandos da trigger tgClienteAlterado, quando disparada, ela mostrou como resultado o registo que a tabela INSERTED acabou de temporariamente armazenar.


-- DELETE
-- Ao invés de mostrar na tela a mensagem genérica que os dados foram alterados, mostrar os próprios dados que foram deletados na tabela;
CREATE OR ALTER TRIGGER tgClienteAlterado
ON dCliente
AFTER DELETE
AS
BEGIN
	SELECT * FROM DELETED
		-- PRINT 'Os dados da tabela dCliente foram alterados!'
END

-- Repare que agora, no bloco de comandos, inserimos um SELECT * FROM DELETED. Com essa alteração na nossa trigger, se efetuarmos o DELETE abaixo, repare que o resultado serão os próprios dados que foram excluídos na tabela dCliente.

DELETE FROM dCliente
WHERE id_cliente = 12

-- Isso aconteceu porque, toda vez que excluímos algum dado de uma tabela, esse registro também fica temporariamente armazenado na tabela DELETED. Como incluímos um SELECT a essa tabela (DELETED) no bloco de comandos da trigger tgClienteAlterado, quando disparada, ela mostrou como resultado o registro que a tabela DELETED acabou de temporariamente armazenar.


-- UPDATE
-- Ja parou para pensar que, quando atualizamos uma tabela, temos dois registros? O novo que foi inserido na tabela, e o antigo que foi excluído da tabela para dar lugar ao novo. Com isso em mente, vamos imaginar que queremos, por fim, alterar a trigger tgClienteAlterado para, a partir de agora, apresentar na tela os dados que foram inseridos na tabela dCliente e os que foram excluídos da tabela dCliente toda vez que executamos um UPDATE.

CREATE OR ALTER TRIGGER tgClienteAlterado
ON dCliente
AFTER UPDATE
AS
BEGIN
	SELECT * FROM INSERTED
	SELECT * FROM DELETED
		-- PRINT 'Os dados da tabela dCliente foram alterados!'
END

-- Repare que agora, no bloco de comandos, inserimos duas consultas: um SELECT * FROM INSERTED (para retornar o novo registo) e um SELECT * FROM DELETED (para retornar o registro que foi excluído). Vamos inserir novamente o registro que excluímos no último exemplo para podermos, posteriormente, atualizá-los.

INSERT INTO dCliente(nome_cliente, genero, data_de_nascimento, cpf)	VALUES
	('Zacarias Neto', 'M', '13/02/1999', '139.543.189-00')

-- Agora, note que, com a alteração na nossa trigger, se efetuarmos o UPDATE abaixo, o resultado será o registro que foi incluído na tabela dCliente e também o que foi excluído da tabela dCliente.

UPDATE dCliente
SET cpf = '130.451.892-10'
WHERE id_cliente = 13

/* Isso aconteceu porque, toda vez que atualizamos algum dado de uma tabela, o novo registro também fica temporariamente armazenado na tabela INSERTED, enquanto que o antigo registo (que foi excluído) fica temporariamente armazenado na tabela DELETED. Como incluímos um SELECT tanto à tabela INSERTED quanto à tabela DELETED no bloco de comandos da trigger tgClienteAlterado, quando disparada, ela mostrou como resultado os registros que as tabelas INSERTED e DELETED acabaram de temporariamente armazenar.

Portando, em resumo, podemos concluir que:

- Se a trigger for de INSERT, a INSERTED terá registros e a DELETED ficará vazia;
- Se a trigger for de DELETE, a INSERTED ficará vazia e a DELETED terá registros;
- Se a trigger for de UPDATE, a INSERTED e a DELETED terão registros;
*/

------------------------------

/* AULA 05 - Identificando na Trigger o Evento DML Relacionado
Sabendo agora, como funcionam as tabelas INSERTED e DELETED, podemos finalmente personalizar as mensagens apresentadas na tela, de acordo com o comando DML utilizado, quando a tabela dCliente for alterada e a nossa trigger tgClienteAlterado disparada.

Relembrando, quando dispararmos o comando... será apresentado na tela a mensagem...
INSERT INTO: Os dados foram inseridos na tabela!
UPDATE: Os dados foram atualizados na tabela!
DELETE: Os dados foram excluídos da tabela!
*/

CREATE OR ALTER TRIGGER tgClienteAlterado
ON dCliente
AFTER INSERT, UPDATE, DELETE
AS
BEGIN

	IF EXISTS (SELECT * FROM INSERTED) AND EXISTS (SELECT * FROM DELETED)
			PRINT 'Dados Foram Atualizados na Tabela'
	ELSE IF EXISTS (SELECT * FROM INSERTED)
            PRINT 'Dados Foram Inseridos na Tabela'
    ELSE IF EXISTS (SELECT * FROM DELETED)
            PRINT 'Dados Foram Excluidos na Tabela'

END

/* vamos entender o funcionamento;
- 1. Iniciamos a nossa trigger com o comando CREATE OR ALTER TRIGGER e damos um nome a ela;
- 2. Informamos o nome da tabela que fará a trigger ser disparada toda vez que for alterada. No caso, será a dCliente;
- 3. Determinamos se a trigger será do tipo AFTER ou INSTEAD OF (no caso, será do tipo AFTER, pois queremos que ela dispare depois que uma alteração for efetuada) e quais serão os comandos que a dispararão quando forem executados. No caso, será depois dos três comando DML: INSERT, UPDATE e DELETE	  
- 4. Iniciamos o bloco de comandos com o comando BEGIN;
- 5. Dentro do bloco de comandos, fazemos um IF EXISTS, para verificar se, após executado um dos comando DML (INSERT, UPDATE ou DELETE), há dados tanto na tabela INSERTED quando na DELETED; e se houver, significa que o comando DML utilizado foi um UPDATE, já que, conforme vimos, o UPDATE é o único comando que insere dados em ambas tabelas temporárias. Sendo um UPDATE, aparecerá na tela a mensagem 'Os dados foram atualizados na tabela!';
- 6. Se no IF acima for verificado que ou a INSERTED ou a DELETED está vazia, significa que o comando DML utilizado não foi um UPDATE, então, prosseguimos para a próxima linha do código e verificamos no primeiro ELSE IF EXISTS, se há dados na tabela INSERTED; se houver, significa que o comando DML utilizado foi um INSERTED, portando, imprimimos na tela a mensagem 'Os dados foram inseridos na tabela!'; 
- 7. Caso contrário, ou seja, se a tabela INSERTED estiver vazia, fazemos a última verificação para saber se há dados na tabela DELETED, se houver, significa que o comando DML utilizado foi um DELETE, portanto, imprimimos na tela que 'Os dados foram excluídos da tabela!'.
- 8. Finalizamos o bloco de comandos com o comando END.	

Vamos testar agora um comando DML por vez.	*/

-- INSERT
INSERT INTO dCliente(nome_cliente, genero, data_de_nascimento, cpf)	VALUES
	('Eleonora Batista', 'F', '13/02/2003', '453.543.189-00')

SELECT * FROM dCliente

-- DELETE
DELETE FROM dCliente
WHERE id_cliente = 14

-- UPDATE
UPDATE dCliente
SET cpf = '678.333.111-11'
WHERE id_cliente = 1

------------------------------

/* AULA 06 - Criando uma Trigger para Controle de Permissão de Cadastro - INSTEAD OF (Parte 1)
Vamos ver agora a criação de uma Trigger DML do tipo INSTEAD OF. Este tipo de trigger efetua alguma ação no lugar do comando DML especificado, toda vez que uma determinada condição for atendida.

No nosso exemplo, vamos imaginar que queremos permitir à inserção de dados na tabela dCliente apenas de segunda à sexta. Se for sábado ou domingo, nossa trigger deve gerar um erro, apresentá-lo na tela e não permitir a inserção dos novos dados. Porém, se for dia útil, a trigger deve permitir a inserção dos novos dados na tabela dCliente normalmente.

Vamos ao passo a passo:
- 1. Iniciamos a noss trigger com o comando CREATE OR ALTER TRIGGER e damos um nome a ela;
- 2. Informamos o nome da tabela que fará a trigger ser disparada quando for alterada. No caso, será a dCliente;
- 3. Determinamos se a trigger será do tipo AFTER ou INSTEAD OF (no caso, será do tipo INSTEAD OF, pois queremos que ela informe um erro no lugar do INSERT, não permitindo que ele seja efetuado, caso o usuário tente inserir novos dados na tabela dCliente no final de semana;
- 4. Iniciamos o bloco de comandos com o comando BEGIN;
- 5. Dentro do bloco de comandos, executamos um IF para verificar se o dia de hoje (GETDATE()) é sábado ou domingo;
- 6. Se for, utilizamos a instrução RAISERROR para exibir um erro na tela com a seguinte mensagem: 'O cadastro de clientes só pode ser feito de segunda à sexta feira, e efetuamos um ROLLBACK para que o INSERT efetuado seja desfeito;
- 7. Se não for final de semana, efetuamos o INSERT desejado na tabela dCliente. Observe que os dados a serem inseridos na tabela dCliente serão extraídos da tabela INSERTED, que armazenou temporariamente o registo incluído pelo usuário;
- 8. Finalizamos o bloco de comando com o comando END.

- Crie uma Trigger que seja disparada sempre INSTEAD OF de um INSERT, UPDATE e DELETE que for executado na tabela dCliente. O que deve acontecer: se o dia de cadastro for sábado ou domingo, não pode deixar alterar pois está fora do horário comercial. */

-- Se for sábado ou domingo retorne o erro.
CREATE OR ALTER TRIGGER tgControleRegistros
ON dCliente
INSTEAD OF INSERT
AS
BEGIN

	IF FORMAT(GETDATE(), 'dddd') IN ('sábado', 'domingo') -- Pode usar OR ou IN
	BEGIN

		RAISERROR('O cadastro de clientes só pode ser feito de segunda à sexta', 1, 1) -- Emitir um erro forçado
		ROLLBACK
	END
END

-- Testemos agora a nossa trigger tgControleRegistros, tentando efetuar o seguinte INSERT na tabela dCliente; Se for final de semana (sábado ou domingo), repare que a trigger disparada retornará o erro configurado, conforme esperado; Porém, se caso hoje não seja sábado ou domingo, será executado o INSERT e os dados serão normalmente inseridos na tabela.

INSERT INTO dCliente(nome_cliente, genero, data_de_nascimento, cpf)	VALUES
	('Pedro Albuquerque', 'M', '13/02/2003', '111.543.189-00')


-- Se for domingo, retorne o erro
CREATE OR ALTER TRIGGER tgControleRegistros
ON dCliente
INSTEAD OF INSERT
AS
BEGIN

	IF FORMAT(GETDATE(), 'dddd') IN ('domingo') -- Pode usar OR ou IN
	BEGIN

		RAISERROR('O cadastro de clientes só pode ser feito de segunda à sexta', 1, 1) -- Emitir um erro forçado
		ROLLBACK
	END
END

INSERT INTO dCliente(nome_cliente, genero, data_de_nascimento, cpf)	VALUES
	('Pedro Albuquerque', 'M', '13/02/2003', '111.543.189-00')

SELECT * FROM dCliente
-- Obs.: Não ocorreu um erro pois 'hoje' é sábado porém, não foi inserido nenhuma linha pois em nosso código não foi informado o que tem que ocorrer se o dia for diferente de domingo.

------------------------------

-- AULA 07 - Criando uma Trigger para Controle de Permissão de Cadastro - INSTEAD OF (Parte 2)

CREATE OR ALTER TRIGGER tgControleRegistros
ON dCliente
INSTEAD OF INSERT
AS
BEGIN

	IF FORMAT(GETDATE(), 'dddd') IN ('domingo') -- Pode usar OR ou IN
	BEGIN

		RAISERROR('O cadastro de clientes só pode ser feito de segunda à sexta', 1, 1) -- Emitir um erro forçado
		ROLLBACK

	END
	ELSE
	BEGIN

	INSERT INTO dCliente(nome_cliente, genero, data_de_nascimento, cpf)
	SELECT i.nome_cliente, i.genero, i.data_de_nascimento, i.cpf FROM INSERTED i

	END
END

INSERT INTO dCliente(nome_cliente, genero, data_de_nascimento, cpf)	VALUES
	('Lucio Dantas', 'M', '13/02/2003', '111.222.333-00')

-- Obs.¹: Agora sim, os dados dos clientes foram inseridos na tabela.
-- Obs.²: Na mensagem aparecerá a mensagem 'Dados Foram Inseridos na Tabela' pois nos exemplos anteriores, foi criar uma Trigger que verificava se era um INSERTED, DELETED ou UPDATE e inserido este PRINT como resultado.

SELECT * FROM dCliente

------------------------------

/* AULA 08 - Habilitando, Desabilitando e Excluindo uma Trigger
Além de, podermos excluir uma TRIGGER DML, também temos a opção de apenas desabilitá-la. Desta forma, ela continua salva no banco de dados porém, deixa de ser disparada. Se porventura precisarmos, podemos habilitá-la novamente. */

-- Para desabilitar uma trigger DML, utilizamos o comando DISABLE:
DISABLE TRIGGER nome_da_trigger ON nome_da_tabela

-- Para habilitar uma trigger DML novamente, utilizamos o comando ENABLE:
ENABLE TRIGGER nome_da_trigger ON nome_da_tabea

-- Para desabilitar todas as trigger DML de uma tabela utilizamos a seguinte sintaxxe:
DISABLE TRIGGER ALL ON nome_da_tabela

-- Para habilitar novamente todas as trigger DML de uma tabela utilizamos a seguinte sintaxe:
ENABLE TRIGGER ALL ON nome_da_tabela

-- Por fim, para excluir uma trigger DML, utilizamos a sintaxe:
DROP TRIGGER nome_da_trigger

-- Desabilitando e Habilitando a Trigger DML tgControleRegistros
DISABLE TRIGGER tgControleRegistros ON dCliente -- Desabilitando uma Trigger específica
ENABLE TRIGGER tgControleRegistros ON dCliente -- Habilitando uma Trigger específica


-- Desabilitando e Habilitando TODAS as Triggers DML da tabela dCliente
DISABLE TRIGGER ALL ON dCliente -- Desabilitando TODAS as Triggers
ENABLE TRIGGER ALL ON dCliente -- Habilitando TODAS as Triggers

-- Excluindo a Trigger DML tgControleRegistros
DROP TRIGGER tgControleRegistros;