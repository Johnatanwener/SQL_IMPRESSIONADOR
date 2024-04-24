-- M�DULO 26 - SQL SERVER - Integra��o SQL SERVER e EXCEL

/*AULA 01 - Apresenta��o
Nesse m�dulo vamos aprender � como integrar o SQL SERVER ao Excel.

Vamos desenvolver um projeto com o objetivo final de apresentar no Excel um Dashboard simples com alguns gr�ficos. */

------------------------------
/* AULA 02 - Download e Conex�o do Banco de Dados AdventureWorks2014
Para come�armos, precisaremos baixar o banco de dados que vamos utilizar em nosso projeto, o AdventureWorksDW2014.

Para efetuar o download, basta clicar nos links abaixo:

GitHub: https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorksDW2014.bak
Microsoft: https://docs.microsoft.com/pt-br/sql/samples/adventureworks-install-configure?view=sql-server-ver16&tabs=ssms

Obs.: Salve o arquivo em uma pasta de facil acesso, como Documentos, Download ou a unidade C: do seu computador

Restaurando o banco de dados AdventureWorksDW2014 para o SQL Server:
Passo 1: Abra o SQL Server Management Studio (SSMS).
Passo 2: Navegue at� o Menu de Pesquisador de Objetos, localizado na lateral esquerda do programa.
Passo 3: Clique com o bot�o direito do mouse em Banco de Dados e selecione a op��o Restaurar Banco de Dados.
Passo 4: Na janela que abrir, no menu Geral, selecione a op��o 'Dispositivo' e clique nos (...)
Passo 5: Clique em Adicionar e navegue at� a pasta onde deixou o arquivo armazenado, no meu caso pasta C:
Passo 6: Selecione o arquivo clique em OK, Clique em OK novamente e mais uma vez, Clique em OK e aguarde a finaliza��o.

Pronto, restaura��o efeturada. Perceba que agora o banco de dados AdventureWorksDW2014 aparece no menu Pesquisador de Objetos do SSMS.

Obs.: Navegue pelas pastas, conhe�a as tabelas, realize consultas b�sicas com o SELECT e FROM para conhecer o Banco de Dados. */

------------------------------
/* AULA 03 - Definindo os KPIs do Projeto

Primeiramente, vamos definir quais indicadores iremos analisar, e s�o:

1� Total de Vendas Internet por Categoria do Produto;
2� Receita Total Internet por M�s do Pedido;
3� Receita e Custo Total Internet por Pa�s;
4� Total de Vendas Internet por Sexo do Cliente;

- Obs.: O ano de an�lise ser� apenas 2013 (ANO DO PEDIDO)		*/

------------------------------
/* AULA 04 - Definindo as tabelas a serem analisadas

Obs.: Iremos trabalhar com as vendas registradas na tabela FactInternetSales

1� Total de Vendas Internet por Categoria do Produto;
- Para construir este indicador, precisaremos relacionar a tabela FactInternetSales com a tabela DimProductCategory.

2� Receita Total Internet por M�s do Pedido;
- Para construir este indicador, precisaremos somente da tabela FactInternetSales.

3� Receita e Custo Total Internet por Pa�s;
- Para construir este indicador, precisaremos relacionar a tabela FactInternetSales com a tabela DimSalesTerritory.

4� Total de Vendas Internet por Sexo do Cliente;
- E por �ltimo, para construir este indicador, precisaremos relacionar as tabelas FactInternetSales com a tabela DimCustomer.

Ou seja, iremos trabalhar com as informa��es das seguintes tabelas: */

SELECT * FROM FactInternetSales
SELECT * FROM DimProductCategory
SELECT * FROM DimSalesTerritory
SELECT * FROM DimCustomer

-- Al�m de precisar das tabelas seguintes para estabelecer os relacionamentos intermedi�rios com JOINS entre as tabelas FactInternetSales e DimProductcategory, e s�o elas:

SELECT * FROM DimProduct
SELECT * FROM DimProductSubcategory

