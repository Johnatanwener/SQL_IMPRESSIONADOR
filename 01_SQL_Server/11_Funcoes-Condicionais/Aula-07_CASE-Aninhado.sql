-- M�dulo 11 - SQL SERVER - FUN��ES CONDICIONAIS


/* AULA 07 - CASE Aninhado
O CASE Aninhado nada mais � do que um CASE dentreo de outro CASE. Em algumas situa��es ele pode ser muito �til.

No exemplo 1 abaixo, criamos uma l�gica onde, de acordo com a quantidade de funcion�rios da loja (EmployeeCount) estabelecemos um status para aquela loja.

- Acima de 40 funcion�rios
- Entre 30 e 39 funcion�rios
- Entre 20 e 29 funcion�rios
- Abaixo de 19 funcion�rios

Por�m, especificamente para as lojas que t�m mais de 40 funcion�rios, queremos fazer um novo teste e dividir em 'LOJA ABERTA' ou 'LOJA FECHADA'. */

SELECT
	StoreKey,
	StoreName,
	StoreType,
	Status,
	EmployeeCount,
	CASE
		WHEN EmployeeCount >= 40 THEN
			CASE
				WHEN Status = 'Off' THEN 'LOJA FECHADA: Acima de 40 funcion�rios'
				WHEN Status = 'On' THEN 'LOJA ABERTA: Acima de 40 funcion�rio'
				END
		WHEN EmployeeCount >= 30 THEN 'Entre 30 e 39 funcion�rios'
		WHEN EmployeeCount >= 20 THEN 'Entre 20 e 29 funcion�rios'
		ELSE 'Abaixo de 19 funcion�rios'
	END AS 'Categoria'
FROM
	DimStore

-- No exemplo 2 abaixo, criamos uma l�gica onde, de acordo com o cargo (Title) iremos distribuir uma porcentagem de bonus. Por�m

-- 4 Cargos (Title):
-- Sales Group Manager
-- Sales Region Manager
-- Sales State Manager
-- Sales Store Manager

-- Assalariado (SalariedFlag)?
-- SalariedFlag = 0: n�o � assalariado
-- SalariedFlag = 1: � assalariado

-- Situa��o: C�lculo do b�nus
-- Sales Group Manager: Se for assalariado, 20%; Se n�o, 15%.
-- Sales Region Manager: 15%
-- Sales State Manager: 7%
-- Sales Store Manager: 2%

SELECT
	FirstName,
	Title,
	SalariedFlag,
	CASE
		WHEN Title = 'Sales Group Manager' THEN
		CASE	
			WHEN SalariedFlag = 1 THEN 0.3
			ELSE 0.2
		END 
		WHEN Title = 'Sales Region Manager' THEN 0.15
		WHEN Title = 'Sales State Manager' THEN 0.07
		ELSE 0.02
	END AS 'B�nus'
FROM
	DimEmployee