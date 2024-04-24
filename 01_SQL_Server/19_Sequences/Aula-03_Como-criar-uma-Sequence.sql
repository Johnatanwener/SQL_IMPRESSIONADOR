-- M�DULO 19 - SQL SERVER - SEQUENCES


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