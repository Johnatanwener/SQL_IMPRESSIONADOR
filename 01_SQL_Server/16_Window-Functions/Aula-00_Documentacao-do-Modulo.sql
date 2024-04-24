-- MÓDULO 16 - SQL SERVER - Window Function (Funções de Janela)

/* AULA 01 - Introdução ao Módulo
Nesse módulo vamos aprender a utilizar as funções de janela no SQL

- O que são Window Functions
- Funções de Agregação
- Funções de Classificação
- Funções de Offset

Para que servem?
- São utilizadas para cálculos mais avançados de análises de dados;
- Possuem um uso semelhante ao GROUP BY, só que mais avançado e personalizável;
- A instrução OVER permite definir qual será a "janela" (conjunto de linhas) a ser considerado no cálculo;
- A instrução PARTITION BY divide o conjunto em "partições" nas quais as funções de janela são aplicadas;

As funções de janela possuem as seguintes finalidades:
1. Cálculos de agregações: COUNT, SUM, AVG, MIN, MAX
2. Cálculos de deslocamento: FIRST_VALUE, LAST_VALUE, LEAD, LAG
3. Cálculos estatísticos: RANK,, DENSE_RANK, NTILE */

------------------------------

-- AULA 02 - Script Tabela Lojas

CREATE DATABASE WF
USE WF

CREATE TABLE Lojas(
ID_Loja INT,
Nome_Loja VARCHAR(100),
Regiao VARCHAR(100),
Qtd_Vendida FLOAT)

SELECT * FROM Lojas


INSERT INTO Lojas(ID_Loja, Nome_Loja, Regiao, Qtd_Vendida)
VALUES
	(1, 'Botafogo Praia&Mar', 'Sudeste', 1800),
	(2, 'Lojas Vitoria', 'Sudeste', 800),
	(3, 'Emporio Mineirinho', 'Sudeste', 2300),
	(4, 'Central Paulista', 'Sudeste', 1800),
	(5, 'Rio 90 graus', 'Sudeste', 700),
	(6, 'Casa Flor & Anópolis', 'Sul', 2100),
	(7, 'Pampas & Co', 'Sul', 990),
	(8, 'Paraná Papéis', 'Sul', 2800),
	(9, 'Amazonas Prime', 'Norte', 4200),
	(10, 'Pará Bens', 'Norte', 3200),
	(11, 'Tintas Rio Branco', 'Norte', 1500),
	(12, 'Nordestemido Hall', 'Nordeste', 1910),
	(13, 'Cachoerinha Loft', 'Nordeste', 2380)

------------------------------

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

------------------------------

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

------------------------------

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

------------------------------

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

------------------------------

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

------------------------------

-- AULA 09 - Cálculo de soma móvel e média móvel
CREATE TABLE Resultado(
	Data_Fechamento DATETIME,
	Mes_Ano VARCHAR(100),
	faturamento_MM FLOAT)

INSERT INTO Resultado(Data_Fechamento, Mes_Ano, Faturamento_MM)
VALUES
	('01/01/2020', 'JAN-20', 8),
	('01/02/2020', 'FEV-20', 10),
	('01/03/2020', 'MAR-20', 6),
	('01/04/2020', 'ABR-20', 9),
	('01/05/2020', 'MAI-20', 5),
	('01/06/2020', 'JUN-20', 4),
	('01/07/2020', 'JUL-20', 7),
	('01/08/2020', 'AGO-20', 11),
	('01/09/2020', 'SET-20', 9),
	('01/10/2020', 'OUT-20', 12),
	('01/11/2020', 'NOV-20', 11),
	('01/12/2020', 'DEZ-20', 10)

SELECT * FROM Resultado

