-- M�dulo 14 - SQL SERVER - Subqueries e CTE's


/*AULA 06 - ANY, SOME e ALL
Os operadores ANY e SOME s�o equivalentes e permitem realizar uma compara��o entre um �nico valor de uma coluna e um intervalo de outros valors. O =ANY e o =SOME s�o equivalentes. Quando usados com o sinal l�gico '=', eles possuem a mesma finalidade do operador IN, permitindo retornar todas as linhas que sejam iguais � lista de valores especificados. */

CREATE TABLE funcionarios(
id_funcionario INT,
nome VARCHAR(50),
idade INT,
sexo VARCHAR(50))

INSERT INTO funcionarios(id_funcionario, nome, idade, sexo)
VALUES	
	(1, 'Julia', 20, 'F'),
	(2, 'Daniel', 21, 'M'),
	(3, 'Amanda', 22, 'F'),
	(4, 'Pedro', 23, 'M'),
	(5, 'Andr�', 24, 'M'),
	(6, 'Luisa', 25, 'F')

SELECT * FROM funcionarios

-- Selecione os funcion�rios do sexo masculino (MAS, utilizando a coluna de IDADE para isso)
SELECT * FROM funcionarios
WHERE idade IN (21, 23, 24)

SELECT * FROM funcionarios
WHERE idade IN (SELECT idade FROM funcionarios WHERE sexo = 'M')

/* = ANY(valor1, valor2, valor3) :
Equivalente ao IN, retorna as linhas da tabela que sejam iguais ao valor1, OU valor2, OU valor3 */
SELECT * FROM funcionarios
WHERE idade = ANY (SELECT idade FROM funcionarios WHERE sexo = 'M')

/* > ANY(valor1, valor2, valor3) :
Retorna as linhas da tabela com valores maiores que o valor1, OU valor2, OU valor3. Ou seja, maior que o m�nimo dos valores */
SELECT * FROM funcionarios
WHERE idade > ANY (SELECT idade FROM funcionarios WHERE sexo = 'M')

/* < ANY(valor1, valor2, valor3) :
Retorna as linhas da tabela com valores maiores que o valor1, OU valor2, OU valor3. Ou seja, maior que o m�ximo dos valores */
SELECT * FROM funcionarios
WHERE idade < ANY (SELECT idade FROM funcionarios WHERE sexo = 'M')

-- Obs.: O ANY � = ao SOME. Ou seja, poderia utilizar o SOME em qualquer uma das op��es acima, ao inv�s de ANY.

/* 
O operador ALL tamb�m permite uma compara��o entre valores especificados, mas para que a consulta retorne algum resultado, � necess�rio que o valor comparado seja maior ou menor do que TODOS os valores da lista. (Obs.: Dificilmente utilizamos o =ALL pois estar�amos comparando um valor e esperando que ele fosse igual a todos os valores da lista. A menos que todos os valores da lista fossem iguais, o =ALL n�o faria sentido)

Exemplo:
> ALL(valor1, valor2, valor3) :
	Retorna as linhas da tabela com valores maiores que o valor1, E valor2, E valor3. Ou seja, maior que o m�ximo dos valores */
SELECT * FROM funcionarios
WHERE idade < ALL (SELECT idade FROM funcionarios WHERE sexo = 'M')

/* < ALL(valor1, valor2, valor3) :
Retorna as linhas da tabela com valores menores que o valor1, E valor2, E valor3. Ou seja, menor que o m�nimo dos valores
*/
SELECT * FROM funcionarios
WHERE idade > ALL (SELECT idade FROM funcionarios WHERE sexo = 'M')