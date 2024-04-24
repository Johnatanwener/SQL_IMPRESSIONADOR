-- MÓDULO 28 - SQL SERVER - INTEGRAÇÃO SQL SERVER - PYTHON

/* AULA 01 - Case 1 (Escrita) - Explicação do Projeto de Integração
Neste módulo, vamos aprender como integrar o SQL Server ao Python.

Neste primeiro Case, faremos um projeto de escrita no banco de dados SQL Server utilizando o editor de código Jupyter Notebook.

Para isso, vamos dividir esse pequeno projeto em quatro etapas:
1ª Etapa: Preparando o SQL Server para a Integração;
2ª Etapa: Configurações iniciais no Jupyter;
3ª Etapa: Adicionando os comandos em SQL dentro do Jupyter;
4ª Etapa: Tornando o cadastro de dados automático por meio de variáveis; 
*/

------------------------------
/* AULA 02 - Case 1 (Escrita) - Preparando o SQL Server antes da integração
Inicialmente, precisamos searar preparar o SQL Server para receber os dados que serão inseridos no banco de dados por meio do Jupyter Notebook. 

Passo 1: Criar um novo banco de dados chamado PythonSQL
Passo 2: Criar uma tabela chamada Vendas com seis colunas (id_venda, data_venda, cliente, produto, preco, quantidade) que receberá os dados. 
Passo 3: Adicione o primeiro registro nesta tabela via SSMS para testar se está tudo certo.	*/

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

-- Agora vamos para o Jupyter para a 2ª etapa do nosso projeto.

------------------------------
/* AULA 03 - Case 1 (Escrita) - Configurações iniciais no Jupyter
Se você não tiver o editor de códigos Jupyter Notebook instalado em seu computador e precise de ajuda para efetuar essa instalação, sugiro que acesse o link abaixo e siga o passo a passo.

Link: https://www.youtube.com/watch?v=_eK0z5QbpKA

Passo 1: Abra o Jupyter Notebook
Passo 2: Selecione a pasta que salvará o scrpt que vamos construir e utilizar em nosso Case de escrita.
Passo 3: Clique em New e selecione Python 3 (ipykernel)
Passo 4: Com a janela aberta, o primeiro passo é instalarmos uma biblioteca do Python chamada pyodbc. 
Obs.: Essa biblioteca permite a integração do Python com o SQL Server. Para instala-lá, devemos digitar o comando pip install pyodbc e apertar as teclas de atalho Ctrls + Enter para executar o código.
Instalada a biblioteca pyodbc, podemos agora criar o nosso código de conexão com o SQL Server.
Passo 5: Clique no ícone + para adicionar um nova célula.
Passo 6: Vamos importar a biblioteca pyodbc (que acabamos de instalar); Criaremos uma variável que rebecerá os três parâmetros necessários para a conexão (Driver, Server e Database); E efetuaremos a conexão.
O Script ficará assim: */

-- # Importando biblioteca pyodbc:
import pyodbc -- Comando ara importar a biblioteca

-- # criando dados de conexão:
dados_conexao = (
    "Driver={SQL Server};"
    "Server=Nome_do_Servidor;"
    "Database=PythonSQL;"
)

-- # Conectando:
conexao = pyodbc.connect(dados_conexao)
print("Conexão Bem Sucedida")

-- Obs.: Para descobrir o Nome do Servidor, abra o prompt de comando e digite hostname e aperte a tecla Enter.
-- Passo 7: Renomeie o nome do arquivo para Projeto 1 (Escrita)
-- Obs.: Se voltarmos à pasta onde abrimos o Jupyter inicialmente, veremos o nosso arquivo renomeado.

------------------------------
/* AULA 04 - Case 1 (Escrita) - Adicionando os comandos em SQL dentro do Jupyter
Agora, vamos executar a 3ª etapa do nosso projeto, para inserirmos novos dados na tabela Vendas do banco de dados PythonSQL, armazenado no SQL Server, via Python, utilizando o Jupyter.

Passo 1: Clique no ícone + para adicionarmos uma nova célula.
Passo 2: Abriremos um cursor que receberá as informações da conexão que efetuamos;
Passo 3: Criaremos uma variável, chamada comando, que receberá o código SQL de inserção de um novo registro (INSERT INTO);
Passo 4: Passaremos a variável comando ao cursor para que ele execute o código SQL de inserção de dados;
Passo 5: Daremos um commit com o cursor para que o novo registro seja efetivamente salvo na tabela Vendas;
Obs.: Nosso script ficará assim: */

