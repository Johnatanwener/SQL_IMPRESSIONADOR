-- MÓDULO 22 - SQL SERVER - PROCEDURES


/* AULA 04 - Criando uma Procedure Com 1 Parâmetro
 Suponhamos que queiramos criar uma procedure para armazenar uma consulta à tabela dCliente que retorne apenas os clientes do sexo masculino ou feminino, a depender do que for informado pelo usuário.
Exemplo 2. Crie uma Procedure que executa um SELECT que recebe um parâmetro de entrada para filtrar a tabela dClientes de acordo com o gênero informado. */
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

/* Repare que iniciamos com a junção dos comandos CREATE OR ALTER PROCEDURE. Como explicado no módulo de Functions, fazendo desta forma, o sistema será capaz de verificar:

- A. Se a procedure não existe, então ele criará uma nova procedure por meio do comando CREATE;
- B. Se a procedure já existe, assim ele alterará a procedure já existente por meio do comando ALTER. 

Vejamos o passo a passo

1. Iniciamos a procedure como comando CREATE OR ALTER PROCEDURE, a nomeamos, e declaramos o nome e o tipo de dado do parâmetro que receberá a informação de gênero que será passada pelo usuário;
2. Abrimos o bloco de execução com o comando BEGIN;
3. Dentro do bloco de execução, passamos todas as instruções da procedure. No caso, o nosso SELECT à tabela dCliente(observe que no filtro que fizemos com o comando WHERE, em vez de estabelecer que genero é = ‘M’ ou genero = ‘F’, informamos o nome do parâmetro que criamos na primeira linha do nosso código, junto ao comando CREATE OR ALTER PROCEDURE :@gen )
4. Finalizamos o bloco de execução e a procedure com o comando END.

Para executar nossa procedure, utilizamos o comando EXECUTE seguido do nome da procedure e da informação que deverá ser passada ao parâmetro @gen (no caso, 'M' para retornar todos os clientes do gênero masculino ou 'F' para retornar todas as clientes do gênero feminino) */