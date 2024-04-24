-- MÓDULO 16 - SQL SERVER - Window Function (Funções de Janela)


/* AULA 08 - RANK + GROUP BY
Podemos também utilizar a função RANK para criar rankings em dados agrupados. Ou seja, criamos agrupamentos com o GROUP BY e fazemos um ranking considerando estes dados agrupados. No exemplo abaixo, criamos um agrupamento por Região, e adicionamos a essa tabela agrupada uma coluna de ranking.

Crie uma tabela com o total de vendas por região e adicione uma coluna de ranking nessa tabela */

SELECT
	Regiao AS 'Região',
	SUM(Qtd_Vendida) AS 'Total Vendido'
FROM Lojas
GROUP BY Regiao
ORDER BY SUM(Qtd_Vendida) DESC


SELECT
	Regiao AS 'Região',
	SUM(Qtd_Vendida) AS 'Total Vendido',
	RANK() OVER(ORDER BY SUM(Qtd_Vendida) DESC) AS 'Ranking'
FROM Lojas
GROUP BY Regiao
ORDER BY SUM(Qtd_Vendida) DESC