------------------------------
/* AULA 05 - Definindo as colunas da view VENDAS_INTERNET
 Para exportamos para o Excel os dados que queremos analisar com base em nossos indicadores, precisaremos somente de 
algumas colunas das tabelas mencionadas na aula anterior. Sendo assim, criaremos uma View, que chamaremos de 
Vendas_Internet, que retornar� como resultado essas colunas, para que possamos trabalhar somente com os dados que 
realmente importam para nossa an�lise. S�o elas:

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
/* AULA 06-07 - Iniciando o c�digo da view VENDAS_INTERNET

Agora, vamos criar o c�digo da nossa view Vendas_internet. Lembrando que, queremos construir os seguintes indicadores para construir nossas an�lises. 

Obs.: Propositalmente n�o ser� inclu�do a coluna 'Gender', para posteriormente aprendermos como alterar um c�digo e incluir uma nova coluna ap�s a integra��o com o Excel ter sido efetuada.

1� Total de Vendas Internet por Categoria do Produto;
2� Receita Total Internet por M�s do Pedido;
3� Receita e Custo Total Internet por Pa�s;
4� Total de Vendas Internet por Sexo do Cliente;

- Obs.: O ano de an�lise ser� apenas 2013 (ANO DO PEDIDO)		*/

CREATE OR ALTER VIEW VENDAS_INTERNET AS
SELECT 
	fis.SalesOrderNumber AS 'N� Pedido',
	fis.OrderDate AS 'Data Pedido',
	dpc.EnglishProductCategoryName AS 'Categoria Produto',
	dc.FirstName + ' ' + dc.LastName AS 'Nome Cliente',
	dst.SalesTerritoryCountry AS 'Pa�s',
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
/* AULA 08 - Conectando SQL Server ao Excel (Op��o View)
Para conectarmos o SQL SERVER ao Excel utilizaremos o Power Query, para isso precisaremos seguir alguns passos:

Passo 1: Abra uma pasta de trabalho em branco no Excel
Passo 2: Na guia Dados clique em na op��o Obter Dados: (Vers�es 2016 em diante)
Obs.: Vers�es anteriores, assista esse v�deo: https://www.youtube.com/watch?v=dtGYDlE_Bdo
Passo 3: Clique em Obter Dados > Do Banco de Dados > Do Bando de Dados SQL SERVER.
Passo 4: Na guia que abrir deveremos digitar o nome do Servidor e do Banco de Dados que queremos acessar.
Obs.: Para descobrirmos os nomes do Servidor e do Banco de Dados, vamos at� o SSMS 
Passo 5: Clique na Guia Pesquisar de Objetos. A 1� Linha � o nome do Servidor at� o inicio do par�nteses e o nome do Banco de Dados � o que estamos utilizando AdventureWorksDW2014.
Passo 6: Na janela que abrir ir� aparecer todas as tabelas do Banco de Dados, selecione a view que criamos VENDAS_INTERNET e depois em carregar. 
Passo 7: Ao final teremos 52.801 linhas retornadas pela view VENDAS_INTERNET e carregadas na pasta de trabalho do Excel */

------------------------------
/* AULA 09 - Alterando o c�digo SQL e efetivando a altera��o no Power Query
Anteriormente hav�amos 'esquecido' de prop�sito de incluir a coluna Gender na nossa View porque quer�amos deixar para inclu�-la posteriormente, quando j� tivessemos conectado o SQL SERVER ao Excel, para mostrarmos como � poss�vel alterar um c�digo SQL ap�a integra��o j� ter sido efetuada. 
Vamos incluir a coluna Gender e nomear como Sexo. */

CREATE OR ALTER VIEW VENDAS_INTERNET AS
SELECT 
	fis.SalesOrderNumber AS 'N� Pedido',
	fis.OrderDate AS 'Data Pedido',
	dpc.EnglishProductCategoryName AS 'Categoria Produto',
	dc.FirstName + ' ' + dc.LastName AS 'Nome Cliente',
	dc.Gender AS 'Sexo',
	dst.SalesTerritoryCountry AS 'Pa�s',
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

