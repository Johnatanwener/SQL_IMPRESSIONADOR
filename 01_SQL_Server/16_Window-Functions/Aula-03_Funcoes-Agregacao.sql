-- M�DULO 16 - SQL SERVER - Window Function (Fun��es de Janela)


/* AULA 03 - Fun��es de Agrega��o: SUM, COUNT, AVG, MIN, MAX

OVER
Os primeiros exemplos que vamos ver � com as fun��es de agrega��o. Conseguimos usar essas fun��es para c�lculos de totais de contagens, somas, m�dias, m�nimos e m�ximos. Um detalhe importante � que neste exemplo, utilizamos a instru��o OVER apenas. Dessa forma, o c�lculo do total ser� considerando todas as lojas. Se quis�ssemos calcular totais levando em considera��o cada regi�o (por exemplo, lojas do Sudeste) ter�amos que utilizar a instru��o OVER em conjunto com a PARTITION BY.

OVER + PARTITION BY
Se quisermos calcular estas agrega��es para fazer an�lises considerando agrupamentos espec�ficos (por regi�o, por exemplo) apenas adicionamos dentro do OVER a instru��o PARTITION BY e informamos por qual coluna queremos fazer um agrupamento. Teria uma l�gica semelhante ao GROUP BY, sendo que n�o agrupamos uma tabela, e sim o c�lculo. Ou seja, os c�lculos de contagem, soma, m�dia, m�nimo e m�ximo s�o feitos considerando um determinado grupo espec�ficado.

-- Ex.: 01. Crie uma coluna contendo a SOMA total das vendas da tabela lojas */
SELECT SUM(Qtd_Vendida) FROM Lojas

SELECT 
	*,
	SUM(Qtd_Vendida) OVER() AS 'Total Vendido'
FROM Lojas

-- Ex.: 02. Crie uma nova coluna contendo a SOMA todal das vendas por Regi�o
SELECT
	*,
	SUM(Qtd_Vendida) OVER(PARTITION BY Regiao) AS 'Total Vendido por Regi�o'
FROM Lojas
ORDER BY ID_Loja

-- Ex.: 03. Crie uma nova coluna contendo a CONTAGEM de Lojas
SELECT
	*,
	COUNT(*) OVER() AS 'Qtd. Lojas'
FROM Lojas
ORDER BY ID_Loja

-- Ex.: 04. Crie uma nova coluna contendo a CONTAGEM de Lojas por Regi�o
SELECT
	*,
	COUNT(*) OVER(PARTITION BY Regiao) AS 'Qtd. Lojas por Regi�o'
FROM Lojas
ORDER BY ID_Loja

-- Ex.: 05. Crie uma nova coluna contendo a M�DIA das vendas
SELECT
	*,
	AVG(Qtd_Vendida) OVER() AS 'M�dia de Vendas'
FROM Lojas
ORDER BY ID_Loja

-- Ex.: 06 Crie uma nova coluna contendo a M�DIA das vendas por Regi�o
SELECT
	*,
	AVG(Qtd_Vendida) OVER(PARTITION BY Regiao) AS 'M�dia de Vendas por Regi�o'
FROM Lojas
ORDER BY ID_Loja

-- Ex.: 07 Crie uma nova coluna contendo a quantidade M�NIMA de vendas
SELECT
	*,
	MIN(Qtd_Vendida) OVER() AS 'Qtd. MIN de Vendas'
FROM Lojas
ORDER BY ID_Loja

-- Ex.: 08 Crie uma nova coluna contendo a MENOR venda por regi�o
SELECT
	*,
	MIN(Qtd_Vendida) OVER(PARTITION BY Regiao) AS 'Qtd. MIN Vendas por Regi�o'
FROM Lojas
ORDER BY ID_Loja

-- Ex.: 09 Crie uma nova coluna contendo a quantidade M�XIMA de vendas
SELECT
	*,
	MAX(Qtd_Vendida) OVER() AS 'Qtd. MAX de Vendas'
FROM Lojas
ORDER BY ID_Loja

-- Ex.: 10 Crie uma nova coluna contendo a quantidade M�XIMA de vendas por Regi�o
SELECT
	*,
	MAX(Qtd_Vendida) OVER(PARTITION BY Regiao) AS 'Qtd. MAX de Vendas por Regi�o'
FROM Lojas
ORDER BY ID_Loja

-- Ex.: 11 Junte todos os exemplos em uma �nica tabela
SELECT
	*,
	SUM(Qtd_Vendida) OVER() AS 'Total Vendido',
	SUM(Qtd_Vendida) OVER(PARTITION BY Regiao) AS 'Total Vendido por Regi�o',
	COUNT(*) OVER() AS 'Qtd. Lojas',
	COUNT(*) OVER(PARTITION BY Regiao) AS 'Qtd. Lojas por Regi�o',
	AVG(Qtd_Vendida) OVER() AS 'M�dia de Vendas',
	AVG(Qtd_Vendida) OVER(PARTITION BY Regiao) AS 'M�dia de Vendas por Regi�o',
	MIN(Qtd_Vendida) OVER() AS 'Qtd. MIN de Vendas',
	MIN(Qtd_Vendida) OVER(PARTITION BY Regiao) AS 'Qtd. MIN Vendas por Regi�o',
	MAX(Qtd_Vendida) OVER() AS 'Qtd. MAX de Vendas',
	MAX(Qtd_Vendida) OVER(PARTITION BY Regiao) AS 'Qtd. MAX de Vendas por Regi�o'
FROM Lojas
ORDER BY ID_Loja