/* SOMA MÓVEL
Uma outra análise que podemos fazer é a de soma móvel. Para utilizarmos a função soma móvel, precisamos usar uma função de janela. Usamos a função SUM junto com a cláusula OVER para somar os valores de um determinado intervalo.

Esse intervalo de soma pode ser especificado pelo trecho no código abaixo. 
Observe a parte: ROWS BETWEEN 1 PRECEDING AND CURRENT ROW

Podemos traduzir esta parte literamente por: LINHAS ENTRE 1 ANTES E A LINHA ATUAL

Como queremos fazer uma soma, isto significa que: a nossa janela de soma será entre as linhas anterior e atual. Ou seja, essa soma será feita considerando sempre os valores da linha atual + a linha anterior. */
SELECT
	*,
	SUM(Faturamento_MM) OVER(ORDER BY Data_Fechamento ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS 'Soma Móvel'
FROM
	Resultado
/* 
Obs.: A função SUM está somando valores entre 1 anterior + o valor atual e trazendo o resultado dessa soma
Obs.: A quantidade de valores anteriores é definido de acordo com resultado que eu desjeo ter.

Outra possibilidade é eprsonalizar a janela para que ela considere valores antes da linha e depois da linha em questão. Por exemplo: ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING 
Em resumo, podemos usar o PRECEDING ou FOLOWING para personalizar o 'tamanho' da janela de cálculo. */


/* MÉDIA MÓVEL
Para fazer uma média móvel, seguimos exatamente a mesma lógica aplicada anteriormente. A única diferença é que agora usamos o AVG no lugar do SUM.
Na verdade, podemos fazer qualquer análise móvel apenas trocando a função (COUNT, MIN, MAX, SUM ou AVG) */
SELECT
	*,
	AVG(Faturamento_MM) OVER(ORDER BY Data_Fechamento ROWS BETWEEN 3 PRECEDING AND CURRENT ROW) AS 'Média Móvel'
FROM
	Resultado
-- Obs.: A função AVG está somando os 3 valores anteriores mais o valor atual e trazendo o resultado da média dessa soma
-- Obs.: A quantidade de valores anteriores é definido de acordo com resultado que eu desjeo ter.

------------------------------

-- AULA 10 - Cálculo de acumulado
/* SOMA ACUMULADO
Para fazer um cálculo de acumulado, precisamos fazer com que a nossa janela de análise comece sempre na data mais antiga e vá até a linha atual. Isso significa que a janela de soma deve ser entre a linha mais anterior até a linha atual. Informar a linha atual nós sabemos, será por meio da CURRENT ROW.
Já para informar a linha mais anterior, usamos o UNBOUNDED PRECEDING. Ou seja, sempre que precisarmos fazer um cálculo com uma janela que começa na primeira linha da tabela, o nosso intervalo começará com: UNBOUNDED PRECEDING
De forma muito semelhante, se quisermos uma janela que vá até a última linha, usamos o UNBOUNDED FOLLOWING. */
SELECT
	*,
	SUM(Faturamento_MM) OVER(ORDER BY Data_Fechamento ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS 'Soma Acumulado'
FROM
	Resultado
-- Obs.: A função SUM com UNBOUNDED está somando TODOS os valores anteriores mais o valor atual e trazendo o resultado dessa soma

-- MÉDIA ACUMULADO
SELECT
	*,
	AVG(Faturamento_MM) OVER(ORDER BY Data_Fechamento ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS 'Média Móvel'
FROM
	Resultado
-- Obs.: A função AVG com UNBOUNDED está somando TODOS os valores anteriores mais o valor atual e trazendo o resultado da média dessa soma

------------------------------

-- AULA 11 - Um pouco mais sobre Soma Móvel e Acumulado
SELECT
	*,
	SUM(Faturamento_MM) OVER(ORDER BY Data_Fechamento ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS 'Soma Móvel'
FROM
	Resultado
-- Obs.: A função SUM está somando o valor atual mais 1 valor anterior e mais 1 valor posterior.
-- Obs.: Se no lugar de '1 FOLLOWING' fosse colocado '0 FOLLOWING' seria a mesma coisa que colocar 'CURRENT ROW'

/* ROWS BETWEEN inicio_do_intervalo AND fim_do_intervalo

Exemplos desses intervalos podem ser:

- ROWS BETWEEN 1 PRECEDING AND CURRENT ROW: 1 linha antes e a linha atual 
- ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW: todas as linhas antes e a linha atual
- ROWS BETWEEN 1 PRECEDING AND FOLLOWING: 1 linha antes e 1 linha depois da atual
- ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING: todas as linhas antes e todas as linhas depois da linha atual
*/

------------------------------

/* AULA 12 - Funções de Offset - LAG e LEAD

LAG: A função LAG permite que em uma determinada linha seja possivel acessar o valor anterior, ou seja, pega o valor anterior e desloca para a linha atual, o valor atual para a linha posterior, etc.

O funcionamento da função LAG é bem intuitivo. Ele permite acessar valores anteriores. A função LAG pede 3 argumentos:
1. Qual é a coluna com os valores que queremos deslocar.
2. Quantas linhas para trás queremos deslocar.
3. QUando não for encontrado um valor anterior, qual é o valor que deve aparecer.

No exemplo abaixo, temos os seguintes argumentos para a função:
1º argumento) Expressão: Faturamento_MM - coluna que queremos acessar os valores anteriores
2º argumento) Offset: 1 - quantas linhas queremos deslocar para trás.
3º argumento) Default: 0 - valor padrão, que queremos que retorne caso ele não encontre nenhum valor (na linha 1 da tabela retornou zero porque não tem nenhum outro valor de Faturamento antes da linha 1) */

-- Exemplo LAG 01:
SELECT 
	*,
	LAG(Faturamento_MM, 1, 0) OVER(ORDER BY Data_Fechamento) AS 'Valor anterior'
FROM Resultado

/* Veja um outro exemplo:
1º argumento) Expressão: Faturamento_MM - coluna que queremos acessar os valores anteriores
2º argumento) Offset: 1 - quantas linhas queremos deslocar para trás.
3º argumento) Default: Não informado

Repare agora que a coluna Valor anterior está 'pegando' o valor 2 casas para trás na coluna Faturamento Total. E como não informamos o default, os dois primeiros valores ficaram NULL (porque deslocando o Faturamento Total duas casas para trás, não tem nenhum valor disponível). */

-- Exemplo LAG 02:
SELECT 
	*,
	LAG(Faturamento_MM, 2) OVER(ORDER BY Data_Fechamento) AS 'Valor anterior'
FROM Resultado


/* LED: A função LEAD faz exatamento o oposto da função LAG. Agora, o deslocamento será feito para frente. Então observe no exemplo abaixo, que ao usar o LEAD com o 2º argumento igual a 1, acesamos o valor de Faturamento Total da linha seguinte. Ou seja, na linha 1, o valor 10 refere-se ao Faturamento Total da linha 2. */

-- Exemplo LEAD 01:
SELECT 
	*,
	LEAD(Faturamento_MM, 1, 0) OVER(ORDER BY Data_Fechamento) AS 'LEAD'
FROM Resultado


-- Exexmplo LEAD 02:
SELECT 
	*,
	LEAD(Faturamento_MM, 2) OVER(ORDER BY Data_Fechamento) AS 'LEAD'
FROM Resultado


-- Quando não se tem valores anteriores no caso do LAG ou posteriores no caso do LEAD para descolar, por padrão o SQL coloca NULL porém, caso não queria que apareça o NULL, é só informar um terceiro argumento na função como 0.
-- Exemplo 03:	
SELECT 
	*,
	LAG(Faturamento_MM, 2, 0) OVER(ORDER BY Data_Fechamento) AS 'LAG',
	LEAD(Faturamento_MM, 2, 0) OVER(ORDER BY Data_Fechamento) AS 'LEAD'
FROM Resultado

------------------------------

/* AULA 13 - Função de Offset (Cálculo MoM)
O cálculo MoM (Month Over Month) nada mais é do que um cálculo de variação percentual de crescimento/decrescimento de um valor em relação ao mês anterior.

Por exemplo: Qual foi a variação percentual do Faturamento de fevereiro em relação ao mês anterior (janeiro)? A fórmula é a seguinte:
Variação % MoM = (Faturamento Mês Atual / Faturamento Mês Anterior) - 1

Para fazer esse cálculo de variação % precisaremos trabalhar com funções de janela, mais especificamente a função de offset LAG pois precisamos fazer o Faturamento Total dividido pelo Faturamento do Mês Anterior.

Calculo MoM: 
(valor Mês Atual - Valor Mês Anterior) / (Valor do Mês Anterior)
(valor Mês Atual)/(Valor do Mês Anterior) - (Valor Mês Anterior) / (Valor Mês Anterior)
(Valor Mês Atual)/(Valor do Mês Anterior) - 1			*/

SELECT 
	*,
	FORMAT((Faturamento_MM/LAG(Faturamento_MM, 1) OVER(ORDER BY Data_Fechamento)) - 1, '0.00%') AS '% MoM'
FROM Resultado
-- Obs.: O que essa consulta está fazendo é: Descobrir, em relação ao faturamento do mês anterior, quantos % o faturamento do mês atual aumentou ou diminuiu.

/* Cálculo MoM + NULLIF
Se na função LAG for inserido três argumentos ao invés de dois argumentos para contornar o NULL, será retornado um erro. 
E a forma de contornar esse erro é através da função NULLIF.

Função NULLIF: A função NULLIF nos pede dois argumentos sendo que, se os argumentos foram iguais, a função retornará NULL e se os argumentos forem diferentes a função retornará o primeiro argumento. 
Exemplo:		*/
SELECT NULLIF (4, 4) -- = NULL
SELECT NULLIF (4, 0) -- = 4

SELECT 
	*,
	FORMAT((Faturamento_MM/NULLIF(LAG(Faturamento_MM, 1, 0) OVER(ORDER BY Data_Fechamento), 0)) - 1, '0.00%') AS '% MoM'
FROM Resultado

------------------------------

/* AULA 14 - Funções de Offset - FIRST_VALUE e LAST_VALUE
As funções FISRT_VALUE e LAST_VALUE nos retorna o primeiro valor e o último valor da coluna que estamos analisando. Porém, no caso do LAST_VALUE será necessário utilizar a função ROWS para especificar as linhas que queremos considerar, semelhante ao que foi feito anteriormente em cálculo de soma móvel e acumulado. 

FIRST_VALUE: Cria uma coluna de ranking. Em caso de empates, os ranking dos números se repetem, e o próximo ranking continua a sequência. Ex.: dois valores na posição 8, o valor seguinte continua na posição 9.
LAST_VALUE: Distribui os valores de uma coluna em grupos.
*/

SELECT
	*,
	FIRST_VALUE(Faturamento_MM) OVER(ORDER BY Data_Fechamento) AS 'Primeiro valor',
	LAST_VALUE(Faturamento_MM) OVER(ORDER BY Data_Fechamento ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS 'Último valor'
FROM Resultado
ORDER BY Data_Fechamento

------------------------------

-- AULA 16 - Explicação Exercícios
-- AULA 17 - Resolução Exercício 01
-- AULA 18 - Resolução Exercício 02
-- AULA 19 - Resolução Exercício 03
-- AULA 20 - Resolução Exercício 04
-- AULA 21 - Resolução Exercício 05
-- AULA 22 - Resolução Exercício 06
-- AULA 23 - Resolução Exercício 07
-- AULA 24 - Resolução Exercício 08