-- M�DULO 28 - SQL SERVER - INTEGRA��O SQL SERVER - PYTHON

/* AULA 01 - Case 1 (Escrita) - Explica��o do Projeto de Integra��o
Neste m�dulo, vamos aprender como integrar o SQL Server ao Python.

Neste primeiro Case, faremos um projeto de escrita no banco de dados SQL Server utilizando o editor de c�digo Jupyter Notebook.

Para isso, vamos dividir esse pequeno projeto em quatro etapas:
1� Etapa: Preparando o SQL Server para a Integra��o;
2� Etapa: Configura��es iniciais no Jupyter;
3� Etapa: Adicionando os comandos em SQL dentro do Jupyter;
4� Etapa: Tornando o cadastro de dados autom�tico por meio de vari�veis; 
*/

------------------------------
/* AULA 02 - Case 1 (Escrita) - Preparando o SQL Server antes da integra��o
Inicialmente, precisamos searar preparar o SQL Server para receber os dados que ser�o inseridos no banco de dados por meio do Jupyter Notebook. 

Passo 1: Criar um novo banco de dados chamado PythonSQL
Passo 2: Criar uma tabela chamada Vendas com seis colunas (id_venda, data_venda, cliente, produto, preco, quantidade) que receber� os dados. 
Passo 3: Adicione o primeiro registro nesta tabela via SSMS para testar se est� tudo certo.	*/

CREATE DATABASE PythonSQL
USE PythonSQL

CREATE TABLE Vendas(
	id_venda INT,
	data_venda DATE,
	cliente VARCHAR(100),
	produto VARCHAR(100),
	preco DECIMAL(10, 2),
	quantidade INT
)

INSERT INTO Vendas(id_venda, data_venda, cliente, produto, preco, quantidade) VALUES
	(1, '22/04/2022', 'Ana', 'Celular', 2000, 1)

SELECT * FROM Vendas -- 1 resgitro = Tudo certo, OK!

-- Agora vamos para o Jupyter para a 2� etapa do nosso projeto.

------------------------------
/* AULA 03 - Case 1 (Escrita) - Configura��es iniciais no Jupyter
Se voc� n�o tiver o editor de c�digos Jupyter Notebook instalado em seu computador e precise de ajuda para efetuar essa instala��o, sugiro que acesse o link abaixo e siga o passo a passo.

Link: https://www.youtube.com/watch?v=_eK0z5QbpKA

Passo 1: Abra o Jupyter Notebook
Passo 2: Selecione a pasta que salvar� o scrpt que vamos construir e utilizar em nosso Case de escrita.
Passo 3: Clique em New e selecione Python 3 (ipykernel)
Passo 4: Com a janela aberta, o primeiro passo � instalarmos uma biblioteca do Python chamada pyodbc. 
Obs.: Essa biblioteca permite a integra��o do Python com o SQL Server. Para instala-l�, devemos digitar o comando pip install pyodbc e apertar as teclas de atalho Ctrls + Enter para executar o c�digo.
Instalada a biblioteca pyodbc, podemos agora criar o nosso c�digo de conex�o com o SQL Server.
Passo 5: Clique no �cone + para adicionar um nova c�lula.
Passo 6: Vamos importar a biblioteca pyodbc (que acabamos de instalar); Criaremos uma vari�vel que rebecer� os tr�s par�metros necess�rios para a conex�o (Driver, Server e Database); E efetuaremos a conex�o.
O Script ficar� assim: */

-- # Importando biblioteca pyodbc:
import pyodbc -- Comando ara importar a biblioteca

-- # criando dados de conex�o:
dados_conexao = (
    "Driver={SQL Server};"
    "Server=Nome_do_Servidor;"
    "Database=PythonSQL;"
)

-- # Conectando:
conexao = pyodbc.connect(dados_conexao)
print("Conex�o Bem Sucedida")

-- Obs.: Para descobrir o Nome do Servidor, abra o prompt de comando e digite hostname e aperte a tecla Enter.
-- Passo 7: Renomeie o nome do arquivo para Projeto 1 (Escrita)
-- Obs.: Se voltarmos � pasta onde abrimos o Jupyter inicialmente, veremos o nosso arquivo renomeado.

------------------------------
/* AULA 04 - Case 1 (Escrita) - Adicionando os comandos em SQL dentro do Jupyter
Agora, vamos executar a 3� etapa do nosso projeto, para inserirmos novos dados na tabela Vendas do banco de dados PythonSQL, armazenado no SQL Server, via Python, utilizando o Jupyter.

Passo 1: Clique no �cone + para adicionarmos uma nova c�lula.
Passo 2: Abriremos um cursor que receber� as informa��es da conex�o que efetuamos;
Passo 3: Criaremos uma vari�vel, chamada comando, que receber� o c�digo SQL de inser��o de um novo registro (INSERT INTO);
Passo 4: Passaremos a vari�vel comando ao cursor para que ele execute o c�digo SQL de inser��o de dados;
Passo 5: Daremos um commit com o cursor para que o novo registro seja efetivamente salvo na tabela Vendas;
Obs.: Nosso script ficar� assim: */

