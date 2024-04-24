-- MÓDULO 19 - SQL SERVER - SEQUENCES

/* AULA 01 - Introdução
Nesse módulo vamos aprender a utilizar sequences no SQL

- O que é uma Sequence
- Como criar uma Sequence
- Excluindo uma Sequence
Como utilizar uma Sequence na prática */

------------------------------

/* AULA 02 - O quue é uma SEQUENCE?

Uma sequência (SEQUENCE) é um objeto que utilizamos para criação de números sequenciais automáticos. São usados especialmente para gerar valores sequenciais únicos para as chaves primárias das tabelas.

Dessa forma, não precisamos ficar preenchendo a sequência de ids manualmente (como fizemos até então), podemos gerar automaticamente por meio de uma sequence. */


CREATE SEQUENCE nome_sequencia			-- Criar sequência
AS tipo									-- Informar o tipo de dados a ser utilizado (INT, DECIMAL, etc.)
START WITH n							-- Começar a sequência a partir de qual número
INCREMENT BY n							-- Incrementar de quantos em quantos números (de 1 em 1, de 10 em 10, etc.)
MAXVALUE n | NO MAXVALUE				-- A sequência terá valor máximo ou não
MINVALUE n | NO MINVALUE				-- A sequência terá valor mínimo ou não
CYCLE | NO CYCLE;						-- Quando atingir o valor máximo, deve voltar ou não

------------------------------

-- AULA 03 - Como criar uma SEQUENCE

-- Crie uma sequência para o id_cliente
CREATE SEQUENCE clientes_seq			-- Criará uma sequência que será chamada de clientes_seq;
AS INT									-- Será do tipo INT;
START WITH 1							-- Começará pelo número 1;
INCREMENT BY 1							-- Será incrementada de 1 em 1;
NO MAXVALUE								-- Não terá valor maximo;
NO CYCLE								-- Não voltará ao início;

-- Para descobrir qual é o próximo valor da sequência, utilize NEXT VALUE FOR:
-- Próximo valor da sequência
SELECT NEXT VALUE FOR clientes_seq
-- Cada vez que o código acima for executado, ele retornará o próximo valor da sequência: (1, 2, 3, 4...)

-- Por fim, para excluir uma SEQUENCE, utilize o comando DROP SEQUENCE
-- Excluir uma sequence
DROP SEQUENCE clientes_seq

------------------------------

-- AULA 04 - Como utilizar uma SEQUENCE

-- Crie uma sequência para o id_projeto
CREATE SEQUENCE projetos_seq		-- Será chamada de projetos_seq;
AS INT								-- Será do tipo INT;
START WITH 1						-- Começará pelo número 1;
INCREMENT BY 1						-- Será incrementada de 1 em 1;
NO MAXVALUE							-- Não terá valor máximo;
NO CYCLE							-- Não voltará ao início;

-- Criada a sequence projetos_seq, vamos agora criar a tabela dProjeto que a utilizará:
CREATE TABLE dProjeto(
	id_projeto INT,
	nome_projeto VARCHAR(100) NOT NULL,
	CONSTRAINT dareas_id_area_pk PRIMARY KEY(id_projeto)
)

-- Por fim, vamos inserir os registos (linhas) na nova tabela criada)
-- Repare que para inserir os valores da coluna id_projeto, agora que temos uma sequence, não precisamos informar número de ID, manualmente. Basta informarmos nas linhas a serem inseridas o comando NXET VALUE FOR e o nome da sequence, conforme abaixo:
INSERT INTO dProjeto(id_projeto, nome_projeto) VALUES
	(NEXT VALUE FOR projetos_seq, 'Planejamento Estratégico'),
	(NEXT VALUE FOR projetos_seq, 'Desenvolvimento de App'),
	(NEXT VALUE FOR projetos_seq, 'Plano de Negócios'),
	(NEXT VALUE FOR projetos_seq, 'Visualização 3D')

-- Se consultarmos a tabela dProjeto agora, veremos que quatro registros foram inseridos, e a coluna id_projeto foi devidamente preenchida com os valores automaticamente gerados pela sequence projetos_seq:
-- E se continuarmos inserindo novas linhas, estas também seguirão a ordem da sequence utilizada.
INSERT INTO dProjeto(id_projeto, nome_projeto) VALUES
	(NEXT VALUE FOR projetos_seq, 'Mapeamento de Processos')

SELECT * FROM dProjeto
-- Note que o ID foi gerado automaticamente para a coluna id_projeto do novo registro seguiu normalmente a numeração da sequência:

------------------------------

-- AULA 05 - Explicação Exercícios
-- AULA 06 - Resolução de Exercícios 1, 2, 3