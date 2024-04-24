-- MÓDULO 16 - SQL SERVER - Window Function (Funções de Janela)


/* AULA 07 - Funções de Classificação: + PARTITION BY
 
As funções de classificação também podem ser utilizadas dentro de repartições, ou seja, grupos internos a nossa tabela, por meio da PARTITION BY. 
No exemplo abaixo, as funções de classificação são aplicadas participando por regiões. Ou seja, é como se o PARTITION BY deixasse claro para o SQL que a tabela deve ser entendida como diversas tabelas separadas fazendo essa divisão por região.
*/

SELECT
	*,
	ROW_NUMBER() OVER(PARTITION BY Regiao ORDER BY Qtd_Vendida DESC) AS 'RowNumber',
	RANK() OVER(PARTITION BY Regiao ORDER BY Qtd_Vendida DESC) AS 'Rank',
	DENSE_RANK() OVER(PARTITION BY Regiao ORDER BY Qtd_Vendida DESC) AS 'DenseRank',
	NTILE(3) OVER(PARTITION BY Regiao ORDER BY Qtd_Vendida DESC) AS 'Ntile'
FROM
	Lojas
--ORDER BY Qtd_Vendida DESC
