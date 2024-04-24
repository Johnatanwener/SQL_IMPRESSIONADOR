-- M�DULO 22 - SQL SERVER - PROCEDURES


/* AULA 05 - Criando uma Procedure com mais de 1 par�metro
Suponhamos que agora queremos, l� na nossa procedure prListasClientes, al�m de poder filtrar nossos clientes por g�nero, tamb�m escolher o ano de sua data de nascimento. Para isso,precisaremos alterar alguns detalhes no nosso c�digo.

Vejamos o passo a passo:

- 1. Iniciamos a procedure com o comando CREATEOR ALTER PROCEDURE, a nomeamos, e declaramos os nomes e os tipos de dados dos par�metros que receber�o as informa��es de g�nero e ano de nascimento que ser�o passados pelo usu�rio;
- 2. Abrimos o bloco de execu��o com o comando BEGIN;
- 3. Dentro do bloco de execu��o, passamos todas as instru��es da procedure. No caso, o nosso SELECT � tabela dCliente(observe que no filtro que fizemos com o comando WHERE, em vez de estabelecer que genero = �M� ou genero = �F�, informamos o nome do par�metro que criamos na primeira linha do nosso c�digo, junto ao comando CREATE OR ALTER  PROCEDURE: @gen. O mesmo vale para o filtro YEAR(data_de_nascimento), pois n�o informamos um ano qualquer,  mas sim o par�metro que criamos: @ano);
- 4. Finalizamos o bloco de execu��o e a procedure com o comando END;

Para executar nossa procedure, utilizamos o comando EXECUTE seguido do nome da procedure e das informa��es que dever�o ser passadas aos par�metros @gen e @ano.

Exemplo 3. Crie uma Procedure que executa um SELECT que recebe um par�metro de entrada para filtrar a tabela dClientes de acordo com o g�nero informado e ano de nascimento informado. */
CREATE OR ALTER PROCEDURE prListaClientes(@gen VARCHAR(MAX), @ano INT)
AS
BEGIN

	SELECT
		nome_cliente,
		genero,
		data_de_nascimento,
		cpf
	FROM dCliente
	WHERE genero = @gen AND YEAR(data_de_nascimento) = @ano


END

EXECUTE prListaClientes 'M', 1989

-- Agora, que toda vez que precisarmos visualizar o resultado dessa mesma consulta, basta utilizarmos o comando acima e executar a procedure prListaClientes, em vez de ter que recriar todo o c�digo novamente.