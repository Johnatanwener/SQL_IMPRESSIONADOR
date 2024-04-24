-- MÓDULO 13 - SQL SERVER - CRUD


/* AULA 10 - UPDATE - Atualizando o dado de uma tabela
Utilize o comando UPDATE para atualizar um dado dentro de uma tabela. O comando WHERE será fundamental para que a gente possa especificar ecatamente qual é o ID que queremos alterar. */

UPDATE Produtos
SET nome_produto = 'Macarrão'
WHERE id_produto = 3

-- Obs.: Agora, a informação de 'nome do produto' que antes estava como NULL será preenchida com a informação 'Macarrão' informada nessa consulta.

SELECT * FROM Produtos