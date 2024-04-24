-- MÓDULO 16 - SQL SERVER - Window Function (Funções de Janela)


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