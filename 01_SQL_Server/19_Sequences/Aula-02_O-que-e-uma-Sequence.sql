-- M�DULO 19 - SQL SERVER - SEQUENCES


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