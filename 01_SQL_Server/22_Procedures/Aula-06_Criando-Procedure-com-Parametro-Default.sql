-- M�DULO 22 - SQL SERVER - PROCEDURES


/* AULA 06 - Criando uma Procedure com Par�metro Default

Podemos passar um valor (Default) para um par�metro. Esse valor default ser� sempre utilizado caso o usu�rio n�o informe nenhum valor para o par�metro em quest�o.

Vamos imaginar que queiramos alterar novamente a nossa procedure prListaClientes, para podermos incluir o valor 'M' como default no par�metro @gen. Assim, caso o usu�rio n�o informe nenhum valor, sempre retornaremos os clientes do g�nero masculino na consulta efetuada pela procedure. Para isso, alteraremos um detalhe em nosso c�digo.

Essa altera��o ocorrer� na primeira linha de comando, quando fomos especificar o par�metro @gen.

Exemplo 3. Crie uma Procedure que executa um SELECT que recebe um par�metro de entrada para filtrar a tabela dClientes de acordo com o g�nero informado e ano de nascimento informado. */

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

/* Obs.: Como nossa procedure possui dois par�metros, precisamos informar no comando EXECUTE os dois par�metros se quisermos um valor diferente do default no par�metro @gen ou apenas o par�metro @ano se quisermos o par�metro @gen como default. E nesse caso, como teremos que, obrigatoriamente, informar vaores tanto para o par�metro @gen quanto para o par�metro @ano, n�o faz diferen�a se informamos ou n�o o nome do par�metro no comando EXECUTE. */