-- M�DULO 23 - SQL SERVER - TRIGGERS DML

/* AULA 01 - Introdu��o
Nesse m�dulo vamos aprender sobre triggers DML no SQL.

- O que � uma Trigger DML
- Criando uma Trigger DML
- Evento AFTER
- Evento INSTEAD OF
- Habilitando/Desabilitando Triggers DML
- Excluindo Triggers DML		*/

------------------------------

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

------------------------------

/* AULA 03 - Criando uma Trigger DML - AFTER

- Criando uma TRIGGER DML simples
Essa trigger ser� disparada ap�s (AFTER) um evento INSERT, UPDATE ou DELETE ser executado na tabela dCliente e imprimir� na tela uma mensagem informando que os dados dessa tabela foram alterados.

Veja o passo a passo:

- 1. Iniciamos a nossa trigger com o comando CREATE OR ALTER TRIGGER e damos um nome a ela;
- 2. Informamos o nome da tabela que far� a trigger ser disparada toda vez que for alterada. No caso, ser� a dCliente.
- 3. Determinamos se a trigger ser� do tipo AFTER ou INSTEAD OF e quais comandos que disparar�o quando forem executados.
- 4. Iniciamos o bloco de comandos com o comando BEGIN;
- 5. Inclu�mos todos os comandos que dever�o ser executados quando a trigger for disparada. Aqui, apenas um PRINT na tela com a mensagem 'Os dados da tabela dCliente foram alterados!';
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

--  Com a nossa trigger tgClienteAlterado criada, repare que toda vez que efetuarmos um INSERT, UPDATE ou um DELETE na tabela dCliente, aparecer� na tela a mensagem configurada no PRINT.

INSERT INTO dCliente(nome_cliente, genero, data_de_nascimento, cpf)	VALUES
	('Zacarias Neto', 'M', '13/02/1999', '139.543.189-00')

UPDATE dCliente
SET cpf = '130.451.892-10'
WHERE id_cliente = 11

DELETE FROM dCliente
WHERE id_cliente = 11

------------------------------

/* AULA 04 - Tabelas INSERTED e DELETED
- Vamos alterar a trigger anterior para deix�-la mais clara. 

Quando executarmos um comando a mensagem que aparecer� ser� personalizada para aquele comando. 

INSERT INTO: Os dados foram inseridos na tabela!
UPDATE: Os dados foram atualizados na tabela!
DELETE: Os dados foram exclu�dos da tabela!

Antes, vamos entender a exist�ncia das tabelas INSERTED e DELETED.

No SQL Server, existem duas tabelas pr�-configuradas, chamadas INSERTED e DELETED que, todas as vezes que efetuamos um comando DML (INSERT, UPDATE ou DELETE) elas recebem os dados que foram inseridos, atualizados ou exclu�dos, a depender do comando que foi utilizado.

Exemplos: 
*/

SELECT * FROM dCliente

-- INSERT
-- Ao inv�s de mostrar na tela a mensagem gen�rica que os dados foram inseridos, mostrar os pr�prios dados que foram inseridos na tabela;
CREATE OR ALTER TRIGGER tgClienteAlterado
ON dCliente
AFTER INSERT
AS
BEGIN
	SELECT * FROM INSERTED
		-- PRINT 'Os dados da tabela dCliente foram alterados!'
END

-- Repare que no bloco de comandos, no lugar do comando PRINT, inserimos o SELECT * FROM INSERTED. Com essa altera��o na nossa trigger, se efetuarmos o INSERT abaixo, repare que o resultado mostrado ser�o os pr�prios dados que foram inseridos na tabela dCliente, ao inv�s da mensagem que t�nhamos.

INSERT INTO dCliente(nome_cliente, genero, data_de_nascimento, cpf)	VALUES
	('Zacarias Neto', 'M', '13/02/1999', '139.543.189-00')

-- Isso aconteceu porque, toda vez que inserimos um dado em alguma tabela, esse registro tamb�m fica temporariamente armazenado na tabela INSERTED. Como inclu�mos um SELECT a essa tabela (INSERTED) no bloco de comandos da trigger tgClienteAlterado, quando disparada, ela mostrou como resultado o registo que a tabela INSERTED acabou de temporariamente armazenar.


