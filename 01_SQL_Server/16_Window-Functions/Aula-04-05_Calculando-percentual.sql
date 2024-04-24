-- MÓDULO 16 - SQL SERVER - Window Function (Funções de Janela)


/* AULA 04 e 05 - CÁLCULO DO PERCENTUAL TOTAL
Sabendo como fazer agregações totais (OVER apenas) e agregamentos particionados (OVER + PARTITION BY), poderemos facilmente agora fazer cálculos de participação %. 

Observe o exemplo abaixo: Se quisermos descobrir qual é a participação de cada loja em termos de total vendido, basta dividirmos a coluna Qtd_Vendida pelo bloco SUM(Qtd_Vendida)OVER()

Obs.: Utilizamos a função FORMAT apenas para formatar os resultados como percentual. Não haveria necessiade de incluí-lo. */

-- a) Calcule o % de participação de cada loja em relação ao total de vendas de todas as lojas.
SELECT
	*,
	SUM(Qtd_Vendida) OVER() AS 'Total Vendido',
	Qtd_Vendida / SUM(Qtd_Vendida) OVER() AS '% do Total',
	FORMAT(Qtd_Vendida / SUM(Qtd_Vendida) OVER(), '0.00%') AS '% do Total Formatado'
FROM Lojas
ORDER BY ID_Loja


-- Fazendo uma alteração simples e incluindo o PARTITION BY, podemos calcular o % que cada loja tem de participação, considerando suas respectivas regiões. Tome cuidado porque no exemplo estamos considerando o cálculo por região e não total. Ou seja, a loja Botafogo Praia&Mar tem uma quantidade vendida que representa 6,8% do valor total e representa 24,32% das vendas da região Sudeste.

-- b) Calcule o % de participacao de cada loja em relação ao total de vendas de cada região.
SELECT
	*,
	SUM(Qtd_Vendida) OVER(PARTITION BY Regiao) AS 'Total Vendido por Região',
	Qtd_Vendida / SUM(Qtd_Vendida) OVER(PARTITION BY Regiao) AS '% do região',
	FORMAT(Qtd_Vendida / SUM(Qtd_Vendida) OVER(PARTITION BY Regiao), '0.00%') AS '% do região Formatado'
FROM Lojas
ORDER BY ID_Loja
