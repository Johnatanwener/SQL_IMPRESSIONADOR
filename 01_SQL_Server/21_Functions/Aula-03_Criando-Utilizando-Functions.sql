-- M�DULO 21 - SQL SERVER - FUNCTIONS


/* AULA 03 - Como criar e utilizar uma Function
Vamos imaginar que agente queira fazer uma formata��o diferenciada na coluna data_de_nascimento da tabela dCliente. Em vez de retornar apenas a data conforme ela est� armazenada (por exemplo, �1989-02-12�), queremos retorn�-la por extenso(assim: �Domingo, 12 de Fevereiro de 1989�)

Podemos fazer isso por meio da fun��o DATENAME */

SELECT * FROM dCliente

SELECT 
	nome_cliente,
	data_de_nascimento,
	DATENAME(DW, data_de_nascimento) + ', ' +
	DATENAME(D, data_de_nascimento) + ' de ' +
	DATENAME(M, data_de_nascimento) + ' de ' +
	DATENAME(YY, data_de_nascimento)
FROM dCliente

/* Por�m, para facilitar para gente, n�s podemos criar uma function que utilize a DATENAME e retorne este mesmo resultado para qualquer coluna de data de qualquer tabela. Assim, quando formos efetuar a consulta a uma tabela que contenha uma coluna de data que precisemos retornar por extenso (como no caso da coluna data_de_nascimento da tabela dCliente), n�s n�o precisamos recriar todo o c�digo com a DATENAME. Tudo que precisamos fazer � �chamar� dentro do nosso SELECT a fun��o que tivermos criado. Portando, criaremos a fun��o, que chamaremos de fnDataCompleta. */

-- Criando uma fun��o para formata��o de data usando a DATENAME

-- 1. Iniciamos com o comando CREATE FUNCTION, damos um nome � function (fnDataCompleta), assim como ao par�metro que ser� recebido por ela (no caso @data, que ser� do tipo DATE);
-- 2. Em seguida, informamos o tipo de dado que a function dever� retornar que, neste caso, ser� do tipo VARCHAR. Repare que no par�metro a function receber� um dado do tipo DATE (YYYY-MM-DD), far� o tratamento necess�rio nesse dado  (cujos comandos ser�o passados logo mais dentro do bloco de execu��o que inicia com BEGIN) e retornar� um dado do tipo VARCHAR(a string da data por extenso);
-- 3. Depois, abrimos o bloco de execu��o e, dentro dele, passamos os comandos do que a fun��o deve ser capaz de fazer (no caso, transformar uma data em uma string desta data por extenso);
-- 4.  Finalizamos o bloco de execu��o com o comando END.

CREATE FUNCTION fnDataCompleta(@data AS DATE)
RETURNS VARCHAR(MAX)
AS
BEGIN
	RETURN DATENAME(DW, @Data) + ', ' +
			DATENAME(D, @Data) + ' de ' +
			DATENAME(M, @Data) + ' de ' +
			DATENAME(YY, @Data)
END

/* Repare que nossa function rec�m-criada agora est� salva na pasta Programa��o > Fun��es > Fun��es com Valor  Escalar, como hav�amos mencionado anteriormente.
Note que, ao nome da function, o sistema acrescentou o prefixo �dbo�. Este termo significa �database owner�  (propriet�rio do banco de dados) e � anexado a todo objeto criado pelo administrador do banco de dados.
Por isso, se tratando de functions, quando formos utiliz�-las nas consultas que efetuarmos, devemos sempre nos lembrar de acrescentar o prefixo �dbo.� ao seu nome, caso contr�rio, o sistema retornar� um erro.

Criada nossa function fnDataCompleta, agora podemos utiliz�-la todas as vezes que precisarmos pegar um valor do tipo DATE e transform�-lo em uma string dessa data por extenso. 

Ent�o, para executar esse procedimento com a coluna data_de_nascimento da tabela dCliente, podemos fazer como no
 c�digo abaixo */

-- Refazendo o SELECT sem a necessidade de utilizar a fun��o DATENAME varias vezes.
SELECT
	nome_cliente,
	data_de_nascimento,
	[dbo].[fnDataCompleta](data_de_nascimento)
FROM
	dCliente

--  Perceba que informamos o nome da fun��o (dbo.fnDataCompleta) e, entre par�nteses, passamos o nome da coluna que servir� de par�metro para a fun��o. Neste caso, � a coluna  data_de_nascimento da tabela dCliente.
-- Obs: Teremos o mesmo resultado que a consulta anterior, s� que dessa vez ficar� salvo como uma FUNCTION ent�o, toda vez que precisar realizar uma QUERY neste formato eu poderei utilizar esta FUNCTION ao inv�s de escrever todo o c�digo.