-- # incluindo registro id = 2

cursor = conexao.cursor()

comando = """INSERT INTO Vendas(id_venda, data_venda, cliente, produto, preco, quantidade) VALUES
	(2, '10/05/2022', 'Bruno', 'Notebook', 3500, 2)"""

cursor.execute(comando)

cursor.commit()

-- Passo 6: Vamos executar nosso c�digo desta c�lula com o comando Ctrl + Enter
-- Passo 7: Retornaremos ao SSMS e realizaremos uma consulta a tabela Vendas; Veremos que o registro que inserimos via Python foi realmente armazenado na tabela:
SELECT * FROM Vendas -- 2 registros = Tudo certo, OK! 

-- E se adicionarmos mais um registro via Python... Ao retornarmos ao SQL teremos agora 3 registros.
SELECT * FROM Vendas -- 3 registros = Tudo certo, OK! 

------------------------------
/* AULA 05 - Case 1 (Escrita) - Tornando o cadastro de dados autom�tico por meio de vari�veis
At� agora, vimos como inserir novos registros atrav�s do Jupyter utilizando dados informados diretamente no comando INSERT INTO.

Por�m, podemos deixar essa inser��o um pouco mais automatizada, fazendo com que quaisquer dados que sejam recebidos externamente sejam interpretados pelo c�digo do Jupyter e armazenados em seus respectivos campos da tabela Vendas do banco de dados PythonSQL do SQL Server atrav�s de vari�veis.
Nosso script ficar� assim: */

-- # incluindo demais registros

cursor = conexao.cursor()

id = 4
data = "17/06/2022"
cliente = "Diego"
produto = "Tablet"
preco = 1200
quantidade = 1

comando = f"""INSERT INTO Vendas(id_venda, data_venda, cliente, produto, preco, quantidade) VALUES
	({id}, '{data}', '{cliente}', '{produto}', {preco}, {quantidade})"""

cursor.execute(comando)

cursor.commit()

-- Agora vamos consultar nossa tabela Vendas no SSMS e veremos que novos registros foram adicionados.
SELECT * FROM Vendas -- 4 registros = Tudo certo, OK! 

-- Se alterarmos (o id, cliente, produto e preco) em nosso script no Jupyter, iremos inserir mais um registro;
SELECT * FROM Vendas -- 5 registros = Tudo certo, OK

-- Assim, finalizamos o nosso primeiro projeto, o Case 1, no qual vimos como podemos inserir novos registros em uma tabela de um banco de dados armazenado no SQL Server via Python, utilizando o editor de c�digos Jupyter Notebook.

------------------------------
/* AULA 06 - Case 2 (Leitura) - Explica��o do Projeto de Integra��o
Nas pr�ximas aulas, veremos novamente como integrar o SQL Server ao Python por�m, dessa vez n�o iremos realizar uma Escrita ou inser��o de informa��es no SQL atrav�s do Python, mas sim ler as informa��es do banco de dados ContosoRetailDW, levar essas informa��es para o Jupyter, agrupar esses dadps para, por fim, criar um gr�fico com base nesse agrupamento.

Para isso, dividiremos esse pequeno projeto em tr�s etapas:
1� Etapa: Importaremos as bibliotecas necess�rias do Python e criaremos a conex�o com o banco de dados;
2� Etapa: Faremos a leitura de uma tabela armazenada em um banco de dados do SQL Server via Python;
3� Etapa: Faremos agrupamentos b�sicos no Python e plotaremos um gr�fico de barras.
*/

------------------------------
/* AULA 07 - Case 2 (Leitura) - Importando bibliotecas do Python e criando a conex�o com o banco
Para criarmos nosso 2� projeto de integra��o do SQL Server com o Python, utilizaremos dados da tabela DimProduct do banco de dados ContosoRetailDW.
Basicamente, vamos querer levar para o Python as informa��es que constam nas colunas ColorName e UnitPrice da tabela DimProduct. */

USE ContosoRetailDW
SELECT ColorName, UnitPrice FROM DimProduct

/*
Passo 1: Abra o Jupyter Notebook
Passo 2: Selecione a pasta que salvar� o scrpt que vamos construir e utilizar em nosso Case de escrita.
Passo 3: Clique em New e selecione Python 3 (ipykernel)
Passo 4: Com a janela aberta, o primeiro passo � instalarmos uma biblioteca do Python chamada pyodbc. 
Obs.: Essa biblioteca permite a integra��o do Python com o SQL Server. Para instala-l�, devemos digitar o comando pip install pyodbc e apertar as teclas de atalho Ctrls + Enter para executar o c�digo. Instalada � biblioteca pyodbc, podemos agora criar o nosso c�digo de conex�o com o SQL Server.
Passo 5: Clique no �cone + para adicionar um nova c�lula.
Passo 6: Vamos importar a biblioteca pyodbc (que acabamos de instalar), biblioteca pandas e biblioteca matplotlib; Criaremos uma vari�vel que rebecer� os tr�s par�metros necess�rios para a conex�o (Driver, Server e Database); E efetuaremos a conex�o. O Script ficar� assim: */

