-- M�DULO 22 - SQL SERVER - PROCEDURES


/* AULA 04 - Criando uma Procedure Com 1 Par�metro
 Suponhamos que queiramos criar uma procedure para armazenar uma consulta � tabela dCliente que retorne apenas os clientes do sexo masculino ou feminino, a depender do que for informado pelo usu�rio.
Exemplo 2. Crie uma Procedure que executa um SELECT que recebe um par�metro de entrada para filtrar a tabela dClientes de acordo com o g�nero informado. */
SELECT * FROM dCliente

CREATE OR ALTER PROCEDURE prListaClientes(@gen VARCHAR(MAX))
AS
BEGIN

	SELECT
		nome_cliente,
		genero,
		data_de_nascimento,
		cpf
	FROM dCliente
	WHERE genero = @gen

END

EXECUTE prListaClientes 'M'

/* Repare que iniciamos com a jun��o dos comandos CREATE OR ALTER PROCEDURE. Como explicado no m�dulo de Functions, fazendo desta forma, o sistema ser� capaz de verificar:

- A. Se a procedure n�o existe, ent�o ele criar� uma nova procedure por meio do comando CREATE;
- B. Se a procedure j� existe, assim ele alterar� a procedure j� existente por meio do comando ALTER. 

Vejamos o passo a passo

1. Iniciamos a procedure como comando CREATE OR ALTER PROCEDURE, a nomeamos, e declaramos o nome e o tipo de dado do par�metro que receber� a informa��o de g�nero que ser� passada pelo usu�rio;
2. Abrimos o bloco de execu��o com o comando BEGIN;
3. Dentro do bloco de execu��o, passamos todas as instru��es da procedure. No caso, o nosso SELECT � tabela dCliente(observe que no filtro que fizemos com o comando WHERE, em vez de estabelecer que genero � = �M� ou genero = �F�, informamos o nome do par�metro que criamos na primeira linha do nosso c�digo, junto ao comando CREATE OR ALTER PROCEDURE :@gen )
4. Finalizamos o bloco de execu��o e a procedure com o comando END.

Para executar nossa procedure, utilizamos o comando EXECUTE seguido do nome da procedure e da informa��o que dever� ser passada ao par�metro @gen (no caso, 'M' para retornar todos os clientes do g�nero masculino ou 'F' para retornar todas as clientes do g�nero feminino) */