/* Pronto, a nova coluna foi inclu�da em nossa view. Agora voltaremos ao Excel para atualizarmos nossa planilha.
Obs.: Note que, a planilha n�o ser� atualizada automaticamente, ou seja, n�o ir� aparecer a coluna Sexo assim que retornarmos, precisaremos realizar algumas tarefas para que isso ocorra.

Passo 1: Clique em qualquer campo DENTRO da tabela para que a guia Design da Tabela apare�a;
Passo 2: Na guia Design da Tabela, clique no �cone Atualizar.
Passo 3: Pronto! Efetuado a atualiza��o, a nova coluna Sexo aparecer� em nossa tabela. */

------------------------------
/* AULA 10 - Conectando SQL Server ao Excel (Op��o C�digo SQL no Excel)
Podemos conectar o SQL SERVER ao EXCEL de outra forma da qual foi utilizada nas aulas anteriores. 
E nessa aula iremos conectar novamente o SQL SERVER ao EXCEL s� que dessa vez utilizando a pr�pria consulta do SQL. 
 
Para isso, precisamos voltar ao SSMS apenas para copiar o c�digo do SELECT, 'esquecendo' novamenta a coluna Gender da tabela dimCustomer, para incluirmos posteriormente. 
Obs.: Dessa vez n�o iremos trabalhar com a VIEW, mas apenas com o c�digo SELECT da nossa consulta.

Passo 1: Crie uma nova pasta de trabalho em brando no Excel. 
Passo 2: Navegue at� a guia Dados > Obter Dados > Do Banco de Dados > Do Banco de Dados SQL SERVER. 
Passo 3: Digitar os nomes do Servidor e Banco de Dados 
Passo 4: Agora, ao inv�s de clicarmos em OK, vamos clicar em op��es avan�adas e colar o nossa intru��o SQL.
Passo 5: Novamente, uma janela um preview da tabela ser� apresentado, com as op��es Carregar e Transformar Dados, clicaremos em Carregar pois n�o queremos abrir o Editor do Power Query.	  
Passo 6: Teremos carregadas as mesmas 52.801 linhas do resultado do nosso SELECT dentro da planilha do Excel.
Assim como hav�amos conseguido fazer nas aulas anteriores, utilizando a View. Utilizar uma View ou colar o c�digo vai depender da prefer�ncia de cada um, no final n�o ir� mudar em nada.	  */

SELECT 
	fis.SalesOrderNumber AS 'N� Pedido',
	fis.OrderDate AS 'Data Pedido',
	dpc.EnglishProductCategoryName AS 'Categoria Produto',
	dc.FirstName + ' ' + dc.LastName AS 'Nome Cliente',
		dst.SalesTerritoryCountry AS 'Pa�s',
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
/* AULA 11 - Alterando o banco e atualizando a Visualiza��o da Tabela

Agora, vamos verificar como podemos alterar nosso c�digo SQL que criamos diretamente no Excel para incluir a coluna Gender da tabela dimCustomer.

No exemplo anterior, voltamos ao SSMS e modificamos a View que hav�amos utilizado para importar o c�digo para o Excel, depois fomos no Excel e atualizamos a planilha.

Dessa vez, como carregamos os dados do SQL Server para o Excel utilizando um SELECT criado diretamente no Excel quando estabelecemos a conex�o, faremos diferente, editaremos esse c�digo no pr�prio Editor do Power Query.

Passo 1: Clique em qualquer campo DENTRO da tabela para que a guia Design da Tabela apare�a;
Passo 2: Na guia Consulta, clique em Editar. O Editor do Power Query ser� aberto em uma nova janela.
Passo 3: J� dentro do Editor Power Query, no lado direito da tela em ETAPAS APLICADAS, clique na engrenagem de Fonte.
Passo 4: Dessa forma, abriremos a mesma janela que utilizamos para criar nossa conex�o com o SQL Server.
Passo 5: Agora, basta alterarmos o c�digo do nosso SELECT incluindo a coluna que 'esquecemos' e depois clicar em OK.
Passo 6: Repare que a coluna Sexo foi inclu�da na visualiza��o do Power Query.
Passo 7: Para efetivar essa altera��o na planilha do Excel, devemos agora fechar o Editor do Power Query clicando em Fechar e Carregar no canto superior esquerdo da tela.
Passo 8: Feito isso, ap�s aguardar um pouco, veremos a coluna Sexo inclu�da em nossa tabela.
Obs.: Se ap�s aguardar um pouco a nova coluna n�o for inserida, basta ir na guia Consulta e clicar na op��o Atualizar. */

