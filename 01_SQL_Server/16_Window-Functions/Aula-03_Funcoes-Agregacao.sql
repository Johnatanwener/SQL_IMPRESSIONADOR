-- MÓDULO 16 - SQL SERVER - Window Function (Funções de Janela)


/* AULA 03 - Funções de Agregação: SUM, COUNT, AVG, MIN, MAX

OVER
Os primeiros exemplos que vamos ver é com as funções de agregação. Conseguimos usar essas funções para cálculos de totais de contagens, somas, médias, mínimos e máximos. Um detalhe importante é que neste exemplo, utilizamos a instrução OVER apenas. Dessa forma, o cálculo do total será considerando todas as lojas. Se quiséssemos calcular totais levando em consideração cada região (por exemplo, lojas do Sudeste) teríamos que utilizar a instrução OVER em conjunto com a PARTITION BY.

OVER + PARTITION BY
Se quisermos calcular estas agregações para fazer análises considerando agrupamentos específicos (por região, por exemplo) apenas adicionamos dentro do OVER a instrução PARTITION BY e informamos por qual coluna queremos fazer um agrupamento. Teria uma lógica semelhante ao GROUP BY, sendo que não agrupamos uma tabela, e sim o cálculo. Ou seja, os cálculos de contagem, soma, média, mínimo e máximo são feitos considerando um determinado grupo específicado.

-- Ex.: 01. Crie uma coluna contendo a SOMA total das vendas da tabela lojas */
SELECT SUM(Qtd_Vendida) FROM Lojas

SELECT 
	*,
	SUM(Qtd_Vendida) OVER() AS 'Total Vendido'
FROM Lojas

-- Ex.: 02. Crie uma nova coluna contendo a SOMA todal das vendas por Região
SELECT
	*,
	SUM(Qtd_Vendida) OVER(PARTITION BY Regiao) AS 'Total Vendido por Região'
FROM Lojas
ORDER BY ID_Loja

-- Ex.: 03. Crie uma nova coluna contendo a CONTAGEM de Lojas
SELECT
	*,
	COUNT(*) OVER() AS 'Qtd. Lojas'
FROM Lojas
ORDER BY ID_Loja

-- Ex.: 04. Crie uma nova coluna contendo a CONTAGEM de Lojas por Região
SELECT
	*,
	COUNT(*) OVER(PARTITION BY Regiao) AS 'Qtd. Lojas por Região'
FROM Lojas
ORDER BY ID_Loja

-- Ex.: 05. Crie uma nova coluna contendo a MÉDIA das vendas
SELECT
	*,
	AVG(Qtd_Vendida) OVER() AS 'Média de Vendas'
FROM Lojas
ORDER BY ID_Loja

-- Ex.: 06 Crie uma nova coluna contendo a MÉDIA das vendas por Região
SELECT
	*,
	AVG(Qtd_Vendida) OVER(PARTITION BY Regiao) AS 'Média de Vendas por Região'
FROM Lojas
ORDER BY ID_Loja

-- Ex.: 07 Crie uma nova coluna contendo a quantidade MÍNIMA de vendas
SELECT
	*,
	MIN(Qtd_Vendida) OVER() AS 'Qtd. MIN de Vendas'
FROM Lojas
ORDER BY ID_Loja

-- Ex.: 08 Crie uma nova coluna contendo a MENOR venda por região
SELECT
	*,
	MIN(Qtd_Vendida) OVER(PARTITION BY Regiao) AS 'Qtd. MIN Vendas por Região'
FROM Lojas
ORDER BY ID_Loja

-- Ex.: 09 Crie uma nova coluna contendo a quantidade MÁXIMA de vendas
SELECT
	*,
	MAX(Qtd_Vendida) OVER() AS 'Qtd. MAX de Vendas'
FROM Lojas
ORDER BY ID_Loja

-- Ex.: 10 Crie uma nova coluna contendo a quantidade MÁXIMA de vendas por Região
SELECT
	*,
	MAX(Qtd_Vendida) OVER(PARTITION BY Regiao) AS 'Qtd. MAX de Vendas por Região'
FROM Lojas
ORDER BY ID_Loja

-- Ex.: 11 Junte todos os exemplos em uma única tabela
SELECT
	*,
	SUM(Qtd_Vendida) OVER() AS 'Total Vendido',
	SUM(Qtd_Vendida) OVER(PARTITION BY Regiao) AS 'Total Vendido por Região',
	COUNT(*) OVER() AS 'Qtd. Lojas',
	COUNT(*) OVER(PARTITION BY Regiao) AS 'Qtd. Lojas por Região',
	AVG(Qtd_Vendida) OVER() AS 'Média de Vendas',
	AVG(Qtd_Vendida) OVER(PARTITION BY Regiao) AS 'Média de Vendas por Região',
	MIN(Qtd_Vendida) OVER() AS 'Qtd. MIN de Vendas',
	MIN(Qtd_Vendida) OVER(PARTITION BY Regiao) AS 'Qtd. MIN Vendas por Região',
	MAX(Qtd_Vendida) OVER() AS 'Qtd. MAX de Vendas',
	MAX(Qtd_Vendida) OVER(PARTITION BY Regiao) AS 'Qtd. MAX de Vendas por Região'
FROM Lojas
ORDER BY ID_Loja