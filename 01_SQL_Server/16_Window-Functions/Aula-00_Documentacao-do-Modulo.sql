-- M�DULO 16 - SQL SERVER - Window Function (Fun��es de Janela)

/* AULA 01 - Introdu��o ao M�dulo
Nesse m�dulo vamos aprender a utilizar as fun��es de janela no SQL

- O que s�o Window Functions
- Fun��es de Agrega��o
- Fun��es de Classifica��o
- Fun��es de Offset

Para que servem?
- S�o utilizadas para c�lculos mais avan�ados de an�lises de dados;
- Possuem um uso semelhante ao GROUP BY, s� que mais avan�ado e personaliz�vel;
- A instru��o OVER permite definir qual ser� a "janela" (conjunto de linhas) a ser considerado no c�lculo;
- A instru��o PARTITION BY divide o conjunto em "parti��es" nas quais as fun��es de janela s�o aplicadas;

As fun��es de janela possuem as seguintes finalidades:
1. C�lculos de agrega��es: COUNT, SUM, AVG, MIN, MAX
2. C�lculos de deslocamento: FIRST_VALUE, LAST_VALUE, LEAD, LAG
3. C�lculos estat�sticos: RANK,, DENSE_RANK, NTILE */

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
	(6, 'Casa Flor & An�polis', 'Sul', 2100),
	(7, 'Pampas & Co', 'Sul', 990),
	(8, 'Paran� Pap�is', 'Sul', 2800),
	(9, 'Amazonas Prime', 'Norte', 4200),
	(10, 'Par� Bens', 'Norte', 3200),
	(11, 'Tintas Rio Branco', 'Norte', 1500),
	(12, 'Nordestemido Hall', 'Nordeste', 1910),
	(13, 'Cachoerinha Loft', 'Nordeste', 2380)

------------------------------

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

------------------------------

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

------------------------------

/* AULA 06 - Fun��es de Classifica��o: ROW_NUMBER, RANK, DENSE_RANK, NTILE
- ROW_NUMBER: Cria uma coluna com a numera��o das linhas da tabela. � como se fosse uma coluna de ID.
- RANK: Cria uma coluna de ranking. Em caso de empates, os rankings dos n�meros se repetem, mas o pr�ximo ranking pula a sequ�ncia. Ex.: dois valores na posi��o 8, o valor seguinte pula para a posi��o 10.
- DENSE_RANK: Cria uma coluna de ranking. Em caso de empates, os rankings dos n�meros se repetem, e o pr�ximo ranking continua a sequ�ncia. Ex: dois valores na posi��o 8, o valor seguinte continua na posi��o 9.
- NTILE: Distribui os valores de uma coluna em grupos.	*/

Select
	*,
	ROW_NUMBER() OVER(ORDER BY Qtd_Vendida DESC) AS 'RowNumber',
	RANK() OVER(ORDER BY Qtd_Vendida DESC) AS 'Rank', 
	DENSE_RANK() OVER(ORDER BY Qtd_Vendida DESC) AS 'DenseRank', 
	NTILE(3) OVER(ORDER BY Qtd_Vendida DESC) AS 'Ntile' -- Vai exigir um argumento. Olha para a quantidade de valores (linhas) da tabela e divide em grupos, de acordo com o argumento inserido.
FROM Lojas

/* Observe que dentro da instru��o OVER � utilizado o ORDER BY. O que faz sentido, pois de certa forma as fun��es de classifica��o t�m como objetivo ordenar os valores. 
Por�m, com as fun��es de classifica��o, podemos potencializar a aplica��o do ORDER BY (que aqui tamb�m pode ser usado com as op��es ASC e DESC fazendo a ordena��o crescente e decrescente, respectivamente). */

------------------------------

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

------------------------------

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

------------------------------

-- AULA 09 - C�lculo de soma m�vel e m�dia m�vel
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

