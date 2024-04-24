-- MÓDULO 27 - SQL SERVER - INTEGRAÇÃO SQL SERVER - POWER BI


/* AULA 01 - Apresentação
Nesse módulo, aprenderemos como inegrar o SQL Server com o Power BI.

Iremos desenvolver um projeto com o objetivo final de apresentar no Power BI um Dashboard Comercial com informações vindas do banco de dados Adventure Works, cuja informações estarão armazenadas no SQL Server. */

------------------------------
/* AULA 02 - Definindo os KPIs do Projeto

Em nosso projeto, utilizaremos o banco de dados AdventureWorksDW2014 que utilizamos no módulo anterior.

Em nosso relatório teremos duas abas: Aba GERAL e Aba Clientes, além da Capa.

- Aba GERAL
1. Receita Total							5. Receita Total e Lucro Total por Mês
2. Quantidade Vendida						6. Margem de Lucro
3. Total de Categorias de Produtos			7. Quantidade Vendida por Mês
4. Quantidade de Clientes					8. Lucro por País

- Aba CLIENTE
1. Vendas por País							3. Vendas por Gênero
2. Clientes por País						4. Vendas por Categoria
*/

------------------------------
-- AULA 03 - Definindo as Tabelas e Colunas a serem usadas

SELECT * FROM FactInternetSales
SELECT * FROM DimProductCategory
SELECT * FROM DimCustomer
SELECT * FROM DimGeography

-- COLUNAS
-- SalesOrderNumber                    (FactInternetSales)
-- OrderDate                           (FactInternetSales)
-- EnglishProductCategoryName          (DimProductCategory) ****
-- CustomerKey                         (DimCustomer)
-- FirstName + ' ' + LastName          (DimCustomer)
-- Gender                              (DimCustomer)
-- EnglishCountryRegionName            (DimGeography)
-- OrderQuantity                       (FactInternetSales)
-- SalesAmount                         (FactInternetSales)
-- TotalProductCost                    (FactInternetSales)
-- SalesAmount - TotalProductCost      (FactInternetSales)

------------------------------
-- AULA 04 - Criando o código da view RESULTADOS_ADW
-- Nesta aula criaremos o código da nossa View RESULTADOS_ADW. 

CREATE OR ALTER VIEW RESULTADOS_ADW AS
SELECT
	fis.SalesOrderNumber AS 'Nº PEDIDO',
	fis.OrderDate AS 'DATA PEDIDO',
	dpc.EnglishProductCategoryName AS 'CATEGORIA PRODUTO',
	fis.CustomerKey AS 'ID CLIENTE',
	dc.FirstName + ' ' + dc.LastName AS 'NOME CLIENTE',
	REPLACE(REPLACE(dc.Gender, 'M', 'Masculino'), 'F', 'Feminino') AS 'SEXO',
	dg.EnglishCountryRegionName AS 'PAÍS',
	fis.OrderQuantity AS 'QTD. VENDIDA',
	fis.SalesAmount AS 'RECEITA VENDA',
	fis.TotalProductCost AS 'CUSTO VENDA',
	fis.SalesAmount - fis.TotalProductCost AS 'LUCRO VENDA'
FROM FactInternetSales fis
INNER JOIN DimProduct dp ON fis.ProductKey = dp.ProductKey
	INNER JOIN DimProductSubcategory dps ON dp.ProductSubcategoryKey = dps.ProductSubcategoryKey
		INNER JOIN DimProductCategory dpc ON dps.ProductCategoryKey = dpc.ProductCategoryKey
INNER JOIN DimCustomer dc ON fis.CustomerKey = dc.CustomerKey
	INNER JOIN DimGeography dg ON dc.GeographyKey = dg.GeographyKey

SELECT * FROM RESULTADOS_ADW

------------------------------
/* AULA 05 - Conectando SQL Server ao Power BI
Se ainda não tiver o Power BI instalado no seu computador, clique no link abaixo para assistir o vídeo que ensina fazer o download e a instalação do Power BI.

Link: https://www.youtube.com/watch?v=_pTF5mdpkTQ

Passo 1: Inicialmente, abriremos um relatório em branco no Power BI e na guia Página Inicial, no menu Dados, clicamos no ícone SQL Server.
Passo 2: Na janela que se abrir, devemos digitar o nome do Servidor e do Banco de Dados que quermos acessar.
Obs.: Para descobrirmos os nomes do Servidor e do Banco de Dados, vamos retornar ao SSMS. O nome do Servidor aparece no canto superior esquerdo do SSMS no menu Pesquisador de Objetos. O banco de dados que será utilizado é o AdventureWorksDW2014
Passo 3: Agora, basta preenchermos os campos Servidor e Banco de Dados na janela do Power BI com as informações que descobrimos no SSMS e clicar em OK para efetuar a conexão.
Obs.: Efetuada a conexão, aparecerá na janela Navegador todos os objetos do banco de dados AdventureWorksDW2014, como as Views e tabelas.
Passo 4: Como queremos carregar o resultado da View que criamos (RESULTADOS_ADW) para o Power BI, devemos clicar em seu nome. Uma pré-visualização será carregada ao lado direito da janela, após isso podemos clicar em Carregar.
Passo 5: Importada a View RESULTADOS_ADW para o PowerBI, podemos clicar na seta ao lado do nome da View na guia Dados à direita da tela, assim irão aparecer os nomes das colunas da View. E para visualizar as colunas da View, clique em Exibição de Dados no menu localizado na lateral esquerda da tela.
*/

------------------------------
/* AULA 06 - Preparando as Páginas do Relatório
Vamos agora preparar as páginas do nosso relatório. Teremos três abas nesse relatório: Capa, Geral e Clientes.

Passo 1: Na aba Exibição de Relatório vamos nomear a aba Pagina 1 para CAPA.
Passo 2: Clicando no + ao lado, criaremos mais duas abas GERAL e CLIENTES.
Passo 3: Para incluirmos as imagens de plano de fundo em nossas abas CAPA, GERAL e CLIENTES, vamos navegar até a aba Visualizações, no menu da lateral direita da tela, clicar no 'pincel' (Formatar sua página do relatório); Em seguida clicar na opção 'Tela de Fundo', Procurar e selecionar a nossa imagem de fundo.
Passo 4: Em Ajute de Imagem selecionamos Ajuste e em Transparência (%) deixaremos 0
Passo 5: Agora é só salvar o projeto em um local de fácil acesso.

Obs.: As demais aulas são configurações realizadas no PowerBI porém, como este é um curso de SQL não irei detalhar as etapas.
*/

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