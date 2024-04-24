-- Módulo 11 - SQL SERVER - FUNÇÕES CONDICIONAIS


/* AULA 10 - IIF Composto
É possível utilizar um IIF dentro de outro IFF, criando o que chamamos de IFF composto. Com essa aplicação, tratamos vários resultados possíveis, de acordo com mais de um teste lógico.

No exemplo abaixo, queremos fazer uma consulta à tabela DimProduct e retornar o responsável pelos estoques dos produtos, de acordo com o StockTypeName. Como temos 3 tipos de estoque e consequentemente 3 responsáveis diferentes, teremos que utilizar mais de 1 IFF para conseguir cobrir todas as situações possíveis. */

-- Exemplo: Existem 3 tipos de estoque: High, Mid e Low. Faça um SELECT contendo as colunas de ProductKey, ProductName, StockTypeName e Nome do responsável pelo produto, de acordo com o tipo de estoque. A regra deverá ser a seguinte:
-- João é responsável pelos produtos High
-- Maria é responsável pelos produtos Mid
-- Luis é responsável pelos produtos Low

SELECT
	ProductKey AS 'ID Produto',
	ProductName AS 'Nome Produto',
	iif(
		StockTypeName = 'High',
		'João',
		IIF(
			StockTypeName = 'Mid',
			'Maria',
			'Luis')
			) AS 'Responsável'

FROM
	DimProduct