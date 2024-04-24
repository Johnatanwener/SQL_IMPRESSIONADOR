-- M�dulo 11 - SQL SERVER - FUN��ES CONDICIONAIS


-- AULA 04 - CASE WHEN WHEN... ELSE (Explica��o)

CASE
	WHEN teste_logico1 THEN 'resultado1'
	WHEN teste_logico2 THEN 'resultado2'
	ELSE 'resultado3'
END

/* Exemplo 1:
Crie um c�digo para verificar a nota do aluno e determinar a situa��o:
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
Classifique o produto de acordo com o seu pre�o:
- Pre�o >= 40000: Luxo
- Pre�o >= 10000 e Pre�o < 40000: Econ�mico
- Pre�o < 10000: B�sico
*/

DECLARE @varPreco FLOAT
SET @varPreco = 30000

SELECT
	CASE
		WHEN @varPreco >= 40000 THEN 'Luxo'
		WHEN @varPreco >= 10000 THEN 'Econ�mico'
		ELSE 'B�sico'
	END

------------------------------

/* AULA 05 - CASE WHEN WHEN... ELSE (Exemplo)
No exemplo anterior, vimos como utilizar o CASE com apenas um teste l�gico. Ou seja, verificamos apenas uma vez o dexo do cliente. Caso o g�nero n�o fosse 'M', j� assumimos que seria 'F'. Por�m, alguns clientes na verdade s�o empresas, e na coluna de Gender o que temos � o valor NULL.
Neste caso, se utilizarmos o CASE criado no exemplo anterior, todas as empresas ficariam como o sexo 'Feminino'.
O ideal seria fazer um novo para verificar se, caso o sexo n�o seja nem 'M', e nem 'F', a� sim podemos considerar como 'Empresa'.

Exemplo: Crie uma coluna para substituir o 'M' por 'Masculino' e 'F' por 'Feminino'. Verifique se ser� necess�rio fazer alguma corre��o. */

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