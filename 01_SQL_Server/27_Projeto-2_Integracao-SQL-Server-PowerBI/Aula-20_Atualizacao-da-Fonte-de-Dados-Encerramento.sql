-- M�DULO 27 - SQL SERVER - INTEGRA��O SQL SERVER - POWER BI

------------------------------
-- AULA 07 - Aba Geral_ Criando os Cart�es
-- AULA 08 - Observa��o sobre a diferen�a na quantidade vendida
-- AULA 09 - Aba Geral - Gr�fico Receita Total e Lucro Total por M�s
-- AULA 10 - Aba Geral - Gr�fico Lucro Total por Pa�s
-- AULA 11 - Aba Geral - Gr�fico Vendas por M�s
-- AULA 12 - Aba Geral - Gr�fico Margem de Lucro
-- AULA 13 - Aba Geral - Configurando Filtro de Ano
-- AULA 14 - Aba Clientes - Criando os Cart�es
-- AULA 15 - Aba Clientes - Total Vendido por Pa�s
-- AULA 16 - Aba Clientes - Clientes por Pa�s
-- AULA 17 - Aba Clientes - Clientes por G�nero
-- AULA 18 - Aba Clientes - Vendas por Categoria
-- AULA 19 - Configurando a Navega��o de P�gina

------------------------------
/* AULA 20 - Atualiza��o da Fonte de Dados e Encerramento
Para encerrar este m�dulo, vamos entender como fazemos para atualizar o nosso relat�rio para que sejam carregados os dados atuais do banco de dados AdventureWorksDW2014. Para isso, vamos retornar ao SSMS.

Voc� deve se recordar que, no m�dulo anterior, de integra��o do SQL Server com o Excel, hav�amos alterado o valor da coluna OrderQuantity da tabela FactInternetSales de 1 para 20 em alguns pedidos. Por isso atualmente nossa Contagem da Quantidade Vendida est� em 68.511 ao inv�s de 60.398. Para solucionar esse 'problema', vamos atualizar nossa tabela FactInternetSales para que mostre os valores originais do nosso banco de dados. */

BEGIN TRANSACTION T1
	
	UPDATE FactInternetSales
	SET OrderQuantity = 1

COMMIT TRANSACTION T1

-- Dessa forma, teremos a coluna OrderQuantity novamente preenchida com o valor 1 em todas as 60.398 linhas.

SELECT * FROM FactInternetSales

-- E para atualizar as informa��es no PowerBI, iremos navegar at� o menu P�gina Inicial e procurar a op��o Atualizar. Uma vez que clicarmos nesta op��o o PowerBi ir� se conectar novamente ao Banco de Dados AdventureWorksDW2014 e atualizar nossa visualiza��o.

-- E assim, chegamos ao fim do m�dulo de Integra��o do SQL Server com o Power BI