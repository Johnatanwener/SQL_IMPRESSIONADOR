-- M�DULO 16 - SQL SERVER - Window Function (Fun��es de Janela)


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
