-- MÓDULO 26 - SQL SERVER - Integração SQL SERVER e EXCEL

/*AULA 01 - Apresentação
Nesse módulo vamos aprender à como integrar o SQL SERVER ao Excel.

Vamos desenvolver um projeto com o objetivo final de apresentar no Excel um Dashboard simples com alguns gráficos. */

------------------------------
/* AULA 02 - Download e Conexão do Banco de Dados AdventureWorks2014
Para começarmos, precisaremos baixar o banco de dados que vamos utilizar em nosso projeto, o AdventureWorksDW2014.

Para efetuar o download, basta clicar nos links abaixo:

GitHub: https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorksDW2014.bak
Microsoft: https://docs.microsoft.com/pt-br/sql/samples/adventureworks-install-configure?view=sql-server-ver16&tabs=ssms

Obs.: Salve o arquivo em uma pasta de facil acesso, como Documentos, Download ou a unidade C: do seu computador

Restaurando o banco de dados AdventureWorksDW2014 para o SQL Server:
Passo 1: Abra o SQL Server Management Studio (SSMS).
Passo 2: Navegue até o Menu de Pesquisador de Objetos, localizado na lateral esquerda do programa.
Passo 3: Clique com o botão direito do mouse em Banco de Dados e selecione a opção Restaurar Banco de Dados.
Passo 4: Na janela que abrir, no menu Geral, selecione a opção 'Dispositivo' e clique nos (...)
Passo 5: Clique em Adicionar e navegue até a pasta onde deixou o arquivo armazenado, no meu caso pasta C:
Passo 6: Selecione o arquivo clique em OK, Clique em OK novamente e mais uma vez, Clique em OK e aguarde a finalização.

Pronto, restauração efeturada. Perceba que agora o banco de dados AdventureWorksDW2014 aparece no menu Pesquisador de Objetos do SSMS.

Obs.: Navegue pelas pastas, conheça as tabelas, realize consultas básicas com o SELECT e FROM para conhecer o Banco de Dados. */

------------------------------
/* AULA 03 - Definindo os KPIs do Projeto

Primeiramente, vamos definir quais indicadores iremos analisar, e são:

1º Total de Vendas Internet por Categoria do Produto;
2º Receita Total Internet por Mês do Pedido;
3º Receita e Custo Total Internet por País;
4º Total de Vendas Internet por Sexo do Cliente;

- Obs.: O ano de análise será apenas 2013 (ANO DO PEDIDO)		*/

------------------------------
/* AULA 04 - Definindo as tabelas a serem analisadas

Obs.: Iremos trabalhar com as vendas registradas na tabela FactInternetSales

1º Total de Vendas Internet por Categoria do Produto;
- Para construir este indicador, precisaremos relacionar a tabela FactInternetSales com a tabela DimProductCategory.

2º Receita Total Internet por Mês do Pedido;
- Para construir este indicador, precisaremos somente da tabela FactInternetSales.

3º Receita e Custo Total Internet por País;
- Para construir este indicador, precisaremos relacionar a tabela FactInternetSales com a tabela DimSalesTerritory.

4º Total de Vendas Internet por Sexo do Cliente;
- E por último, para construir este indicador, precisaremos relacionar as tabelas FactInternetSales com a tabela DimCustomer.

Ou seja, iremos trabalhar com as informações das seguintes tabelas: */

SELECT * FROM FactInternetSales
SELECT * FROM DimProductCategory
SELECT * FROM DimSalesTerritory
SELECT * FROM DimCustomer

-- Além de precisar das tabelas seguintes para estabelecer os relacionamentos intermediários com JOINS entre as tabelas FactInternetSales e DimProductcategory, e são elas:

SELECT * FROM DimProduct
SELECT * FROM DimProductSubcategory

------------------------------
/* AULA 05 - Definindo as colunas da view VENDAS_INTERNET
 Para exportamos para o Excel os dados que queremos analisar com base em nossos indicadores, precisaremos somente de 
algumas colunas das tabelas mencionadas na aula anterior. Sendo assim, criaremos uma View, que chamaremos de 
Vendas_Internet, que retornará como resultado essas colunas, para que possamos trabalhar somente com os dados que 
realmente importam para nossa análise. São elas:

- Colunas:
- SalesOrderNumber                (TABELA 1: FactInternetSales)
- OrderDate                       (TABELA 1: FactInternetSales)
- EnglishProductCategoryName      (TABELA 4: DimProductCategory)
- FirstName + LastName            (TABELA 2: DimCustomer)
- Gender                          (TABELA 2: DimCustomer)
- SalesTerritoryCountry           (TABELA 3: DimSalesTerritory)
- OrderQuantity                   (TABELA 1: FactInternetSales)
- TotalProductCost                (TABELA 1: FactInternetSales)
- SalesAmount                     (TABELA 1: FactInternetSales)
*/