/* SOMA M�VEL
Uma outra an�lise que podemos fazer � a de soma m�vel. Para utilizarmos a fun��o soma m�vel, precisamos usar uma fun��o de janela. Usamos a fun��o SUM junto com a cl�usula OVER para somar os valores de um determinado intervalo.

Esse intervalo de soma pode ser especificado pelo trecho no c�digo abaixo. 
Observe a parte: ROWS BETWEEN 1 PRECEDING AND CURRENT ROW

Podemos traduzir esta parte literamente por: LINHAS ENTRE 1 ANTES E A LINHA ATUAL

Como queremos fazer uma soma, isto significa que: a nossa janela de soma ser� entre as linhas anterior e atual. Ou seja, essa soma ser� feita considerando sempre os valores da linha atual + a linha anterior. */
SELECT
	*,
	SUM(Faturamento_MM) OVER(ORDER BY Data_Fechamento ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS 'Soma M�vel'
FROM
	Resultado
/* 
Obs.: A fun��o SUM est� somando valores entre 1 anterior + o valor atual e trazendo o resultado dessa soma
Obs.: A quantidade de valores anteriores � definido de acordo com resultado que eu desjeo ter.

Outra possibilidade � eprsonalizar a janela para que ela considere valores antes da linha e depois da linha em quest�o. Por exemplo: ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING 
Em resumo, podemos usar o PRECEDING ou FOLOWING para personalizar o 'tamanho' da janela de c�lculo. */


/* M�DIA M�VEL
Para fazer uma m�dia m�vel, seguimos exatamente a mesma l�gica aplicada anteriormente. A �nica diferen�a � que agora usamos o AVG no lugar do SUM.
Na verdade, podemos fazer qualquer an�lise m�vel apenas trocando a fun��o (COUNT, MIN, MAX, SUM ou AVG) */
SELECT
	*,
	AVG(Faturamento_MM) OVER(ORDER BY Data_Fechamento ROWS BETWEEN 3 PRECEDING AND CURRENT ROW) AS 'M�dia M�vel'
FROM
	Resultado
-- Obs.: A fun��o AVG est� somando os 3 valores anteriores mais o valor atual e trazendo o resultado da m�dia dessa soma
-- Obs.: A quantidade de valores anteriores � definido de acordo com resultado que eu desjeo ter.

------------------------------

-- AULA 10 - C�lculo de acumulado
/* SOMA ACUMULADO
Para fazer um c�lculo de acumulado, precisamos fazer com que a nossa janela de an�lise comece sempre na data mais antiga e v� at� a linha atual. Isso significa que a janela de soma deve ser entre a linha mais anterior at� a linha atual. Informar a linha atual n�s sabemos, ser� por meio da CURRENT ROW.
J� para informar a linha mais anterior, usamos o UNBOUNDED PRECEDING. Ou seja, sempre que precisarmos fazer um c�lculo com uma janela que come�a na primeira linha da tabela, o nosso intervalo come�ar� com: UNBOUNDED PRECEDING
De forma muito semelhante, se quisermos uma janela que v� at� a �ltima linha, usamos o UNBOUNDED FOLLOWING. */
SELECT
	*,
	SUM(Faturamento_MM) OVER(ORDER BY Data_Fechamento ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS 'Soma Acumulado'
FROM
	Resultado
-- Obs.: A fun��o SUM com UNBOUNDED est� somando TODOS os valores anteriores mais o valor atual e trazendo o resultado dessa soma

-- M�DIA ACUMULADO
SELECT
	*,
	AVG(Faturamento_MM) OVER(ORDER BY Data_Fechamento ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS 'M�dia M�vel'
FROM
	Resultado
-- Obs.: A fun��o AVG com UNBOUNDED est� somando TODOS os valores anteriores mais o valor atual e trazendo o resultado da m�dia dessa soma

------------------------------

-- AULA 11 - Um pouco mais sobre Soma M�vel e Acumulado
SELECT
	*,
	SUM(Faturamento_MM) OVER(ORDER BY Data_Fechamento ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS 'Soma M�vel'
FROM
	Resultado
-- Obs.: A fun��o SUM est� somando o valor atual mais 1 valor anterior e mais 1 valor posterior.
-- Obs.: Se no lugar de '1 FOLLOWING' fosse colocado '0 FOLLOWING' seria a mesma coisa que colocar 'CURRENT ROW'

/* ROWS BETWEEN inicio_do_intervalo AND fim_do_intervalo

Exemplos desses intervalos podem ser:

- ROWS BETWEEN 1 PRECEDING AND CURRENT ROW: 1 linha antes e a linha atual 
- ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW: todas as linhas antes e a linha atual
- ROWS BETWEEN 1 PRECEDING AND FOLLOWING: 1 linha antes e 1 linha depois da atual
- ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING: todas as linhas antes e todas as linhas depois da linha atual
*/

------------------------------

/* AULA 12 - Fun��es de Offset - LAG e LEAD

LAG: A fun��o LAG permite que em uma determinada linha seja possivel acessar o valor anterior, ou seja, pega o valor anterior e desloca para a linha atual, o valor atual para a linha posterior, etc.

O funcionamento da fun��o LAG � bem intuitivo. Ele permite acessar valores anteriores. A fun��o LAG pede 3 argumentos:
1. Qual � a coluna com os valores que queremos deslocar.
2. Quantas linhas para tr�s queremos deslocar.
3. QUando n�o for encontrado um valor anterior, qual � o valor que deve aparecer.

No exemplo abaixo, temos os seguintes argumentos para a fun��o:
1� argumento) Express�o: Faturamento_MM - coluna que queremos acessar os valores anteriores
2� argumento) Offset: 1 - quantas linhas queremos deslocar para tr�s.
3� argumento) Default: 0 - valor padr�o, que queremos que retorne caso ele n�o encontre nenhum valor (na linha 1 da tabela retornou zero porque n�o tem nenhum outro valor de Faturamento antes da linha 1) */

-- Exemplo LAG 01:
SELECT 
	*,
	LAG(Faturamento_MM, 1, 0) OVER(ORDER BY Data_Fechamento) AS 'Valor anterior'
FROM Resultado

/* Veja um outro exemplo:
1� argumento) Express�o: Faturamento_MM - coluna que queremos acessar os valores anteriores
2� argumento) Offset: 1 - quantas linhas queremos deslocar para tr�s.
3� argumento) Default: N�o informado

Repare agora que a coluna Valor anterior est� 'pegando' o valor 2 casas para tr�s na coluna Faturamento Total. E como n�o informamos o default, os dois primeiros valores ficaram NULL (porque deslocando o Faturamento Total duas casas para tr�s, n�o tem nenhum valor dispon�vel). */

-- Exemplo LAG 02:
SELECT 
	*,
	LAG(Faturamento_MM, 2) OVER(ORDER BY Data_Fechamento) AS 'Valor anterior'
FROM Resultado


/* LED: A fun��o LEAD faz exatamento o oposto da fun��o LAG. Agora, o deslocamento ser� feito para frente. Ent�o observe no exemplo abaixo, que ao usar o LEAD com o 2� argumento igual a 1, acesamos o valor de Faturamento Total da linha seguinte. Ou seja, na linha 1, o valor 10 refere-se ao Faturamento Total da linha 2. */

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


-- Quando n�o se tem valores anteriores no caso do LAG ou posteriores no caso do LEAD para descolar, por padr�o o SQL coloca NULL por�m, caso n�o queria que apare�a o NULL, � s� informar um terceiro argumento na fun��o como 0.
-- Exemplo 03:	
SELECT 
	*,
	LAG(Faturamento_MM, 2, 0) OVER(ORDER BY Data_Fechamento) AS 'LAG',
	LEAD(Faturamento_MM, 2, 0) OVER(ORDER BY Data_Fechamento) AS 'LEAD'
FROM Resultado

------------------------------

/* AULA 13 - Fun��o de Offset (C�lculo MoM)
O c�lculo MoM (Month Over Month) nada mais � do que um c�lculo de varia��o percentual de crescimento/decrescimento de um valor em rela��o ao m�s anterior.

Por exemplo: Qual foi a varia��o percentual do Faturamento de fevereiro em rela��o ao m�s anterior (janeiro)? A f�rmula � a seguinte:
Varia��o % MoM = (Faturamento M�s Atual / Faturamento M�s Anterior) - 1

Para fazer esse c�lculo de varia��o % precisaremos trabalhar com fun��es de janela, mais especificamente a fun��o de offset LAG pois precisamos fazer o Faturamento Total dividido pelo Faturamento do M�s Anterior.

Calculo MoM: 
(valor M�s Atual - Valor M�s Anterior) / (Valor do M�s Anterior)
(valor M�s Atual)/(Valor do M�s Anterior) - (Valor M�s Anterior) / (Valor M�s Anterior)
(Valor M�s Atual)/(Valor do M�s Anterior) - 1			*/

SELECT 
	*,
	FORMAT((Faturamento_MM/LAG(Faturamento_MM, 1) OVER(ORDER BY Data_Fechamento)) - 1, '0.00%') AS '% MoM'
FROM Resultado
-- Obs.: O que essa consulta est� fazendo �: Descobrir, em rela��o ao faturamento do m�s anterior, quantos % o faturamento do m�s atual aumentou ou diminuiu.

/* C�lculo MoM + NULLIF
Se na fun��o LAG for inserido tr�s argumentos ao inv�s de dois argumentos para contornar o NULL, ser� retornado um erro. 
E a forma de contornar esse erro � atrav�s da fun��o NULLIF.

Fun��o NULLIF: A fun��o NULLIF nos pede dois argumentos sendo que, se os argumentos foram iguais, a fun��o retornar� NULL e se os argumentos forem diferentes a fun��o retornar� o primeiro argumento. 
Exemplo:		*/
SELECT NULLIF (4, 4) -- = NULL
SELECT NULLIF (4, 0) -- = 4

SELECT 
	*,
	FORMAT((Faturamento_MM/NULLIF(LAG(Faturamento_MM, 1, 0) OVER(ORDER BY Data_Fechamento), 0)) - 1, '0.00%') AS '% MoM'
FROM Resultado

------------------------------

/* AULA 14 - Fun��es de Offset - FIRST_VALUE e LAST_VALUE
As fun��es FISRT_VALUE e LAST_VALUE nos retorna o primeiro valor e o �ltimo valor da coluna que estamos analisando. Por�m, no caso do LAST_VALUE ser� necess�rio utilizar a fun��o ROWS para especificar as linhas que queremos considerar, semelhante ao que foi feito anteriormente em c�lculo de soma m�vel e acumulado. 

FIRST_VALUE: Cria uma coluna de ranking. Em caso de empates, os ranking dos n�meros se repetem, e o pr�ximo ranking continua a sequ�ncia. Ex.: dois valores na posi��o 8, o valor seguinte continua na posi��o 9.
LAST_VALUE: Distribui os valores de uma coluna em grupos.
*/

SELECT
	*,
	FIRST_VALUE(Faturamento_MM) OVER(ORDER BY Data_Fechamento) AS 'Primeiro valor',
	LAST_VALUE(Faturamento_MM) OVER(ORDER BY Data_Fechamento ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS '�ltimo valor'
FROM Resultado
ORDER BY Data_Fechamento

------------------------------

-- AULA 16 - Explica��o Exerc�cios
-- AULA 17 - Resolu��o Exerc�cio 01
-- AULA 18 - Resolu��o Exerc�cio 02
-- AULA 19 - Resolu��o Exerc�cio 03
-- AULA 20 - Resolu��o Exerc�cio 04
-- AULA 21 - Resolu��o Exerc�cio 05
-- AULA 22 - Resolu��o Exerc�cio 06
-- AULA 23 - Resolu��o Exerc�cio 07
-- AULA 24 - Resolu��o Exerc�cio 08