-- # Importando as bibliotecas necess�roas:
import pyodbc
import pandas as pd
import matplotlib

-- # Criando dados de conex�o:
dados_conexao = (
    "Driver={SQL Server};"
    "Server=Nome_do_Servidor;"
    "Database=ContosoRetailDW;"
)

-- # Conectando:
conexao = pyodbc.connect(dados_conexao)
print("Conex�o Bem Sucedida")

-- Obs.: Para descobrir o Nome do Servidor, abra o prompt de comando e digite hostname e aperte a tecla Enter.
-- Passo 7: Renomeie o nome do arquivo para Projeto 2 (Leitura)

------------------------------
/* AULA 08 - Case 2 (Leitura) - Fazendo a leitura de uma tabela do SQL Server via Python
Agora, vamos executar a 2� etapa do nosso projeto, para fazermos a leitura das informa��es que queremos extrair da tabela DimProduct do banco de dados ContosoRetailDW, armazenado no SQL Server, via Python, utilizando o Jupyter.

Passo 1: Clique no �cone + para adicionarmos uma nova c�lula.
Passo 2: Criar uma vari�vel, chamada comando_sql, que receber� o c�digo SQL de consulta �s colunas ColorName e UnitPrice da tabela DimProduct (SELECT), entre aspas;
Passo 3: Criar outra vari�vel, chamada dados, que armazenar� os dados extra�dos do SQl Server. Para isso, passaremos para essa vari�vel o m�todo pd.read_sql da biblioteca pandas, informando como seus par�metros as vari�veis comando_sql (que cont�m o c�digo SQL de consulta aos dados que queremos) e conexao (que cont�m as informa��es da conex�o com o SQL Server)
Obs.: Nosso script ficar� assim: */

-- # Fazendo a leitura da tabela no SQL Server:
comando_sql = "SELECT ColorName, UnitPrice FROM DimProduct"

dados = pd.read_sql(comando_sql, conexao)

-- Passo 4: Vamos criar uma nova c�lula, com o c�digo abaixo para poder visualizar o resultado armazenado na vari�vel dados:

-- # Visualizando os dados extra�dos do SQL Server:
display(dados)

-- Obs.: Executando o c�digo acima, retornamos na tela todos os campos das 2517 linhas das 2 colunas que extra�mos da tabela DimProduct (ColorName e UnitPrice).

------------------------------
/* AULA 09 - Case 2 (Leitura) - Agrupamentos b�sicos no Python utilizando Group By e Plotando um gr�fico de barras
Iremos finalizar agora nosso projeto realizando a 3� etapa do nosso projeto, em que agruparemos a tabela que importamos do SQL Server para fazermos uma contagem de quantos produtos temos de cada cor.

Em seguida, iremos plotar um gr�fico de barras na tela do Jupyter.

Para agruparmos a tabela por cor, junto com � vari�vel dados (que armazena a tabela importada do SQL Server), utilizadmos o m�todo groupby(), passando para ele como par�metro o nome da coluna pela qual queremos agrupar (ColorName). Em seguida, faremos uma contagem de linhas desse agrupamento para cada cor, utilizando a fun��o Count(); Nosso script ficar� assim: 

# Criando um agrupamento do total de produtos por cores: */
dados.groupby('ColorName').count()

-- Agora, vamos criar um gr�fico a partir desse comando por�m, repare que o resultado que obtivemos n�o ficou armazenado em nenhum lugar, e dessa forma n�o temos como transform�-lo em um gr�fico. Por isso, primeiro precisaremos armazenar a nossa tabela agrupada em uma vari�vel e posteriormente plotar o nosso gr�fico. Portanto, iremos criar uma vari�vel chamada total_produtos_por_cor, e informar para ela o comando que cria o agrupamento. Nosso script ficar� assim:

--# Armazenando o agrupamento em uma vari�vel:
total_produtos_por_cor = dados.groupby('ColorName').count()

-- Em seguida, vamos utilizar o comando display e a vari�vel total_produtos_por_cor como seu par�metro, para podermos ver que a tabela agrupada foi de fato armazenada na vari�vel referida.

-- # Visualizando o agrupamento armazenado na vari�vel:
display(total_produtos_por_cor)

-- Agora sim, podemos plotar um gr�fico de barras utilizando os dados do agrupamento efetuado. Para isso, junto a vari�vel total_produtos_por_cor (que armazena a tabela agrupada), utilizaremos a fun~��o plot(), passando para ela o argumento kind='bar', que informa que queremos que seja mostrado na tela um gr�fico do tipo (kind) barras (bar):

-- # Plotando um gr�fico do agrupamento:
total_produtos_por_cor.plot(kind='bar')

-- Agora sim, com o gr�fico plotado conseguimos visualizar melhor o resultado do nosso agrupamento. E logo no primeiro momento j� podemos identificar que a cor com maior quantidade de produtos � a Black (preta), seguida da White (Branca), Silver (prata), Grey (cinza), etc...

-- Pronto! Nosso mini projeto est� conclu�do. Podemos salvar nosso arquivo.