-- M�DULO 16 - SQL SERVER - Window Function (Fun��es de Janela)


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
