-- MÓDULO 19 - SQL SERVER - SEQUENCES


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