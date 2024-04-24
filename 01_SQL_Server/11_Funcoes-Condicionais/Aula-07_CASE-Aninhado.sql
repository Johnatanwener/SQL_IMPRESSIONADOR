-- Módulo 11 - SQL SERVER - FUNÇÕES CONDICIONAIS


/* AULA 07 - CASE Aninhado
O CASE Aninhado nada mais é do que um CASE dentreo de outro CASE. Em algumas situações ele pode ser muito útil.

No exemplo 1 abaixo, criamos uma lógica onde, de acordo com a quantidade de funcionários da loja (EmployeeCount) estabelecemos um status para aquela loja.

- Acima de 40 funcionários
- Entre 30 e 39 funcionários
- Entre 20 e 29 funcionários
- Abaixo de 19 funcionários

Porém, especificamente para as lojas que têm mais de 40 funcionários, queremos fazer um novo teste e dividir em 'LOJA ABERTA' ou 'LOJA FECHADA'. */

SELECT
	StoreKey,
	StoreName,
	StoreType,
	Status,
	EmployeeCount,
	CASE
		WHEN EmployeeCount >= 40 THEN
			CASE
				WHEN Status = 'Off' THEN 'LOJA FECHADA: Acima de 40 funcionários'
				WHEN Status = 'On' THEN 'LOJA ABERTA: Acima de 40 funcionário'
				END
		WHEN EmployeeCount >= 30 THEN 'Entre 30 e 39 funcionários'
		WHEN EmployeeCount >= 20 THEN 'Entre 20 e 29 funcionários'
		ELSE 'Abaixo de 19 funcionários'
	END AS 'Categoria'
FROM
	DimStore

-- No exemplo 2 abaixo, criamos uma lógica onde, de acordo com o cargo (Title) iremos distribuir uma porcentagem de bonus. Porém

-- 4 Cargos (Title):
-- Sales Group Manager
-- Sales Region Manager
-- Sales State Manager
-- Sales Store Manager

-- Assalariado (SalariedFlag)?
-- SalariedFlag = 0: não é assalariado
-- SalariedFlag = 1: é assalariado

-- Situação: Cálculo do bônus
-- Sales Group Manager: Se for assalariado, 20%; Se não, 15%.
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
	END AS 'Bônus'
FROM
	DimEmployee