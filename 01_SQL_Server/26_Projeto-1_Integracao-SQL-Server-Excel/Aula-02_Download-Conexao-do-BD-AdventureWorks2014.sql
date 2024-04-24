-- MÓDULO 26 - SQL SERVER - Integração SQL SERVER e EXCEL

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