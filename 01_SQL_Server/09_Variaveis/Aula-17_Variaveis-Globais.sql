-- M�DULO 09 - SQL SERVER - VARI�VEIS


/* AULA 17 - VARI�VEIS GLOBAIS
O SQL possui algumas vari�veis padr�es, que podem ser acessadas quando utilizamos o @@, como mostrado abaixo.

Nos c�digos abaixo, conseguimos acessar vari�veis que retornam informa��es como: Nome do Servidor, Vers�o do Sistema ou at� mesmo a contagem de linhas de uma tabela.

Para acessar a lista de vari�veis globais ser� inclu�do depois de SELECT 2 @ '@@'. */

SELECT @@SERVERNAME AS 'Nome do Servidor' -- Descobrir o nome do servidor
SELECT @@VERSION AS 'Vers�o' -- Descobrir a vers�o do SSMS


SELECT * FROM DimProduct
SELECT @@ROWCOUNT AS 'Contagem de linhas' -- Contagem de linhas da tabela
