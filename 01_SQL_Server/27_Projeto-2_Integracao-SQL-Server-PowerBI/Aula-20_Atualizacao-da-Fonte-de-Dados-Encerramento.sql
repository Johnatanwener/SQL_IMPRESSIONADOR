-- MÓDULO 27 - SQL SERVER - INTEGRAÇÃO SQL SERVER - POWER BI

------------------------------
-- AULA 07 - Aba Geral_ Criando os Cartões
-- AULA 08 - Observação sobre a diferença na quantidade vendida
-- AULA 09 - Aba Geral - Gráfico Receita Total e Lucro Total por Mês
-- AULA 10 - Aba Geral - Gráfico Lucro Total por País
-- AULA 11 - Aba Geral - Gráfico Vendas por Mês
-- AULA 12 - Aba Geral - Gráfico Margem de Lucro
-- AULA 13 - Aba Geral - Configurando Filtro de Ano
-- AULA 14 - Aba Clientes - Criando os Cartões
-- AULA 15 - Aba Clientes - Total Vendido por País
-- AULA 16 - Aba Clientes - Clientes por País
-- AULA 17 - Aba Clientes - Clientes por Gênero
-- AULA 18 - Aba Clientes - Vendas por Categoria
-- AULA 19 - Configurando a Navegação de Página

------------------------------
/* AULA 20 - Atualização da Fonte de Dados e Encerramento
Para encerrar este módulo, vamos entender como fazemos para atualizar o nosso relatório para que sejam carregados os dados atuais do banco de dados AdventureWorksDW2014. Para isso, vamos retornar ao SSMS.

Você deve se recordar que, no módulo anterior, de integração do SQL Server com o Excel, havíamos alterado o valor da coluna OrderQuantity da tabela FactInternetSales de 1 para 20 em alguns pedidos. Por isso atualmente nossa Contagem da Quantidade Vendida está em 68.511 ao invés de 60.398. Para solucionar esse 'problema', vamos atualizar nossa tabela FactInternetSales para que mostre os valores originais do nosso banco de dados. */

BEGIN TRANSACTION T1
	
	UPDATE FactInternetSales
	SET OrderQuantity = 1

COMMIT TRANSACTION T1

-- Dessa forma, teremos a coluna OrderQuantity novamente preenchida com o valor 1 em todas as 60.398 linhas.

SELECT * FROM FactInternetSales

-- E para atualizar as informações no PowerBI, iremos navegar até o menu Página Inicial e procurar a opção Atualizar. Uma vez que clicarmos nesta opção o PowerBi irá se conectar novamente ao Banco de Dados AdventureWorksDW2014 e atualizar nossa visualização.

-- E assim, chegamos ao fim do módulo de Integração do SQL Server com o Power BI