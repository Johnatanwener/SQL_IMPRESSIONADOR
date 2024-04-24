-- M�DULO 07 - SQL SERVER - JOINs 

/* AULA 14 - INNER JOIN ou LEFT JOIN - Qual usar?
O LEFT e o INNER s�o os JOINs mais utilizados dentre todos os que s�o poss�veis utilizar. E a d�vida de qual utilizar vai depender do resultado final que quer obter.
Lembrando que, o LEFT JOIN vai retornar todas as linhas da tabela A independente se alguma linha n�o est� na tabela B.
O INNER JOIN s� ir� retornar as linhas que cont�m informa��es em ambas as tabelas, ou seja, nenhuma informa��o NULL ser� apresentada. 

Situa��o 1:
Se a Tabela A (esquerda) possui os produtos de 1 � 10, e na Tabela B (deireita) tamb�m temos os produtos de 1 � 10, se fizermos um INNER JOIN ou um LEFT JOIN, teremos o mesmo resultado, visto que, n�o h� em nenhum produto que exista em uma tabela por�m, n�o exista em outra.

Situa��o 2:
Se a Tabela A (esquerda) possui os produtos de 1 � 11, e na Tabela B (direita) temos apenas os produtos de 1 � 10, isso quer dizer que existe um produto na Tabela A que n�o existe na Tabela B, logo: Se usarmos o LEFT JOIN, a tabela resultante ter� um produto a mais (o que existe apenas na Tabela A (esquerda)), enquanto o INNER JOIN retornar� apenas os produtos que est�o presentes em ambas as tabelas, portanto n�o incluir� na tabela resultante o produto que s� existe da Tabela A (esquerda)
*/