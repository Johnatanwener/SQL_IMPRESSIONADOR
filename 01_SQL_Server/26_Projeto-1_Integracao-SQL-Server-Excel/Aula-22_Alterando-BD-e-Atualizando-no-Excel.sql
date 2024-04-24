-- MÓDULO 26 - SQL SERVER - Integração SQL SERVER e EXCEL

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