-- M�DULO 16 - SQL SERVER - Window Function (Fun��es de Janela)


/* AULA 08 - RANK + GROUP BY
Podemos tamb�m utilizar a fun��o RANK para criar rankings em dados agrupados. Ou seja, criamos agrupamentos com o GROUP BY e fazemos um ranking considerando estes dados agrupados. No exemplo abaixo, criamos um agrupamento por Regi�o, e adicionamos a essa tabela agrupada uma coluna de ranking.

Crie uma tabela com o total de vendas por regi�o e adicione uma coluna de ranking nessa tabela */

SELECT
	Regiao AS 'Regi�o',
	SUM(Qtd_Vendida) AS 'Total Vendido'
FROM Lojas
GROUP BY Regiao
ORDER BY SUM(Qtd_Vendida) DESC


SELECT
	Regiao AS 'Regi�o',
	SUM(Qtd_Vendida) AS 'Total Vendido',
	RANK() OVER(ORDER BY SUM(Qtd_Vendida) DESC) AS 'Ranking'
FROM Lojas
GROUP BY Regiao
ORDER BY SUM(Qtd_Vendida) DESC
