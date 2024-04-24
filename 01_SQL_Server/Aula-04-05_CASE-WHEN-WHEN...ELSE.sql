-- Módulo 11 - SQL SERVER - FUNÇÕES CONDICIONAIS


-- AULA 04 - CASE WHEN WHEN... ELSE (Explicação)

CASE
	WHEN teste_logico1 THEN 'resultado1'
	WHEN teste_logico2 THEN 'resultado2'
	ELSE 'resultado3'
END

/* Exemplo 1:
Crie um código para verificar a nota do aluno e determinar a situação:
- Aprovado: nota maior ou igual a 6
- Prova final: noa entre 4 e 6
- Reprovado: nota abaixo de 4
*/

DECLARE @varNota FLOAT
SET @varNota = 8.5

SELECT
CASE
	WHEN @varNota >= 6 THEN 'Aprovado'
	WHEN @varNota >= 4 THEN 'Prova final'
	ELSE 'Reprovado'
END


/* Exemplo 2: 
Classifique o produto de acordo com o seu preço:
- Preço >= 40000: Luxo
- Preço >= 10000 e Preço < 40000: Econômico
- Preço < 10000: Básico
*/

DECLARE @varPreco FLOAT
SET @varPreco = 30000

SELECT
	CASE
		WHEN @varPreco >= 40000 THEN 'Luxo'
		WHEN @varPreco >= 10000 THEN 'Econômico'
		ELSE 'Básico'
	END

------------------------------

/* AULA 05 - CASE WHEN WHEN... ELSE (Exemplo)
No exemplo anterior, vimos como utilizar o CASE com apenas um teste lógico. Ou seja, verificamos apenas uma vez o dexo do cliente. Caso o gênero não fosse 'M', já assumimos que seria 'F'. Porém, alguns clientes na verdade são empresas, e na coluna de Gender o que temos é o valor NULL.
Neste caso, se utilizarmos o CASE criado no exemplo anterior, todas as empresas ficariam como o sexo 'Feminino'.
O ideal seria fazer um novo para verificar se, caso o sexo não seja nem 'M', e nem 'F', aí sim podemos considerar como 'Empresa'.

Exemplo: Crie uma coluna para substituir o 'M' por 'Masculino' e 'F' por 'Feminino'. Verifique se será necessário fazer alguma correção. */

SELECT * FROM DimCustomer

SELECT
	CustomerKey AS 'ID do Cliente',
	FirstName AS 'Nome',
	Gender AS 'Sexo',
	CASE
		WHEN Gender = 'M' THEN 'Masculino'
		WHEN Gender = 'F' THEN 'Feminino'
		ELSE 'Empresa'
	END AS 'Sexo CASE'
FROM
	DimCustomer