-- DELETE
-- Ao inv�s de mostrar na tela a mensagem gen�rica que os dados foram alterados, mostrar os pr�prios dados que foram deletados na tabela;
CREATE OR ALTER TRIGGER tgClienteAlterado
ON dCliente
AFTER DELETE
AS
BEGIN
	SELECT * FROM DELETED
		-- PRINT 'Os dados da tabela dCliente foram alterados!'
END

-- Repare que agora, no bloco de comandos, inserimos um SELECT * FROM DELETED. Com essa altera��o na nossa trigger, se efetuarmos o DELETE abaixo, repare que o resultado ser�o os pr�prios dados que foram exclu�dos na tabela dCliente.

DELETE FROM dCliente
WHERE id_cliente = 12

-- Isso aconteceu porque, toda vez que exclu�mos algum dado de uma tabela, esse registro tamb�m fica temporariamente armazenado na tabela DELETED. Como inclu�mos um SELECT a essa tabela (DELETED) no bloco de comandos da trigger tgClienteAlterado, quando disparada, ela mostrou como resultado o registro que a tabela DELETED acabou de temporariamente armazenar.


-- UPDATE
-- Ja parou para pensar que, quando atualizamos uma tabela, temos dois registros? O novo que foi inserido na tabela, e o antigo que foi exclu�do da tabela para dar lugar ao novo. Com isso em mente, vamos imaginar que queremos, por fim, alterar a trigger tgClienteAlterado para, a partir de agora, apresentar na tela os dados que foram inseridos na tabela dCliente e os que foram exclu�dos da tabela dCliente toda vez que executamos um UPDATE.

CREATE OR ALTER TRIGGER tgClienteAlterado
ON dCliente
AFTER UPDATE
AS
BEGIN
	SELECT * FROM INSERTED
	SELECT * FROM DELETED
		-- PRINT 'Os dados da tabela dCliente foram alterados!'
END

-- Repare que agora, no bloco de comandos, inserimos duas consultas: um SELECT * FROM INSERTED (para retornar o novo registo) e um SELECT * FROM DELETED (para retornar o registro que foi exclu�do). Vamos inserir novamente o registro que exclu�mos no �ltimo exemplo para podermos, posteriormente, atualiz�-los.

INSERT INTO dCliente(nome_cliente, genero, data_de_nascimento, cpf)	VALUES
	('Zacarias Neto', 'M', '13/02/1999', '139.543.189-00')

-- Agora, note que, com a altera��o na nossa trigger, se efetuarmos o UPDATE abaixo, o resultado ser� o registro que foi inclu�do na tabela dCliente e tamb�m o que foi exclu�do da tabela dCliente.

UPDATE dCliente
SET cpf = '130.451.892-10'
WHERE id_cliente = 13

/* Isso aconteceu porque, toda vez que atualizamos algum dado de uma tabela, o novo registro tamb�m fica temporariamente armazenado na tabela INSERTED, enquanto que o antigo registo (que foi exclu�do) fica temporariamente armazenado na tabela DELETED. Como inclu�mos um SELECT tanto � tabela INSERTED quanto � tabela DELETED no bloco de comandos da trigger tgClienteAlterado, quando disparada, ela mostrou como resultado os registros que as tabelas INSERTED e DELETED acabaram de temporariamente armazenar.

Portando, em resumo, podemos concluir que:

- Se a trigger for de INSERT, a INSERTED ter� registros e a DELETED ficar� vazia;
- Se a trigger for de DELETE, a INSERTED ficar� vazia e a DELETED ter� registros;
- Se a trigger for de UPDATE, a INSERTED e a DELETED ter�o registros;
*/

------------------------------

