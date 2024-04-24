-- M�DULO 16 - SQL SERVER - Window Function (Fun��es de Janela)


/* AULA 07 - Fun��es de Classifica��o: + PARTITION BY
 
As fun��es de classifica��o tamb�m podem ser utilizadas dentro de reparti��es, ou seja, grupos internos a nossa tabela, por meio da PARTITION BY. 
No exemplo abaixo, as fun��es de classifica��o s�o aplicadas participando por regi�es. Ou seja, � como se o PARTITION BY deixasse claro para o SQL que a tabela deve ser entendida como diversas tabelas separadas fazendo essa divis�o por regi�o.
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
