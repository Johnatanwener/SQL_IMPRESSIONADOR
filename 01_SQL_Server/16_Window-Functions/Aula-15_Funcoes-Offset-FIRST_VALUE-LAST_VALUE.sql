-- MÓDULO 16 - SQL SERVER - Window Function (Funções de Janela)


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