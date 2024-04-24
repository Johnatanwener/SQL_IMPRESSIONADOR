-- M�dulo 11 - SQL SERVER - FUN��ES CONDICIONAIS


/* AULA 10 - IIF Composto
� poss�vel utilizar um IIF dentro de outro IFF, criando o que chamamos de IFF composto. Com essa aplica��o, tratamos v�rios resultados poss�veis, de acordo com mais de um teste l�gico.

No exemplo abaixo, queremos fazer uma consulta � tabela DimProduct e retornar o respons�vel pelos estoques dos produtos, de acordo com o StockTypeName. Como temos 3 tipos de estoque e consequentemente 3 respons�veis diferentes, teremos que utilizar mais de 1 IFF para conseguir cobrir todas as situa��es poss�veis. */

-- Exemplo: Existem 3 tipos de estoque: High, Mid e Low. Fa�a um SELECT contendo as colunas de ProductKey, ProductName, StockTypeName e Nome do respons�vel pelo produto, de acordo com o tipo de estoque. A regra dever� ser a seguinte:
-- Jo�o � respons�vel pelos produtos High
-- Maria � respons�vel pelos produtos Mid
-- Luis � respons�vel pelos produtos Low

SELECT
	ProductKey AS 'ID Produto',
	ProductName AS 'Nome Produto',
	iif(
		StockTypeName = 'High',
		'Jo�o',
		IIF(
			StockTypeName = 'Mid',
			'Maria',
			'Luis')
			) AS 'Respons�vel'

FROM
	DimProduct