-- MÓDULO 16 - SQL SERVER - Window Function (Funções de Janela)


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
