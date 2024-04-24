-- MÓDULO 19 - SQL SERVER - SEQUENCES


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