/* AULA 05 - Identificando na Trigger o Evento DML Relacionado
Sabendo agora, como funcionam as tabelas INSERTED e DELETED, podemos finalmente personalizar as mensagens apresentadas na tela, de acordo com o comando DML utilizado, quando a tabela dCliente for alterada e a nossa trigger tgClienteAlterado disparada.

Relembrando, quando dispararmos o comando... ser� apresentado na tela a mensagem...
INSERT INTO: Os dados foram inseridos na tabela!
UPDATE: Os dados foram atualizados na tabela!
DELETE: Os dados foram exclu�dos da tabela!
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
- 2. Informamos o nome da tabela que far� a trigger ser disparada toda vez que for alterada. No caso, ser� a dCliente;
- 3. Determinamos se a trigger ser� do tipo AFTER ou INSTEAD OF (no caso, ser� do tipo AFTER, pois queremos que ela dispare depois que uma altera��o for efetuada) e quais ser�o os comandos que a disparar�o quando forem executados. No caso, ser� depois dos tr�s comando DML: INSERT, UPDATE e DELETE	  
- 4. Iniciamos o bloco de comandos com o comando BEGIN;
- 5. Dentro do bloco de comandos, fazemos um IF EXISTS, para verificar se, ap�s executado um dos comando DML (INSERT, UPDATE ou DELETE), h� dados tanto na tabela INSERTED quando na DELETED; e se houver, significa que o comando DML utilizado foi um UPDATE, j� que, conforme vimos, o UPDATE � o �nico comando que insere dados em ambas tabelas tempor�rias. Sendo um UPDATE, aparecer� na tela a mensagem 'Os dados foram atualizados na tabela!';
- 6. Se no IF acima for verificado que ou a INSERTED ou a DELETED est� vazia, significa que o comando DML utilizado n�o foi um UPDATE, ent�o, prosseguimos para a pr�xima linha do c�digo e verificamos no primeiro ELSE IF EXISTS, se h� dados na tabela INSERTED; se houver, significa que o comando DML utilizado foi um INSERTED, portando, imprimimos na tela a mensagem 'Os dados foram inseridos na tabela!'; 
- 7. Caso contr�rio, ou seja, se a tabela INSERTED estiver vazia, fazemos a �ltima verifica��o para saber se h� dados na tabela DELETED, se houver, significa que o comando DML utilizado foi um DELETE, portanto, imprimimos na tela que 'Os dados foram exclu�dos da tabela!'.
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

/* AULA 06 - Criando uma Trigger para Controle de Permiss�o de Cadastro - INSTEAD OF (Parte 1)
Vamos ver agora a cria��o de uma Trigger DML do tipo INSTEAD OF. Este tipo de trigger efetua alguma a��o no lugar do comando DML especificado, toda vez que uma determinada condi��o for atendida.

No nosso exemplo, vamos imaginar que queremos permitir � inser��o de dados na tabela dCliente apenas de segunda � sexta. Se for s�bado ou domingo, nossa trigger deve gerar um erro, apresent�-lo na tela e n�o permitir a inser��o dos novos dados. Por�m, se for dia �til, a trigger deve permitir a inser��o dos novos dados na tabela dCliente normalmente.

Vamos ao passo a passo:
- 1. Iniciamos a noss trigger com o comando CREATE OR ALTER TRIGGER e damos um nome a ela;
- 2. Informamos o nome da tabela que far� a trigger ser disparada quando for alterada. No caso, ser� a dCliente;
- 3. Determinamos se a trigger ser� do tipo AFTER ou INSTEAD OF (no caso, ser� do tipo INSTEAD OF, pois queremos que ela informe um erro no lugar do INSERT, n�o permitindo que ele seja efetuado, caso o usu�rio tente inserir novos dados na tabela dCliente no final de semana;
- 4. Iniciamos o bloco de comandos com o comando BEGIN;
- 5. Dentro do bloco de comandos, executamos um IF para verificar se o dia de hoje (GETDATE()) � s�bado ou domingo;
- 6. Se for, utilizamos a instru��o RAISERROR para exibir um erro na tela com a seguinte mensagem: 'O cadastro de clientes s� pode ser feito de segunda � sexta feira, e efetuamos um ROLLBACK para que o INSERT efetuado seja desfeito;
- 7. Se n�o for final de semana, efetuamos o INSERT desejado na tabela dCliente. Observe que os dados a serem inseridos na tabela dCliente ser�o extra�dos da tabela INSERTED, que armazenou temporariamente o registo inclu�do pelo usu�rio;
- 8. Finalizamos o bloco de comando com o comando END.

- Crie uma Trigger que seja disparada sempre INSTEAD OF de um INSERT, UPDATE e DELETE que for executado na tabela dCliente. O que deve acontecer: se o dia de cadastro for s�bado ou domingo, n�o pode deixar alterar pois est� fora do hor�rio comercial. */

