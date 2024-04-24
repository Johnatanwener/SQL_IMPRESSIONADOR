-- MÓDULO 22 - SQL SERVER - PROCEDURES


/* AULA 03 - Criando uma Procedure Sem Parâmetros

 Suponhamos que desejamos criar uma procedure para armazenar uma consulta à tabela dGerente.

 1. Iniciamos a procedure com o comando CREATE PROCEDURE e damos um nome a ela;
 2. Abrimos o bloco de execução com o comando BEGIN;
 3. Dentro do bloco de execução, passamos todas as instruções da procedure. No caso, o nosso SELECT à tabela dGerente;
 4. Finalizamos o bloco de execução e a procedure com o comando END.
 5. Para executar nossa procedure, utilizamos o seguinte comando:


Exemplo 1. Crie uma Procedure que executa um SELECT simples (sem parâmetros). */

USE Exercicios
Select * FROM dCliente
SELECT * FROM dGerente
SELECT * FROM fContratos

CREATE PROCEDURE prOrdenaGerentes
AS
BEGIN

	SELECT
		id_gerente,
		nome_gerente,
		salario
	FROM dGerente
	ORDER BY salario DESC

END

EXECUTE prOrdenaGerentes

-- Agora, toda vez que precisarmos visualizar o resultado dessa mesma consulta, basta utilizarmos o comando  acima e executar a procedure prOrdenaGerentes, em vez de ter que recriar todo o código novamente.