-- MÓDULO 16 - SQL SERVER - Window Function (Funções de Janela)


/* AULA 06 - Funções de Classificação: ROW_NUMBER, RANK, DENSE_RANK, NTILE
- ROW_NUMBER: Cria uma coluna com a numeração das linhas da tabela. É como se fosse uma coluna de ID.
- RANK: Cria uma coluna de ranking. Em caso de empates, os rankings dos números se repetem, mas o próximo ranking pula a sequência. Ex.: dois valores na posição 8, o valor seguinte pula para a posição 10.
- DENSE_RANK: Cria uma coluna de ranking. Em caso de empates, os rankings dos números se repetem, e o próximo ranking continua a sequência. Ex: dois valores na posição 8, o valor seguinte continua na posição 9.
- NTILE: Distribui os valores de uma coluna em grupos.	*/

Select
	*,
	ROW_NUMBER() OVER(ORDER BY Qtd_Vendida DESC) AS 'RowNumber',
	RANK() OVER(ORDER BY Qtd_Vendida DESC) AS 'Rank', 
	DENSE_RANK() OVER(ORDER BY Qtd_Vendida DESC) AS 'DenseRank', 
	NTILE(3) OVER(ORDER BY Qtd_Vendida DESC) AS 'Ntile' -- Vai exigir um argumento. Olha para a quantidade de valores (linhas) da tabela e divide em grupos, de acordo com o argumento inserido.
FROM Lojas

/* Observe que dentro da instrução OVER é utilizado o ORDER BY. O que faz sentido, pois de certa forma as funções de classificação têm como objetivo ordenar os valores. 
Porém, com as funções de classificação, podemos potencializar a aplicação do ORDER BY (que aqui também pode ser usado com as opções ASC e DESC fazendo a ordenação crescente e decrescente, respectivamente). */