------------------------------
/* AULA 06-07 - Iniciando o código da view VENDAS_INTERNET

Agora, vamos criar o código da nossa view Vendas_internet. Lembrando que, queremos construir os seguintes indicadores para construir nossas análises. 

Obs.: Propositalmente não será incluído a coluna 'Gender', para posteriormente aprendermos como alterar um código e incluir uma nova coluna após a integração com o Excel ter sido efetuada.

1º Total de Vendas Internet por Categoria do Produto;
2º Receita Total Internet por Mês do Pedido;
3º Receita e Custo Total Internet por País;
4º Total de Vendas Internet por Sexo do Cliente;

- Obs.: O ano de análise será apenas 2013 (ANO DO PEDIDO)		*/

CREATE OR ALTER VIEW VENDAS_INTERNET AS
SELECT 
	fis.SalesOrderNumber AS 'Nº Pedido',
	fis.OrderDate AS 'Data Pedido',
	dpc.EnglishProductCategoryName AS 'Categoria Produto',
	dc.FirstName + ' ' + dc.LastName AS 'Nome Cliente',
	dst.SalesTerritoryCountry AS 'País',
	fis.OrderQuantity AS 'Qtd. Vendida',
	fis.TotalProductCost AS 'Custo Venda',
	fis.SalesAmount AS 'Receita Venda'
FROM FactInternetSales fis
INNER JOIN DimProduct dp ON fis.ProductKey = dp.ProductKey
	INNER JOIN DimProductSubcategory dps ON dp.ProductSubcategoryKey = dps.ProductSubcategoryKey
		INNER JOIN DimProductCategory dpc ON dps.ProductCategoryKey = dpc.ProductCategoryKey
INNER JOIN DimSalesTerritory dst ON fis.SalesTerritoryKey = dst.SalesTerritoryKey
INNER JOIN DimCustomer dc ON fis.CustomerKey = dc.CustomerKey
WHERE YEAR(OrderDate) = 2013

SELECT * FROM VENDAS_INTERNET

------------------------------
/* AULA 08 - Conectando SQL Server ao Excel (Opção View)
Para conectarmos o SQL SERVER ao Excel utilizaremos o Power Query, para isso precisaremos seguir alguns passos:

Passo 1: Abra uma pasta de trabalho em branco no Excel
Passo 2: Na guia Dados clique em na opção Obter Dados: (Versões 2016 em diante)
Obs.: Versões anteriores, assista esse vídeo: https://www.youtube.com/watch?v=dtGYDlE_Bdo
Passo 3: Clique em Obter Dados > Do Banco de Dados > Do Bando de Dados SQL SERVER.
Passo 4: Na guia que abrir deveremos digitar o nome do Servidor e do Banco de Dados que queremos acessar.
Obs.: Para descobrirmos os nomes do Servidor e do Banco de Dados, vamos até o SSMS 
Passo 5: Clique na Guia Pesquisar de Objetos. A 1ª Linha é o nome do Servidor até o inicio do parênteses e o nome do Banco de Dados é o que estamos utilizando AdventureWorksDW2014.
Passo 6: Na janela que abrir irá aparecer todas as tabelas do Banco de Dados, selecione a view que criamos VENDAS_INTERNET e depois em carregar. 
Passo 7: Ao final teremos 52.801 linhas retornadas pela view VENDAS_INTERNET e carregadas na pasta de trabalho do Excel */

------------------------------
/* AULA 09 - Alterando o código SQL e efetivando a alteração no Power Query
Anteriormente havíamos 'esquecido' de propósito de incluir a coluna Gender na nossa View porque queríamos deixar para incluí-la posteriormente, quando já tivessemos conectado o SQL SERVER ao Excel, para mostrarmos como é possível alterar um código SQL apóa integração já ter sido efetuada. 
Vamos incluir a coluna Gender e nomear como Sexo. */

