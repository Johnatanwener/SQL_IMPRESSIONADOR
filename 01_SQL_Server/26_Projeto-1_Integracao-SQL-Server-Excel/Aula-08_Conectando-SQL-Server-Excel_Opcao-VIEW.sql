-- MÓDULO 26 - SQL SERVER - Integração SQL SERVER e EXCEL

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