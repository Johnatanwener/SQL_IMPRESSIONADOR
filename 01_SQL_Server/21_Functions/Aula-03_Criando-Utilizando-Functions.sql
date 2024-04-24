-- MÓDULO 21 - SQL SERVER - FUNCTIONS


/* AULA 03 - Como criar e utilizar uma Function
Vamos imaginar que agente queira fazer uma formatação diferenciada na coluna data_de_nascimento da tabela dCliente. Em vez de retornar apenas a data conforme ela está armazenada (por exemplo, ‘1989-02-12’), queremos retorná-la por extenso(assim: ‘Domingo, 12 de Fevereiro de 1989’)

Podemos fazer isso por meio da função DATENAME */

SELECT * FROM dCliente

SELECT 
	nome_cliente,
	data_de_nascimento,
	DATENAME(DW, data_de_nascimento) + ', ' +
	DATENAME(D, data_de_nascimento) + ' de ' +
	DATENAME(M, data_de_nascimento) + ' de ' +
	DATENAME(YY, data_de_nascimento)
FROM dCliente

/* Porém, para facilitar para gente, nós podemos criar uma function que utilize a DATENAME e retorne este mesmo resultado para qualquer coluna de data de qualquer tabela. Assim, quando formos efetuar a consulta a uma tabela que contenha uma coluna de data que precisemos retornar por extenso (como no caso da coluna data_de_nascimento da tabela dCliente), nós não precisamos recriar todo o código com a DATENAME. Tudo que precisamos fazer é “chamar” dentro do nosso SELECT a função que tivermos criado. Portando, criaremos a função, que chamaremos de fnDataCompleta. */

-- Criando uma função para formatação de data usando a DATENAME

-- 1. Iniciamos com o comando CREATE FUNCTION, damos um nome à function (fnDataCompleta), assim como ao parâmetro que será recebido por ela (no caso @data, que será do tipo DATE);
-- 2. Em seguida, informamos o tipo de dado que a function deverá retornar que, neste caso, será do tipo VARCHAR. Repare que no parâmetro a function receberá um dado do tipo DATE (YYYY-MM-DD), fará o tratamento necessário nesse dado  (cujos comandos serão passados logo mais dentro do bloco de execução que inicia com BEGIN) e retornará um dado do tipo VARCHAR(a string da data por extenso);
-- 3. Depois, abrimos o bloco de execução e, dentro dele, passamos os comandos do que a função deve ser capaz de fazer (no caso, transformar uma data em uma string desta data por extenso);
-- 4.  Finalizamos o bloco de execução com o comando END.

CREATE FUNCTION fnDataCompleta(@data AS DATE)
RETURNS VARCHAR(MAX)
AS
BEGIN
	RETURN DATENAME(DW, @Data) + ', ' +
			DATENAME(D, @Data) + ' de ' +
			DATENAME(M, @Data) + ' de ' +
			DATENAME(YY, @Data)
END

/* Repare que nossa function recém-criada agora está salva na pasta Programação > Funções > Funções com Valor  Escalar, como havíamos mencionado anteriormente.
Note que, ao nome da function, o sistema acrescentou o prefixo “dbo”. Este termo significa “database owner”  (proprietário do banco de dados) e é anexado a todo objeto criado pelo administrador do banco de dados.
Por isso, se tratando de functions, quando formos utilizá-las nas consultas que efetuarmos, devemos sempre nos lembrar de acrescentar o prefixo “dbo.” ao seu nome, caso contrário, o sistema retornará um erro.

Criada nossa function fnDataCompleta, agora podemos utilizá-la todas as vezes que precisarmos pegar um valor do tipo DATE e transformá-lo em uma string dessa data por extenso. 

Então, para executar esse procedimento com a coluna data_de_nascimento da tabela dCliente, podemos fazer como no
 código abaixo */

-- Refazendo o SELECT sem a necessidade de utilizar a função DATENAME varias vezes.
SELECT
	nome_cliente,
	data_de_nascimento,
	[dbo].[fnDataCompleta](data_de_nascimento)
FROM
	dCliente

--  Perceba que informamos o nome da função (dbo.fnDataCompleta) e, entre parênteses, passamos o nome da coluna que servirá de parâmetro para a função. Neste caso, é a coluna  data_de_nascimento da tabela dCliente.
-- Obs: Teremos o mesmo resultado que a consulta anterior, só que dessa vez ficará salvo como uma FUNCTION então, toda vez que precisar realizar uma QUERY neste formato eu poderei utilizar esta FUNCTION ao invés de escrever todo o código.