CREATE OR ALTER VIEW VENDAS_INTERNET AS
SELECT 
	fis.SalesOrderNumber AS 'Nº Pedido',
	fis.OrderDate AS 'Data Pedido',
	dpc.EnglishProductCategoryName AS 'Categoria Produto',
	dc.FirstName + ' ' + dc.LastName AS 'Nome Cliente',
	dc.Gender AS 'Sexo',
	dst.SalesTerritoryCountry AS 'País',
	fis.OrderQuantity AS 'Qtd. Vendida',
	fis.TotalProductCost AS 'Custo Venda',
	fis.SalesAmount AS 'Receita Venda'
FROM FactInternetSales fis
INNER JOIN DimProduct dp ON fis.ProductKey = dp.ProductKey
	INNER JOIN DimProductSubcategory dps ON dp.ProductSubcategoryKey = dps.ProductSubcategoryKey
		INNER JOIN DimProductCategory dpc ON dps.ProductCategoryKey = dpc.ProductCategoryKey
INNER JOIN DimSalesTerritory dst ON fis.SalesTerritoryKey = dst.SalesTerritoryKey
INNER JOIN DimCustomer dc ON fis.CustomerKey = dc.CustomerKey
WHERE YEAR(OrderDate) = 2013

SELECT * FROM VENDAS_INTERNET

/* Pronto, a nova coluna foi incluída em nossa view. Agora voltaremos ao Excel para atualizarmos nossa planilha.
Obs.: Note que, a planilha não será atualizada automaticamente, ou seja, não irá aparecer a coluna Sexo assim que retornarmos, precisaremos realizar algumas tarefas para que isso ocorra.

Passo 1: Clique em qualquer campo DENTRO da tabela para que a guia Design da Tabela apareça;
Passo 2: Na guia Design da Tabela, clique no ícone Atualizar.
Passo 3: Pronto! Efetuado a atualização, a nova coluna Sexo aparecerá em nossa tabela. */

------------------------------
/* AULA 10 - Conectando SQL Server ao Excel (Opção Código SQL no Excel)
Podemos conectar o SQL SERVER ao EXCEL de outra forma da qual foi utilizada nas aulas anteriores. 
E nessa aula iremos conectar novamente o SQL SERVER ao EXCEL só que dessa vez utilizando a própria consulta do SQL. 
 
Para isso, precisamos voltar ao SSMS apenas para copiar o código do SELECT, 'esquecendo' novamenta a coluna Gender da tabela dimCustomer, para incluirmos posteriormente. 
Obs.: Dessa vez não iremos trabalhar com a VIEW, mas apenas com o código SELECT da nossa consulta.

Passo 1: Crie uma nova pasta de trabalho em brando no Excel. 
Passo 2: Navegue até a guia Dados > Obter Dados > Do Banco de Dados > Do Banco de Dados SQL SERVER. 
Passo 3: Digitar os nomes do Servidor e Banco de Dados 
Passo 4: Agora, ao invés de clicarmos em OK, vamos clicar em opções avançadas e colar o nossa intrução SQL.
Passo 5: Novamente, uma janela um preview da tabela será apresentado, com as opções Carregar e Transformar Dados, clicaremos em Carregar pois não queremos abrir o Editor do Power Query.	  
Passo 6: Teremos carregadas as mesmas 52.801 linhas do resultado do nosso SELECT dentro da planilha do Excel.
Assim como havíamos conseguido fazer nas aulas anteriores, utilizando a View. Utilizar uma View ou colar o código vai depender da preferência de cada um, no final não irá mudar em nada.	  */

SELECT 
	fis.SalesOrderNumber AS 'Nº Pedido',
	fis.OrderDate AS 'Data Pedido',
	dpc.EnglishProductCategoryName AS 'Categoria Produto',
	dc.FirstName + ' ' + dc.LastName AS 'Nome Cliente',
		dst.SalesTerritoryCountry AS 'País',
	fis.OrderQuantity AS 'Qtd. Vendida',
	fis.TotalProductCost AS 'Custo Venda',
	fis.SalesAmount AS 'Receita Venda'
FROM FactInternetSales fis
INNER JOIN DimProduct dp ON fis.ProductKey = dp.ProductKey
	INNER JOIN DimProductSubcategory dps ON dp.ProductSubcategoryKey = dps.ProductSubcategoryKey
		INNER JOIN DimProductCategory dpc ON dps.ProductCategoryKey = dpc.ProductCategoryKey
