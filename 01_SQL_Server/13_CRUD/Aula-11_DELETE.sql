-- MÓDULO 13 - SQL SERVER - CRUD


/* AULA 11 - DELETE - Deletando dados
Utilize o comando DELETE para deletar um dado dentro de uma tabela. O comando WHERE será fundamental para que a gente possa especificar exatamente qual é o id que queremos deletar. */

DELETE
FROM Produtos
WHERE id_produto = 3

-- Obs.: Agora, a informação da tabela referente a linha onde o id_produto for igual a 3 foi deletada.

SELECT * FROM Produtos