-- # incluindo registro id = 2

cursor = conexao.cursor()

comando = """INSERT INTO Vendas(id_venda, data_venda, cliente, produto, preco, quantidade) VALUES
	(2, '10/05/2022', 'Bruno', 'Notebook', 3500, 2)"""

cursor.execute(comando)

cursor.commit()

-- Passo 6: Vamos executar nosso código desta célula com o comando Ctrl + Enter
-- Passo 7: Retornaremos ao SSMS e realizaremos uma consulta a tabela Vendas; Veremos que o registro que inserimos via Python foi realmente armazenado na tabela:
SELECT * FROM Vendas -- 2 registros = Tudo certo, OK! 

-- E se adicionarmos mais um registro via Python... Ao retornarmos ao SQL teremos agora 3 registros.
SELECT * FROM Vendas -- 3 registros = Tudo certo, OK! 

------------------------------
/* AULA 05 - Case 1 (Escrita) - Tornando o cadastro de dados automático por meio de variáveis
Até agora, vimos como inserir novos registros através do Jupyter utilizando dados informados diretamente no comando INSERT INTO.

Porém, podemos deixar essa inserção um pouco mais automatizada, fazendo com que quaisquer dados que sejam recebidos externamente sejam interpretados pelo código do Jupyter e armazenados em seus respectivos campos da tabela Vendas do banco de dados PythonSQL do SQL Server através de variáveis.
Nosso script ficará assim: */

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

-- Assim, finalizamos o nosso primeiro projeto, o Case 1, no qual vimos como podemos inserir novos registros em uma tabela de um banco de dados armazenado no SQL Server via Python, utilizando o editor de códigos Jupyter Notebook.

------------------------------
/* AULA 06 - Case 2 (Leitura) - Explicação do Projeto de Integração
Nas próximas aulas, veremos novamente como integrar o SQL Server ao Python porém, dessa vez não iremos realizar uma Escrita ou inserção de informações no SQL através do Python, mas sim ler as informações do banco de dados ContosoRetailDW, levar essas informações para o Jupyter, agrupar esses dadps para, por fim, criar um gráfico com base nesse agrupamento.

Para isso, dividiremos esse pequeno projeto em três etapas:
1ª Etapa: Importaremos as bibliotecas necessárias do Python e criaremos a conexão com o banco de dados;
2ª Etapa: Faremos a leitura de uma tabela armazenada em um banco de dados do SQL Server via Python;
3ª Etapa: Faremos agrupamentos básicos no Python e plotaremos um gráfico de barras.
*/

------------------------------
/* AULA 07 - Case 2 (Leitura) - Importando bibliotecas do Python e criando a conexão com o banco
Para criarmos nosso 2º projeto de integração do SQL Server com o Python, utilizaremos dados da tabela DimProduct do banco de dados ContosoRetailDW.
Basicamente, vamos querer levar para o Python as informações que constam nas colunas ColorName e UnitPrice da tabela DimProduct. */

USE ContosoRetailDW
SELECT ColorName, UnitPrice FROM DimProduct

/*
Passo 1: Abra o Jupyter Notebook
Passo 2: Selecione a pasta que salvará o scrpt que vamos construir e utilizar em nosso Case de escrita.
Passo 3: Clique em New e selecione Python 3 (ipykernel)
Passo 4: Com a janela aberta, o primeiro passo é instalarmos uma biblioteca do Python chamada pyodbc. 
Obs.: Essa biblioteca permite a integração do Python com o SQL Server. Para instala-lá, devemos digitar o comando pip install pyodbc e apertar as teclas de atalho Ctrls + Enter para executar o código. Instalada à biblioteca pyodbc, podemos agora criar o nosso código de conexão com o SQL Server.
Passo 5: Clique no ícone + para adicionar um nova célula.
Passo 6: Vamos importar a biblioteca pyodbc (que acabamos de instalar), biblioteca pandas e biblioteca matplotlib; Criaremos uma variável que rebecerá os três parâmetros necessários para a conexão (Driver, Server e Database); E efetuaremos a conexão. O Script ficará assim: */

-- # Importando as bibliotecas necessároas:
import pyodbc
import pandas as pd
import matplotlib

-- # Criando dados de conexão:
dados_conexao = (
    "Driver={SQL Server};"
    "Server=Nome_do_Servidor;"
    "Database=ContosoRetailDW;"
)

