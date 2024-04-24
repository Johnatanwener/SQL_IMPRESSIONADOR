-- MÓDULO 16 - SQL SERVER - Window Function (Funções de Janela)


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
