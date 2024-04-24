-- M�DULO 26 - SQL SERVER - Integra��o SQL SERVER e EXCEL

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