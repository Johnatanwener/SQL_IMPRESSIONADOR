-- MÓDULO 09 - SQL SERVER - VARIÁVEIS


/* AULA 17 - VARIÁVEIS GLOBAIS
O SQL possui algumas variáveis padrões, que podem ser acessadas quando utilizamos o @@, como mostrado abaixo.

Nos códigos abaixo, conseguimos acessar variáveis que retornam informações como: Nome do Servidor, Versão do Sistema ou até mesmo a contagem de linhas de uma tabela.

Para acessar a lista de variáveis globais será incluído depois de SELECT 2 @ '@@'. */

SELECT @@SERVERNAME AS 'Nome do Servidor' -- Descobrir o nome do servidor
SELECT @@VERSION AS 'Versão' -- Descobrir a versão do SSMS


SELECT * FROM DimProduct
SELECT @@ROWCOUNT AS 'Contagem de linhas' -- Contagem de linhas da tabela
