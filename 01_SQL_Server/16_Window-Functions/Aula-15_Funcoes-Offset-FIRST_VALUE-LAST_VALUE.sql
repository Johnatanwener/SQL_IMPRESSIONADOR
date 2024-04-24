-- M�DULO 16 - SQL SERVER - Window Function (Fun��es de Janela)


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