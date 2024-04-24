-- M�DULO 26 - SQL SERVER - Integra��o SQL SERVER e EXCEL

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