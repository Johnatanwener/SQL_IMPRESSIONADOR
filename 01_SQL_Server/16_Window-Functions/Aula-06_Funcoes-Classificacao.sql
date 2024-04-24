-- M�DULO 16 - SQL SERVER - Window Function (Fun��es de Janela)


/* AULA 06 - Fun��es de Classifica��o: ROW_NUMBER, RANK, DENSE_RANK, NTILE
- ROW_NUMBER: Cria uma coluna com a numera��o das linhas da tabela. � como se fosse uma coluna de ID.
- RANK: Cria uma coluna de ranking. Em caso de empates, os rankings dos n�meros se repetem, mas o pr�ximo ranking pula a sequ�ncia. Ex.: dois valores na posi��o 8, o valor seguinte pula para a posi��o 10.
- DENSE_RANK: Cria uma coluna de ranking. Em caso de empates, os rankings dos n�meros se repetem, e o pr�ximo ranking continua a sequ�ncia. Ex: dois valores na posi��o 8, o valor seguinte continua na posi��o 9.
- NTILE: Distribui os valores de uma coluna em grupos.	*/

Select
	*,
	ROW_NUMBER() OVER(ORDER BY Qtd_Vendida DESC) AS 'RowNumber',
	RANK() OVER(ORDER BY Qtd_Vendida DESC) AS 'Rank', 
	DENSE_RANK() OVER(ORDER BY Qtd_Vendida DESC) AS 'DenseRank', 
	NTILE(3) OVER(ORDER BY Qtd_Vendida DESC) AS 'Ntile' -- Vai exigir um argumento. Olha para a quantidade de valores (linhas) da tabela e divide em grupos, de acordo com o argumento inserido.
FROM Lojas

/* Observe que dentro da instru��o OVER � utilizado o ORDER BY. O que faz sentido, pois de certa forma as fun��es de classifica��o t�m como objetivo ordenar os valores. 
Por�m, com as fun��es de classifica��o, podemos potencializar a aplica��o do ORDER BY (que aqui tamb�m pode ser usado com as op��es ASC e DESC fazendo a ordena��o crescente e decrescente, respectivamente). */
