-- MÓDULO 19 - SQL SERVER - SEQUENCES


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