INNER JOIN DimSalesTerritory dst ON fis.SalesTerritoryKey = dst.SalesTerritoryKey
INNER JOIN DimCustomer dc ON fis.CustomerKey = dc.CustomerKey
WHERE YEAR(OrderDate) = 2013

SELECT * FROM VENDAS_INTERNET

------------------------------
/* AULA 11 - Alterando o banco e atualizando a Visualização da Tabela

Agora, vamos verificar como podemos alterar nosso código SQL que criamos diretamente no Excel para incluir a coluna Gender da tabela dimCustomer.

No exemplo anterior, voltamos ao SSMS e modificamos a View que havíamos utilizado para importar o código para o Excel, depois fomos no Excel e atualizamos a planilha.

Dessa vez, como carregamos os dados do SQL Server para o Excel utilizando um SELECT criado diretamente no Excel quando estabelecemos a conexão, faremos diferente, editaremos esse código no próprio Editor do Power Query.

Passo 1: Clique em qualquer campo DENTRO da tabela para que a guia Design da Tabela apareça;
Passo 2: Na guia Consulta, clique em Editar. O Editor do Power Query será aberto em uma nova janela.
Passo 3: Já dentro do Editor Power Query, no lado direito da tela em ETAPAS APLICADAS, clique na engrenagem de Fonte.
Passo 4: Dessa forma, abriremos a mesma janela que utilizamos para criar nossa conexão com o SQL Server.
Passo 5: Agora, basta alterarmos o código do nosso SELECT incluindo a coluna que 'esquecemos' e depois clicar em OK.
Passo 6: Repare que a coluna Sexo foi incluída na visualização do Power Query.
Passo 7: Para efetivar essa alteração na planilha do Excel, devemos agora fechar o Editor do Power Query clicando em Fechar e Carregar no canto superior esquerdo da tela.
Passo 8: Feito isso, após aguardar um pouco, veremos a coluna Sexo incluída em nossa tabela.
Obs.: Se após aguardar um pouco a nova coluna não for inserida, basta ir na guia Consulta e clicar na opção Atualizar. */

------------------------------
/* AULA 12 - Tratamentos Básicos no Power Query

Chegamos novamente ao momento em que começaremos a tratar os dados para deixar nossa tabela principal pronta para que possamos criar as tabelas dinâmicas e os gráficos.
E quermos basicamente tratar duas coisas:

1: Alterar na coluna Sexo 'M' por 'Masculino e 'F' por 'Feminino'
2: Extrair a informação do mês da coluna Data Pedido.

Passo 1: Abra o Editor do Power Query.
Passo 2: Realize as alterações na coluna Sexo, clicando com o botão direito do mouse em cima do nome da coluna.
Passo 3: Nas opções que se abrirem, clique em Substituir valores...
Passo 4: Na janela que se abriu, especifique o valor a ser localizado 'M ou F' e valor que será substituido 'Masculino ou Feminino'.
Obs.: Localizar: F - Substituir por: Feminino / Localizar: M - Substituir por: Masculino.
Agora vamos criar uma nova coluna que contenha a informação do mês da coluna Data Pedido.
Passo 5: Selecione a coluna Data Pedido, navegue até o menu Adicionar Coluna. 
Passo 6: Clique opção Data do menu Data e Hora > Mês > Nome do Mês. 
Obs.: Uma nova coluna com o nome dos meses será adicionado ao final da tabela como última coluna. Arraste essa coluna e posicione ao lado da coluna Data Pedido.
Passo 7: Selecione a nova coluna, clique no menu Transformar. Clique em Formato no menu Coluna de Texto e selecione a opção MAIÚSCULA.
Passo 8: Ainda no menu Coluna de Texto clique em Extrair e selecione extrair os primeiros caracteres e na janela que abrir digite 3 e clique em OK.
Passo 8: Renomeie a coluna Nome do mês como MÊS clicando duas vezes sobre o nome da coluna.

Após feito isso, no menu Página Inicial clique em Fechar e Aplicar.

Passo 9: Selecione as colunas Custo Venda e Receita Venda e altere o tipo de dado para Moeda.		*/