------------------------------
/* AULA 12 - Tratamentos B�sicos no Power Query

Chegamos novamente ao momento em que come�aremos a tratar os dados para deixar nossa tabela principal pronta para que possamos criar as tabelas din�micas e os gr�ficos.
E quermos basicamente tratar duas coisas:

1: Alterar na coluna Sexo 'M' por 'Masculino e 'F' por 'Feminino'
2: Extrair a informa��o do m�s da coluna Data Pedido.

Passo 1: Abra o Editor do Power Query.
Passo 2: Realize as altera��es na coluna Sexo, clicando com o bot�o direito do mouse em cima do nome da coluna.
Passo 3: Nas op��es que se abrirem, clique em Substituir valores...
Passo 4: Na janela que se abriu, especifique o valor a ser localizado 'M ou F' e valor que ser� substituido 'Masculino ou Feminino'.
Obs.: Localizar: F - Substituir por: Feminino / Localizar: M - Substituir por: Masculino.
Agora vamos criar uma nova coluna que contenha a informa��o do m�s da coluna Data Pedido.
Passo 5: Selecione a coluna Data Pedido, navegue at� o menu Adicionar Coluna. 
Passo 6: Clique op��o Data do menu Data e Hora > M�s > Nome do M�s. 
Obs.: Uma nova coluna com o nome dos meses ser� adicionado ao final da tabela como �ltima coluna. Arraste essa coluna e posicione ao lado da coluna Data Pedido.
Passo 7: Selecione a nova coluna, clique no menu Transformar. Clique em Formato no menu Coluna de Texto e selecione a op��o MAI�SCULA.
Passo 8: Ainda no menu Coluna de Texto clique em Extrair e selecione extrair os primeiros caracteres e na janela que abrir digite 3 e clique em OK.
Passo 8: Renomeie a coluna Nome do m�s como M�S clicando duas vezes sobre o nome da coluna.

Ap�s feito isso, no menu P�gina Inicial clique em Fechar e Aplicar.

Passo 9: Selecione as colunas Custo Venda e Receita Venda e altere o tipo de dado para Moeda.		*/

------------------------------
/* AULA 13-16 - Criando as Tabelas Din�micas
Nesta aula, vamos iniciar a cria��o das nossas tabelas din�micas no Excel.

Obs.:  Uma tabela din�mica tem por objetivo resumir as informa��es de uma tabela principal. Basicamente, ela faz agrupamentos de informa��es, como se fosse o GROUP BY do SQL.

Passo 1: Clique em qualquer campo DENTRO da tabela para que a guia Design da Tabela apare�a;
Passo 2: Navegue at� o Menu Inserir > Clique em Tabela Din�mica > Nova Planilha > OK
Passo 3: Renomeie as planilhas do Excel como VENDAS, AN�LISE e DASHBOARD

Tabela Din�mica 1: VENDAS POR CATEGORIA - Total de Vendas Internet por Categoria do Produto;
- Selecione e arraste a Categoria Produto para Linhas e Qtd. Vendida para Valores. 
- Clique com o bot�o direito sobre os valores > Mostrar Valores Como > % do Total Geral

Tabela Din�mica 2: VENDAS POR M�S - Receita Total Internet por M�s do Pedido;
- Selecione e arraste o M�s para Linhas e Qtd. Vendida para Valores

Tabela Din�mica 3: RECEITA e CUSTO POR PA�S - Receita e Custo Total Internet por Pa�s;
- Selecione e arraste Pa�s para Linhas e (Receita Venda e Custo Venda) para Valores
- Selecione os valores e altere o formato para moeda.
- Selecione os valores > CTRL + 1 > Personalizado > Tipo: 0..,00 
Obs.: Essa formata��o mostrar� os valores resumidos em Milh�es.

Tabela Din�mica 4: VENDAS POR G�NERO - Total de Vendas Internet por Sexo do Cliente;
- Selecione e arraste Sexo para Linhas e Qtd. Vendida para Valores
- Clique com o bot�o direito sobre os valores > Mostrar Valores Como > % do Total Geral		*/