-- Se for s�bado ou domingo retorne o erro.
CREATE OR ALTER TRIGGER tgControleRegistros
ON dCliente
INSTEAD OF INSERT
AS
BEGIN

	IF FORMAT(GETDATE(), 'dddd') IN ('s�bado', 'domingo') -- Pode usar OR ou IN
	BEGIN

		RAISERROR('O cadastro de clientes s� pode ser feito de segunda � sexta', 1, 1) -- Emitir um erro for�ado
		ROLLBACK
	END
END

-- Testemos agora a nossa trigger tgControleRegistros, tentando efetuar o seguinte INSERT na tabela dCliente; Se for final de semana (s�bado ou domingo), repare que a trigger disparada retornar� o erro configurado, conforme esperado; Por�m, se caso hoje n�o seja s�bado ou domingo, ser� executado o INSERT e os dados ser�o normalmente inseridos na tabela.

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

		RAISERROR('O cadastro de clientes s� pode ser feito de segunda � sexta', 1, 1) -- Emitir um erro for�ado
		ROLLBACK
	END
END

INSERT INTO dCliente(nome_cliente, genero, data_de_nascimento, cpf)	VALUES
	('Pedro Albuquerque', 'M', '13/02/2003', '111.543.189-00')

SELECT * FROM dCliente
-- Obs.: N�o ocorreu um erro pois 'hoje' � s�bado por�m, n�o foi inserido nenhuma linha pois em nosso c�digo n�o foi informado o que tem que ocorrer se o dia for diferente de domingo.

------------------------------

-- AULA 07 - Criando uma Trigger para Controle de Permiss�o de Cadastro - INSTEAD OF (Parte 2)

CREATE OR ALTER TRIGGER tgControleRegistros
ON dCliente
INSTEAD OF INSERT
AS
BEGIN

	IF FORMAT(GETDATE(), 'dddd') IN ('domingo') -- Pode usar OR ou IN
	BEGIN

		RAISERROR('O cadastro de clientes s� pode ser feito de segunda � sexta', 1, 1) -- Emitir um erro for�ado
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

-- Obs.�: Agora sim, os dados dos clientes foram inseridos na tabela.
-- Obs.�: Na mensagem aparecer� a mensagem 'Dados Foram Inseridos na Tabela' pois nos exemplos anteriores, foi criar uma Trigger que verificava se era um INSERTED, DELETED ou UPDATE e inserido este PRINT como resultado.

SELECT * FROM dCliente

------------------------------

/* AULA 08 - Habilitando, Desabilitando e Excluindo uma Trigger
Al�m de, podermos excluir uma TRIGGER DML, tamb�m temos a op��o de apenas desabilit�-la. Desta forma, ela continua salva no banco de dados por�m, deixa de ser disparada. Se porventura precisarmos, podemos habilit�-la novamente. */

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
DISABLE TRIGGER tgControleRegistros ON dCliente -- Desabilitando uma Trigger espec�fica
ENABLE TRIGGER tgControleRegistros ON dCliente -- Habilitando uma Trigger espec�fica


-- Desabilitando e Habilitando TODAS as Triggers DML da tabela dCliente
DISABLE TRIGGER ALL ON dCliente -- Desabilitando TODAS as Triggers
ENABLE TRIGGER ALL ON dCliente -- Habilitando TODAS as Triggers

-- Excluindo a Trigger DML tgControleRegistros
DROP TRIGGER tgControleRegistros;