------------------------------
/* AULA 13-16 - Criando as Tabelas Dinâmicas
Nesta aula, vamos iniciar a criação das nossas tabelas dinâmicas no Excel.

Obs.:  Uma tabela dinâmica tem por objetivo resumir as informações de uma tabela principal. Basicamente, ela faz agrupamentos de informações, como se fosse o GROUP BY do SQL.

Passo 1: Clique em qualquer campo DENTRO da tabela para que a guia Design da Tabela apareça;
Passo 2: Navegue até o Menu Inserir > Clique em Tabela Dinâmica > Nova Planilha > OK
Passo 3: Renomeie as planilhas do Excel como VENDAS, ANÁLISE e DASHBOARD

Tabela Dinâmica 1: VENDAS POR CATEGORIA - Total de Vendas Internet por Categoria do Produto;
- Selecione e arraste a Categoria Produto para Linhas e Qtd. Vendida para Valores. 
- Clique com o botão direito sobre os valores > Mostrar Valores Como > % do Total Geral

Tabela Dinâmica 2: VENDAS POR MÊS - Receita Total Internet por Mês do Pedido;
- Selecione e arraste o Mês para Linhas e Qtd. Vendida para Valores

Tabela Dinâmica 3: RECEITA e CUSTO POR PAÍS - Receita e Custo Total Internet por País;
- Selecione e arraste País para Linhas e (Receita Venda e Custo Venda) para Valores
- Selecione os valores e altere o formato para moeda.
- Selecione os valores > CTRL + 1 > Personalizado > Tipo: 0..,00 
Obs.: Essa formatação mostrará os valores resumidos em Milhões.

Tabela Dinâmica 4: VENDAS POR GÊNERO - Total de Vendas Internet por Sexo do Cliente;
- Selecione e arraste Sexo para Linhas e Qtd. Vendida para Valores
- Clique com o botão direito sobre os valores > Mostrar Valores Como > % do Total Geral		*/

------------------------------
/* AULA 17-20 - Criando os Gráficos  
Tabelas dinâmicas devidamente criadas e formatadas, agora, iniciaremos a criação dos nossos quatro gráficos:

1º Gráfico: VENDAS POR CATEGORIA
Passo 1: Clique em qualquer campo DENTRO da tabela dinâmica 1
Passo 2: Navegue até o Menu Inserir > Gráficos > Clique no ícone do gráfico de Pizza ou Rosca > Pizza
Passo 3: Com o gráfico selecionado, clique no menu Gráfico Dinâmico > Menu Mostrat/Ocultar > Clique em Botões de Campos
Passo 4: Recorte o Gráfico com o atalho CTRL + X e cole na planilha DASHBOARD com o comando CTRL + V
Passo 5: Altere o título do gráfico para 'Vendas por Categoria'.
Passo 6: Insirá Rótulos de Dados clicando no + e selecionando Rótulos de Dados.
Passo 7: Na opção Rótulo de Dados clique na seta. Na janela que abrir selecione Extremidade Externa, Nome da Categoria e Separador (Nova Linha)
Passo 8: Exclua as legendas do gráfico e altere a cor para uma escala de cores de sua preferência.

2º Gráfico: VENDAS POR MÊS
Passo 1: Clique em qualquer campo DENTRO da tabela dinâmica 2
Passo 2: Navegue até o Menu Inserir > Gráficos > Clique no ícone do gráfico de colunas ou barras > Barras agrupadas 2D
Passo 3: Com o gráfico selecionado, clique no menu Gráfico Dinâmico > Menu Mostrat/Ocultar > Clique em Botões de Campos
Passo 4: Recorte o Gráfico com o atalho CTRL + X e cole na planilha DASHBOARD com o comando CTRL + V
Passo 5: Altere o título do gráfico para 'Vendas por Mês'.
Passo 6: Insirá Rótulos de Dados clicando no + e selecionando Rótulos de Dados.
Passo 7: Limpe o gráfico excluindo as legendas do gráfico, linhas horizontais e informações do Eixo Vertical.

3º Gráfico: RECEITA e CUSTO POR PAÍS
Passo 1: Clique em qualquer campo DENTRO da tabela dinâmica 2
Passo 2: Navegue até o Menu Inserir > Gráficos > Clique no ícone do gráfico de colunas ou barras > Colunas agrupadas 2D
Passo 3: Com o gráfico selecionado, clique no menu Gráfico Dinâmico > Menu Mostrat/Ocultar > Clique em Botões de Campos
Passo 4: Recorte o Gráfico com o atalho CTRL + X e cole na planilha DASHBOARD com o comando CTRL + V
Passo 5: Insira o título do gráfico como 'Receita Total vs Custo Total por País'.
Passo 6: Insirá Rótulos de Dados clicando no + e selecionando Rótulos de Dados.
Passo 7: Limpe o gráfico excluindo as legendas do gráfico e linhas verticais.
Passo 8: Insira um título de eixo, no eixo Horizontal como 'R$ (em milhões)'.

4º Gráfico: VENDAS POR GÊNERO
Passo 1: Clique em qualquer campo DENTRO da tabela dinâmica 4
Passo 2: Navegue até o Menu Inserir > Gráficos > Clique no ícone do gráfico de Pizza ou Rosca > Rosca
Passo 3: Com o gráfico selecionado, clique no menu Gráfico Dinâmico > Menu Mostrat/Ocultar > Clique em Botões de Campos
Passo 4: Recorte o Gráfico com o atalho CTRL + X e cole na planilha DASHBOARD com o comando CTRL + V
Passo 5: Altere o título do gráfico para 'Vendas por Gênero'.
Passo 6: Insirá Rótulos de Dados clicando no + e selecionando Rótulos de Dados.
Passo 7: Na opção Rótulo de Dados clique na seta. Na janela que abrir selecione Extremidade Externa, Nome da Categoria e Separador (Nova Linha) > Altere a formatação colocando um fundo cinza escuro e cor da fonte branca.
Passo 8: Exclua as legendas do gráfico e altere a cor para uma escala de cores de sua preferência.	*/

