-- MÓDULO 22 - SQL SERVER - PROCEDURES


/* AULA 06 - Criando uma Procedure com Parâmetro Default

Podemos passar um valor (Default) para um parâmetro. Esse valor default será sempre utilizado caso o usuário não informe nenhum valor para o parâmetro em questão.

Vamos imaginar que queiramos alterar novamente a nossa procedure prListaClientes, para podermos incluir o valor 'M' como default no parâmetro @gen. Assim, caso o usuário não informe nenhum valor, sempre retornaremos os clientes do gênero masculino na consulta efetuada pela procedure. Para isso, alteraremos um detalhe em nosso código.

Essa alteração ocorrerá na primeira linha de comando, quando fomos especificar o parâmetro @gen.

Exemplo 3. Crie uma Procedure que executa um SELECT que recebe um parâmetro de entrada para filtrar a tabela dClientes de acordo com o gênero informado e ano de nascimento informado. */

CREATE OR ALTER PROCEDURE prListaClientes(@gen VARCHAR(MAX)='M', @ano INT)
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

EXECUTE prListaClientes @gen = 'F', @ano = 1989

/* Obs.: Como nossa procedure possui dois parâmetros, precisamos informar no comando EXECUTE os dois parâmetros se quisermos um valor diferente do default no parâmetro @gen ou apenas o parâmetro @ano se quisermos o parâmetro @gen como default. E nesse caso, como teremos que, obrigatoriamente, informar vaores tanto para o parâmetro @gen quanto para o parâmetro @ano, não faz diferença se informamos ou não o nome do parâmetro no comando EXECUTE. */