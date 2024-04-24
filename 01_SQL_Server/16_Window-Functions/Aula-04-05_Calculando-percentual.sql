-- M�DULO 16 - SQL SERVER - Window Function (Fun��es de Janela)


/* AULA 04 e 05 - C�LCULO DO PERCENTUAL TOTAL
Sabendo como fazer agrega��es totais (OVER apenas) e agregamentos particionados (OVER + PARTITION BY), poderemos facilmente agora fazer c�lculos de participa��o %. 

Observe o exemplo abaixo: Se quisermos descobrir qual � a participa��o de cada loja em termos de total vendido, basta dividirmos a coluna Qtd_Vendida pelo bloco SUM(Qtd_Vendida)OVER()

Obs.: Utilizamos a fun��o FORMAT apenas para formatar os resultados como percentual. N�o haveria necessiade de inclu�-lo. */

-- a) Calcule o % de participa��o de cada loja em rela��o ao total de vendas de todas as lojas.
SELECT
	*,
	SUM(Qtd_Vendida) OVER() AS 'Total Vendido',
	Qtd_Vendida / SUM(Qtd_Vendida) OVER() AS '% do Total',
	FORMAT(Qtd_Vendida / SUM(Qtd_Vendida) OVER(), '0.00%') AS '% do Total Formatado'
FROM Lojas
ORDER BY ID_Loja


-- Fazendo uma altera��o simples e incluindo o PARTITION BY, podemos calcular o % que cada loja tem de participa��o, considerando suas respectivas regi�es. Tome cuidado porque no exemplo estamos considerando o c�lculo por regi�o e n�o total. Ou seja, a loja Botafogo Praia&Mar tem uma quantidade vendida que representa 6,8% do valor total e representa 24,32% das vendas da regi�o Sudeste.

-- b) Calcule o % de participacao de cada loja em rela��o ao total de vendas de cada regi�o.
SELECT
	*,
	SUM(Qtd_Vendida) OVER(PARTITION BY Regiao) AS 'Total Vendido por Regi�o',
	Qtd_Vendida / SUM(Qtd_Vendida) OVER(PARTITION BY Regiao) AS '% do regi�o',
	FORMAT(Qtd_Vendida / SUM(Qtd_Vendida) OVER(PARTITION BY Regiao), '0.00%') AS '% do regi�o Formatado'
FROM Lojas
ORDER BY ID_Loja
