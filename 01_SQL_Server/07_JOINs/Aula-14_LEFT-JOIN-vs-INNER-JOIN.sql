-- MÓDULO 07 - SQL SERVER - JOINs 

/* AULA 14 - INNER JOIN ou LEFT JOIN - Qual usar?
O LEFT e o INNER são os JOINs mais utilizados dentre todos os que são possíveis utilizar. E a dúvida de qual utilizar vai depender do resultado final que quer obter.
Lembrando que, o LEFT JOIN vai retornar todas as linhas da tabela A independente se alguma linha não está na tabela B.
O INNER JOIN só irá retornar as linhas que contém informações em ambas as tabelas, ou seja, nenhuma informação NULL será apresentada. 

Situação 1:
Se a Tabela A (esquerda) possui os produtos de 1 à 10, e na Tabela B (deireita) também temos os produtos de 1 à 10, se fizermos um INNER JOIN ou um LEFT JOIN, teremos o mesmo resultado, visto que, não há em nenhum produto que exista em uma tabela porém, não exista em outra.

Situação 2:
Se a Tabela A (esquerda) possui os produtos de 1 à 11, e na Tabela B (direita) temos apenas os produtos de 1 à 10, isso quer dizer que existe um produto na Tabela A que não existe na Tabela B, logo: Se usarmos o LEFT JOIN, a tabela resultante terá um produto a mais (o que existe apenas na Tabela A (esquerda)), enquanto o INNER JOIN retornará apenas os produtos que estão presentes em ambas as tabelas, portanto não incluirá na tabela resultante o produto que só existe da Tabela A (esquerda)
*/