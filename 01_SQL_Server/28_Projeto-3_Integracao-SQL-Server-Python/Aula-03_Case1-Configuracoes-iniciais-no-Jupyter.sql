-- MÓDULO 28 - SQL SERVER - INTEGRAÇÃO SQL SERVER - PYTHON

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