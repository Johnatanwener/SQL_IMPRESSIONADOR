-- M�DULO 13 - SQL SERVER - CRUD


/* AULA 10 - UPDATE - Atualizando o dado de uma tabela
Utilize o comando UPDATE para atualizar um dado dentro de uma tabela. O comando WHERE ser� fundamental para que a gente possa especificar ecatamente qual � o ID que queremos alterar. */

UPDATE Produtos
SET nome_produto = 'Macarr�o'
WHERE id_produto = 3

-- Obs.: Agora, a informa��o de 'nome do produto' que antes estava como NULL ser� preenchida com a informa��o 'Macarr�o' informada nessa consulta.

SELECT * FROM Produtos