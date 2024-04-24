-- MODULO 20 - SQL SERVER - TRANSACTIONS


-- AULA 04 - Criando transa��es nomeadas
-- Veremos agora que podemos criar transa��es nomeadas. O processo � o mesmo de se criar uma transa��o sem nome. Devemos apenas acrescentar o nome que desejamos dar a ela ap�s o BEGIN TRANSACTION, dessa forma:

BEGIN TRANSACTION T1 -- Nomeando transacoes
INSERT INTO cliente_aux(nome_cliente, genero, data_de_nascimento, cpf) VALUES
	('Naldo Reis', 'M', '10/02/1992', '412.889.311-90')

-- No exemplo acima, chamamos nossa transa��o de T1. Assim, quando formos efetuar um COMMIT ou um ROLLBACK nesta transa��o, informamos o nome dela junto ao comando a ser executado.

-- Commitando uma transa��o
COMMIT TRANSACTION T1