-- # Conectando:
conexao = pyodbc.connect(dados_conexao)
print("Conexão Bem Sucedida")

-- Obs.: Para descobrir o Nome do Servidor, abra o prompt de comando e digite hostname e aperte a tecla Enter.
-- Passo 7: Renomeie o nome do arquivo para Projeto 2 (Leitura)

------------------------------
/* AULA 08 - Case 2 (Leitura) - Fazendo a leitura de uma tabela do SQL Server via Python
Agora, vamos executar a 2ª etapa do nosso projeto, para fazermos a leitura das informações que queremos extrair da tabela DimProduct do banco de dados ContosoRetailDW, armazenado no SQL Server, via Python, utilizando o Jupyter.

Passo 1: Clique no ícone + para adicionarmos uma nova célula.
Passo 2: Criar uma variável, chamada comando_sql, que receberá o código SQL de consulta às colunas ColorName e UnitPrice da tabela DimProduct (SELECT), entre aspas;
Passo 3: Criar outra variável, chamada dados, que armazenará os dados extraídos do SQl Server. Para isso, passaremos para essa variável o método pd.read_sql da biblioteca pandas, informando como seus parâmetros as variáveis comando_sql (que contém o código SQL de consulta aos dados que queremos) e conexao (que contém as informações da conexão com o SQL Server)
Obs.: Nosso script ficará assim: */

-- # Fazendo a leitura da tabela no SQL Server:
comando_sql = "SELECT ColorName, UnitPrice FROM DimProduct"

dados = pd.read_sql(comando_sql, conexao)

-- Passo 4: Vamos criar uma nova célula, com o código abaixo para poder visualizar o resultado armazenado na variável dados:

-- # Visualizando os dados extraídos do SQL Server:
display(dados)

-- Obs.: Executando o código acima, retornamos na tela todos os campos das 2517 linhas das 2 colunas que extraímos da tabela DimProduct (ColorName e UnitPrice).

------------------------------
/* AULA 09 - Case 2 (Leitura) - Agrupamentos básicos no Python utilizando Group By e Plotando um gráfico de barras
Iremos finalizar agora nosso projeto realizando a 3ª etapa do nosso projeto, em que agruparemos a tabela que importamos do SQL Server para fazermos uma contagem de quantos produtos temos de cada cor.

Em seguida, iremos plotar um gráfico de barras na tela do Jupyter.

Para agruparmos a tabela por cor, junto com à variável dados (que armazena a tabela importada do SQL Server), utilizadmos o método groupby(), passando para ele como parâmetro o nome da coluna pela qual queremos agrupar (ColorName). Em seguida, faremos uma contagem de linhas desse agrupamento para cada cor, utilizando a função Count(); Nosso script ficará assim: 

# Criando um agrupamento do total de produtos por cores: */
dados.groupby('ColorName').count()

-- Agora, vamos criar um gráfico a partir desse comando porém, repare que o resultado que obtivemos não ficou armazenado em nenhum lugar, e dessa forma não temos como transformá-lo em um gráfico. Por isso, primeiro precisaremos armazenar a nossa tabela agrupada em uma variável e posteriormente plotar o nosso gráfico. Portanto, iremos criar uma variável chamada total_produtos_por_cor, e informar para ela o comando que cria o agrupamento. Nosso script ficará assim:

--# Armazenando o agrupamento em uma variável:
total_produtos_por_cor = dados.groupby('ColorName').count()

-- Em seguida, vamos utilizar o comando display e a variável total_produtos_por_cor como seu parâmetro, para podermos ver que a tabela agrupada foi de fato armazenada na variável referida.

-- # Visualizando o agrupamento armazenado na variável:
display(total_produtos_por_cor)

-- Agora sim, podemos plotar um gráfico de barras utilizando os dados do agrupamento efetuado. Para isso, junto a variável total_produtos_por_cor (que armazena a tabela agrupada), utilizaremos a fun~ção plot(), passando para ela o argumento kind='bar', que informa que queremos que seja mostrado na tela um gráfico do tipo (kind) barras (bar):

-- # Plotando um gráfico do agrupamento:
total_produtos_por_cor.plot(kind='bar')

-- Agora sim, com o gráfico plotado conseguimos visualizar melhor o resultado do nosso agrupamento. E logo no primeiro momento já podemos identificar que a cor com maior quantidade de produtos é a Black (preta), seguida da White (Branca), Silver (prata), Grey (cinza), etc...

-- Pronto! Nosso mini projeto está concluído. Podemos salvar nosso arquivo.