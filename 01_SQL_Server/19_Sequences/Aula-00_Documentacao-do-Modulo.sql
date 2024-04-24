-- M�DULO 19 - SQL SERVER - SEQUENCES

/* AULA 01 - Introdu��o
Nesse m�dulo vamos aprender a utilizar sequences no SQL

- O que � uma Sequence
- Como criar uma Sequence
- Excluindo uma Sequence
Como utilizar uma Sequence na pr�tica */

------------------------------

/* AULA 02 - O quue � uma SEQUENCE?

Uma sequ�ncia (SEQUENCE) � um objeto que utilizamos para cria��o de n�meros sequenciais autom�ticos. S�o usados especialmente para gerar valores sequenciais �nicos para as chaves prim�rias das tabelas.

Dessa forma, n�o precisamos ficar preenchendo a sequ�ncia de ids manualmente (como fizemos at� ent�o), podemos gerar automaticamente por meio de uma sequence. */


CREATE SEQUENCE nome_sequencia			-- Criar sequ�ncia
AS tipo									-- Informar o tipo de dados a ser utilizado (INT, DECIMAL, etc.)
START WITH n							-- Come�ar a sequ�ncia a partir de qual n�mero
INCREMENT BY n							-- Incrementar de quantos em quantos n�meros (de 1 em 1, de 10 em 10, etc.)
MAXVALUE n | NO MAXVALUE				-- A sequ�ncia ter� valor m�ximo ou n�o
MINVALUE n | NO MINVALUE				-- A sequ�ncia ter� valor m�nimo ou n�o
CYCLE | NO CYCLE;						-- Quando atingir o valor m�ximo, deve voltar ou n�o

------------------------------

-- AULA 03 - Como criar uma SEQUENCE

-- Crie uma sequ�ncia para o id_cliente
CREATE SEQUENCE clientes_seq			-- Criar� uma sequ�ncia que ser� chamada de clientes_seq;
AS INT									-- Ser� do tipo INT;
START WITH 1							-- Come�ar� pelo n�mero 1;
INCREMENT BY 1							-- Ser� incrementada de 1 em 1;
NO MAXVALUE								-- N�o ter� valor maximo;
NO CYCLE								-- N�o voltar� ao in�cio;

-- Para descobrir qual � o pr�ximo valor da sequ�ncia, utilize NEXT VALUE FOR:
-- Pr�ximo valor da sequ�ncia
SELECT NEXT VALUE FOR clientes_seq
-- Cada vez que o c�digo acima for executado, ele retornar� o pr�ximo valor da sequ�ncia: (1, 2, 3, 4...)

-- Por fim, para excluir uma SEQUENCE, utilize o comando DROP SEQUENCE
-- Excluir uma sequence
DROP SEQUENCE clientes_seq

------------------------------

-- AULA 04 - Como utilizar uma SEQUENCE

-- Crie uma sequ�ncia para o id_projeto
CREATE SEQUENCE projetos_seq		-- Ser� chamada de projetos_seq;
AS INT								-- Ser� do tipo INT;
START WITH 1						-- Come�ar� pelo n�mero 1;
INCREMENT BY 1						-- Ser� incrementada de 1 em 1;
NO MAXVALUE							-- N�o ter� valor m�ximo;
NO CYCLE							-- N�o voltar� ao in�cio;

-- Criada a sequence projetos_seq, vamos agora criar a tabela dProjeto que a utilizar�:
CREATE TABLE dProjeto(
	id_projeto INT,
	nome_projeto VARCHAR(100) NOT NULL,
	CONSTRAINT dareas_id_area_pk PRIMARY KEY(id_projeto)
)

-- Por fim, vamos inserir os registos (linhas) na nova tabela criada)
-- Repare que para inserir os valores da coluna id_projeto, agora que temos uma sequence, n�o precisamos informar n�mero de ID, manualmente. Basta informarmos nas linhas a serem inseridas o comando NXET VALUE FOR e o nome da sequence, conforme abaixo:
INSERT INTO dProjeto(id_projeto, nome_projeto) VALUES
	(NEXT VALUE FOR projetos_seq, 'Planejamento Estrat�gico'),
	(NEXT VALUE FOR projetos_seq, 'Desenvolvimento de App'),
	(NEXT VALUE FOR projetos_seq, 'Plano de Neg�cios'),
	(NEXT VALUE FOR projetos_seq, 'Visualiza��o 3D')

-- Se consultarmos a tabela dProjeto agora, veremos que quatro registros foram inseridos, e a coluna id_projeto foi devidamente preenchida com os valores automaticamente gerados pela sequence projetos_seq:
-- E se continuarmos inserindo novas linhas, estas tamb�m seguir�o a ordem da sequence utilizada.
INSERT INTO dProjeto(id_projeto, nome_projeto) VALUES
	(NEXT VALUE FOR projetos_seq, 'Mapeamento de Processos')

SELECT * FROM dProjeto
-- Note que o ID foi gerado automaticamente para a coluna id_projeto do novo registro seguiu normalmente a numera��o da sequ�ncia:

------------------------------

-- AULA 05 - Explica��o Exerc�cios
-- AULA 06 - Resolu��o de Exerc�cios 1, 2, 3