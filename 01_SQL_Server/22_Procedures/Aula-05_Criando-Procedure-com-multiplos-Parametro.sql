-- MÓDULO 22 - SQL SERVER - PROCEDURES


/* AULA 05 - Criando uma Procedure com mais de 1 parâmetro
Suponhamos que agora queremos, lá na nossa procedure prListasClientes, além de poder filtrar nossos clientes por gênero, também escolher o ano de sua data de nascimento. Para isso,precisaremos alterar alguns detalhes no nosso código.

Vejamos o passo a passo:

- 1. Iniciamos a procedure com o comando CREATEOR ALTER PROCEDURE, a nomeamos, e declaramos os nomes e os tipos de dados dos parâmetros que receberão as informações de gênero e ano de nascimento que serão passados pelo usuário;
- 2. Abrimos o bloco de execução com o comando BEGIN;
- 3. Dentro do bloco de execução, passamos todas as instruções da procedure. No caso, o nosso SELECT à tabela dCliente(observe que no filtro que fizemos com o comando WHERE, em vez de estabelecer que genero = ‘M’ ou genero = ‘F’, informamos o nome do parâmetro que criamos na primeira linha do nosso código, junto ao comando CREATE OR ALTER  PROCEDURE: @gen. O mesmo vale para o filtro YEAR(data_de_nascimento), pois não informamos um ano qualquer,  mas sim o parâmetro que criamos: @ano);
- 4. Finalizamos o bloco de execução e a procedure com o comando END;

Para executar nossa procedure, utilizamos o comando EXECUTE seguido do nome da procedure e das informações que deverão ser passadas aos parâmetros @gen e @ano.

Exemplo 3. Crie uma Procedure que executa um SELECT que recebe um parâmetro de entrada para filtrar a tabela dClientes de acordo com o gênero informado e ano de nascimento informado. */
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

-- Agora, que toda vez que precisarmos visualizar o resultado dessa mesma consulta, basta utilizarmos o comando acima e executar a procedure prListaClientes, em vez de ter que recriar todo o código novamente.