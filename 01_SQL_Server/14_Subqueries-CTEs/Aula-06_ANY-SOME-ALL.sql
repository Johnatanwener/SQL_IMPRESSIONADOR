-- Módulo 14 - SQL SERVER - Subqueries e CTE's


/*AULA 06 - ANY, SOME e ALL
Os operadores ANY e SOME são equivalentes e permitem realizar uma comparação entre um único valor de uma coluna e um intervalo de outros valors. O =ANY e o =SOME são equivalentes. Quando usados com o sinal lógico '=', eles possuem a mesma finalidade do operador IN, permitindo retornar todas as linhas que sejam iguais à lista de valores especificados. */

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
	(5, 'André', 24, 'M'),
	(6, 'Luisa', 25, 'F')

SELECT * FROM funcionarios

-- Selecione os funcionários do sexo masculino (MAS, utilizando a coluna de IDADE para isso)
SELECT * FROM funcionarios
WHERE idade IN (21, 23, 24)

SELECT * FROM funcionarios
WHERE idade IN (SELECT idade FROM funcionarios WHERE sexo = 'M')

/* = ANY(valor1, valor2, valor3) :
Equivalente ao IN, retorna as linhas da tabela que sejam iguais ao valor1, OU valor2, OU valor3 */
SELECT * FROM funcionarios
WHERE idade = ANY (SELECT idade FROM funcionarios WHERE sexo = 'M')

/* > ANY(valor1, valor2, valor3) :
Retorna as linhas da tabela com valores maiores que o valor1, OU valor2, OU valor3. Ou seja, maior que o mínimo dos valores */
SELECT * FROM funcionarios
WHERE idade > ANY (SELECT idade FROM funcionarios WHERE sexo = 'M')

/* < ANY(valor1, valor2, valor3) :
Retorna as linhas da tabela com valores maiores que o valor1, OU valor2, OU valor3. Ou seja, maior que o máximo dos valores */
SELECT * FROM funcionarios
WHERE idade < ANY (SELECT idade FROM funcionarios WHERE sexo = 'M')

-- Obs.: O ANY é = ao SOME. Ou seja, poderia utilizar o SOME em qualquer uma das opções acima, ao invés de ANY.

/* 
O operador ALL também permite uma comparação entre valores especificados, mas para que a consulta retorne algum resultado, é necessário que o valor comparado seja maior ou menor do que TODOS os valores da lista. (Obs.: Dificilmente utilizamos o =ALL pois estaríamos comparando um valor e esperando que ele fosse igual a todos os valores da lista. A menos que todos os valores da lista fossem iguais, o =ALL não faria sentido)

Exemplo:
> ALL(valor1, valor2, valor3) :
	Retorna as linhas da tabela com valores maiores que o valor1, E valor2, E valor3. Ou seja, maior que o máximo dos valores */
SELECT * FROM funcionarios
WHERE idade < ALL (SELECT idade FROM funcionarios WHERE sexo = 'M')

/* < ALL(valor1, valor2, valor3) :
Retorna as linhas da tabela com valores menores que o valor1, E valor2, E valor3. Ou seja, menor que o mínimo dos valores
*/
SELECT * FROM funcionarios
WHERE idade > ALL (SELECT idade FROM funcionarios WHERE sexo = 'M')