------------------------------
-- AULA 21 - Finalizando o Relatório no Excel
-- AULA 22 - Alterando o Banco de Dados e Atualizando no Excel

-- Voltando ao SSMS, vamos fazer uma alteração no banco de dados AdventureWorksDW2014, para depois verificarmos como podemos atualizar o nosso relatório no Excel para que ele reconheça essa alteração.

-- Se fizermos uma consulta à tabela FactInternetSales, veremos que a coluna OrderQuantity está totalmente preenchida com o valor 1.

SELECT * FROM FactInternetSales

-- Sendo assim, vamos alterar a OrderQuantity de todos os pedidos cujo ProductKey seja igual a 361 (pertencentes à categoria Bikes) para que passe a constar o valor 20. Executando o código abaixo, vamos alterar o valor da coluna OrderQuantity da tabela FactInternetSales para 20 em 427 registros.

BEGIN TRANSACTION T1
	
	UPDATE FactInternetSales
	SET OrderQuantity = 20
	WHERE ProductKey = 361       -- Categoria Bike

COMMIT TRANSACTION T1

-- Se consultarmos novamente a tabela FactInternetSales, veremos que realmente a OrderQuantity de alguns produtos foi alterada (todos cujo ProductKey = 361).

SELECT * FROM FactInternetSales

/* Voltando à planilha VENDAS do Excel, veremos que a atualização não foi efetuada, pois isso não é feito de forma automática. Repare abaixo que o valor da coluna QTD. VENDIDA continua aparecendo igual a 1 para todos os registros:
Sendo assim, clicamos em algum campo da tabela (atente-se para não clicar em qualquer célula em branco da planilha, e sim em algum campo que faça parte da tabela), selecionamos a guia Design da Tabela, depois a setinha do ícone Atualizar e clicamos em Atualizar Tudo.
Feito isso, repare que, na planilha VENDAS, a QTD. VENDIDA de alguns registros será alterada para 20: No entanto, se verificarmos a planilha ANÁLISE, veremos que a tabela dinâmica não foi alterada... E, consequentemente, na planilha DASHBOARD, nosso gráfico continua sem atualização.
Isso acontece porque a primeira atualização que fazemos altera somente a tabela principal que importamos diretamente do 
banco de dados.
As tabelas dinâmicas dependem das informações dessa tabela principal. E os gráficos dependem das informações das tabelas dinâmicas.

Bando de Dados > Tabela Principal > Tabelas Dinâmicas > Gráficos

Por isso, precisamos atualizar o Excel duas vezes:
- Da primeira vez, a tabela principal receberá as informações atualizadas vindas do banco de dados;
- Da segunda vez, as tabelas dinâmicas serão alteradas com base nas informações atualizadas da tabela principal que, por sua vez, alterarão também os gráficos que são alimentados com as informações de tais tabelas dinâmicas.

Uma vez que a planilha do Excel foi atualizado duas vezes, as pastas VENDAS, ANÁLISE e DASHBOARD serão atualizadas.		*/

------------------------------
-- AULA 23 - Salvando o Arquivo e Finalizando o Projeto