------------------------------
/* AULA 17-20 - Criando os Gr�ficos  
Tabelas din�micas devidamente criadas e formatadas, agora, iniciaremos a cria��o dos nossos quatro gr�ficos:

1� Gr�fico: VENDAS POR CATEGORIA
Passo 1: Clique em qualquer campo DENTRO da tabela din�mica 1
Passo 2: Navegue at� o Menu Inserir > Gr�ficos > Clique no �cone do gr�fico de Pizza ou Rosca > Pizza
Passo 3: Com o gr�fico selecionado, clique no menu Gr�fico Din�mico > Menu Mostrat/Ocultar > Clique em Bot�es de Campos
Passo 4: Recorte o Gr�fico com o atalho CTRL + X e cole na planilha DASHBOARD com o comando CTRL + V
Passo 5: Altere o t�tulo do gr�fico para 'Vendas por Categoria'.
Passo 6: Insir� R�tulos de Dados clicando no + e selecionando R�tulos de Dados.
Passo 7: Na op��o R�tulo de Dados clique na seta. Na janela que abrir selecione Extremidade Externa, Nome da Categoria e Separador (Nova Linha)
Passo 8: Exclua as legendas do gr�fico e altere a cor para uma escala de cores de sua prefer�ncia.

2� Gr�fico: VENDAS POR M�S
Passo 1: Clique em qualquer campo DENTRO da tabela din�mica 2
Passo 2: Navegue at� o Menu Inserir > Gr�ficos > Clique no �cone do gr�fico de colunas ou barras > Barras agrupadas 2D
Passo 3: Com o gr�fico selecionado, clique no menu Gr�fico Din�mico > Menu Mostrat/Ocultar > Clique em Bot�es de Campos
Passo 4: Recorte o Gr�fico com o atalho CTRL + X e cole na planilha DASHBOARD com o comando CTRL + V
Passo 5: Altere o t�tulo do gr�fico para 'Vendas por M�s'.
Passo 6: Insir� R�tulos de Dados clicando no + e selecionando R�tulos de Dados.
Passo 7: Limpe o gr�fico excluindo as legendas do gr�fico, linhas horizontais e informa��es do Eixo Vertical.

3� Gr�fico: RECEITA e CUSTO POR PA�S
Passo 1: Clique em qualquer campo DENTRO da tabela din�mica 2
Passo 2: Navegue at� o Menu Inserir > Gr�ficos > Clique no �cone do gr�fico de colunas ou barras > Colunas agrupadas 2D
Passo 3: Com o gr�fico selecionado, clique no menu Gr�fico Din�mico > Menu Mostrat/Ocultar > Clique em Bot�es de Campos
Passo 4: Recorte o Gr�fico com o atalho CTRL + X e cole na planilha DASHBOARD com o comando CTRL + V
Passo 5: Insira o t�tulo do gr�fico como 'Receita Total vs Custo Total por Pa�s'.
Passo 6: Insir� R�tulos de Dados clicando no + e selecionando R�tulos de Dados.
Passo 7: Limpe o gr�fico excluindo as legendas do gr�fico e linhas verticais.
Passo 8: Insira um t�tulo de eixo, no eixo Horizontal como 'R$ (em milh�es)'.

4� Gr�fico: VENDAS POR G�NERO
Passo 1: Clique em qualquer campo DENTRO da tabela din�mica 4
Passo 2: Navegue at� o Menu Inserir > Gr�ficos > Clique no �cone do gr�fico de Pizza ou Rosca > Rosca
Passo 3: Com o gr�fico selecionado, clique no menu Gr�fico Din�mico > Menu Mostrat/Ocultar > Clique em Bot�es de Campos
Passo 4: Recorte o Gr�fico com o atalho CTRL + X e cole na planilha DASHBOARD com o comando CTRL + V
Passo 5: Altere o t�tulo do gr�fico para 'Vendas por G�nero'.
Passo 6: Insir� R�tulos de Dados clicando no + e selecionando R�tulos de Dados.
Passo 7: Na op��o R�tulo de Dados clique na seta. Na janela que abrir selecione Extremidade Externa, Nome da Categoria e Separador (Nova Linha) > Altere a formata��o colocando um fundo cinza escuro e cor da fonte branca.
Passo 8: Exclua as legendas do gr�fico e altere a cor para uma escala de cores de sua prefer�ncia.	*/

