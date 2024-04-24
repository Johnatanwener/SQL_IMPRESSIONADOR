-- M�DULO 27 - SQL SERVER - INTEGRA��O SQL SERVER - POWER BI


/* AULA 01 - Apresenta��o
Nesse m�dulo, aprenderemos como inegrar o SQL Server com o Power BI.

Iremos desenvolver um projeto com o objetivo final de apresentar no Power BI um Dashboard Comercial com informa��es vindas do banco de dados Adventure Works, cuja informa��es estar�o armazenadas no SQL Server. */

------------------------------
/* AULA 02 - Definindo os KPIs do Projeto

Em nosso projeto, utilizaremos o banco de dados AdventureWorksDW2014 que utilizamos no m�dulo anterior.

Em nosso relat�rio teremos duas abas: Aba GERAL e Aba Clientes, al�m da Capa.

- Aba GERAL
1. Receita Total							5. Receita Total e Lucro Total por M�s
2. Quantidade Vendida						6. Margem de Lucro
3. Total de Categorias de Produtos			7. Quantidade Vendida por M�s
4. Quantidade de Clientes					8. Lucro por Pa�s

- Aba CLIENTE
1. Vendas por Pa�s							3. Vendas por G�nero
2. Clientes por Pa�s						4. Vendas por Categoria
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
-- AULA 04 - Criando o c�digo da view RESULTADOS_ADW
-- Nesta aula criaremos o c�digo da nossa View RESULTADOS_ADW. 

CREATE OR ALTER VIEW RESULTADOS_ADW AS
SELECT
	fis.SalesOrderNumber AS 'N� PEDIDO',
	fis.OrderDate AS 'DATA PEDIDO',
	dpc.EnglishProductCategoryName AS 'CATEGORIA PRODUTO',
	fis.CustomerKey AS 'ID CLIENTE',
	dc.FirstName + ' ' + dc.LastName AS 'NOME CLIENTE',
	REPLACE(REPLACE(dc.Gender, 'M', 'Masculino'), 'F', 'Feminino') AS 'SEXO',
	dg.EnglishCountryRegionName AS 'PA�S',
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
Se ainda n�o tiver o Power BI instalado no seu computador, clique no link abaixo para assistir o v�deo que ensina fazer o download e a instala��o do Power BI.

Link: https://www.youtube.com/watch?v=_pTF5mdpkTQ

Passo 1: Inicialmente, abriremos um relat�rio em branco no Power BI e na guia P�gina Inicial, no menu Dados, clicamos no �cone SQL Server.
Passo 2: Na janela que se abrir, devemos digitar o nome do Servidor e do Banco de Dados que quermos acessar.
Obs.: Para descobrirmos os nomes do Servidor e do Banco de Dados, vamos retornar ao SSMS. O nome do Servidor aparece no canto superior esquerdo do SSMS no menu Pesquisador de Objetos. O banco de dados que ser� utilizado � o AdventureWorksDW2014
Passo 3: Agora, basta preenchermos os campos Servidor e Banco de Dados na janela do Power BI com as informa��es que descobrimos no SSMS e clicar em OK para efetuar a conex�o.
Obs.: Efetuada a conex�o, aparecer� na janela Navegador todos os objetos do banco de dados AdventureWorksDW2014, como as Views e tabelas.
Passo 4: Como queremos carregar o resultado da View que criamos (RESULTADOS_ADW) para o Power BI, devemos clicar em seu nome. Uma pr�-visualiza��o ser� carregada ao lado direito da janela, ap�s isso podemos clicar em Carregar.
Passo 5: Importada a View RESULTADOS_ADW para o PowerBI, podemos clicar na seta ao lado do nome da View na guia Dados � direita da tela, assim ir�o aparecer os nomes das colunas da View. E para visualizar as colunas da View, clique em Exibi��o de Dados no menu localizado na lateral esquerda da tela.
*/

------------------------------
/* AULA 06 - Preparando as P�ginas do Relat�rio
Vamos agora preparar as p�ginas do nosso relat�rio. Teremos tr�s abas nesse relat�rio: Capa, Geral e Clientes.

Passo 1: Na aba Exibi��o de Relat�rio vamos nomear a aba Pagina 1 para CAPA.
Passo 2: Clicando no + ao lado, criaremos mais duas abas GERAL e CLIENTES.
Passo 3: Para incluirmos as imagens de plano de fundo em nossas abas CAPA, GERAL e CLIENTES, vamos navegar at� a aba Visualiza��es, no menu da lateral direita da tela, clicar no 'pincel' (Formatar sua p�gina do relat�rio); Em seguida clicar na op��o 'Tela de Fundo', Procurar e selecionar a nossa imagem de fundo.
Passo 4: Em Ajute de Imagem selecionamos Ajuste e em Transpar�ncia (%) deixaremos 0
Passo 5: Agora � s� salvar o projeto em um local de f�cil acesso.

Obs.: As demais aulas s�o configura��es realizadas no PowerBI por�m, como este � um curso de SQL n�o irei detalhar as etapas.
*/

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