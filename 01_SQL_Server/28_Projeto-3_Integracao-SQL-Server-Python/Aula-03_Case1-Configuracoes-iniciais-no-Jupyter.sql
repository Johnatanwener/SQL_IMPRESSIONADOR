-- M�DULO 28 - SQL SERVER - INTEGRA��O SQL SERVER - PYTHON

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