------------------------------
-- AULA 21 - Finalizando o Relat�rio no Excel
-- AULA 22 - Alterando o Banco de Dados e Atualizando no Excel

-- Voltando ao SSMS, vamos fazer uma altera��o no banco de dados AdventureWorksDW2014, para depois verificarmos como podemos atualizar o nosso relat�rio no Excel para que ele reconhe�a essa altera��o.

-- Se fizermos uma consulta � tabela FactInternetSales, veremos que a coluna OrderQuantity est� totalmente preenchida com o valor 1.

SELECT * FROM FactInternetSales

-- Sendo assim, vamos alterar a OrderQuantity de todos os pedidos cujo ProductKey seja igual a 361 (pertencentes � categoria Bikes) para que passe a constar o valor 20. Executando o c�digo abaixo, vamos alterar o valor da coluna OrderQuantity da tabela FactInternetSales para 20 em 427 registros.

BEGIN TRANSACTION T1
	
	UPDATE FactInternetSales
	SET OrderQuantity = 20
	WHERE ProductKey = 361       -- Categoria Bike

COMMIT TRANSACTION T1

-- Se consultarmos novamente a tabela FactInternetSales, veremos que realmente a OrderQuantity de alguns produtos foi alterada (todos cujo ProductKey = 361).

SELECT * FROM FactInternetSales

/* Voltando � planilha VENDAS do Excel, veremos que a atualiza��o n�o foi efetuada, pois isso n�o � feito de forma autom�tica. Repare abaixo que o valor da coluna QTD. VENDIDA continua aparecendo igual a 1 para todos os registros:
Sendo assim, clicamos em algum campo da tabela (atente-se para n�o clicar em qualquer c�lula em branco da planilha, e sim em algum campo que fa�a parte da tabela), selecionamos a guia Design da Tabela, depois a setinha do �cone Atualizar e clicamos em Atualizar Tudo.
Feito isso, repare que, na planilha VENDAS, a QTD. VENDIDA de alguns registros ser� alterada para 20: No entanto, se verificarmos a planilha AN�LISE, veremos que a tabela din�mica n�o foi alterada... E, consequentemente, na planilha DASHBOARD, nosso gr�fico continua sem atualiza��o.
Isso acontece porque a primeira atualiza��o que fazemos altera somente a tabela principal que importamos diretamente do 
banco de dados.
As tabelas din�micas dependem das informa��es dessa tabela principal. E os gr�ficos dependem das informa��es das tabelas din�micas.

Bando de Dados > Tabela Principal > Tabelas Din�micas > Gr�ficos

Por isso, precisamos atualizar o Excel duas vezes:
- Da primeira vez, a tabela principal receber� as informa��es atualizadas vindas do banco de dados;
- Da segunda vez, as tabelas din�micas ser�o alteradas com base nas informa��es atualizadas da tabela principal que, por sua vez, alterar�o tamb�m os gr�ficos que s�o alimentados com as informa��es de tais tabelas din�micas.

Uma vez que a planilha do Excel foi atualizado duas vezes, as pastas VENDAS, AN�LISE e DASHBOARD ser�o atualizadas.		*/

------------------------------
-- AULA 23 - Salvando o Arquivo e Finalizando o Projeto