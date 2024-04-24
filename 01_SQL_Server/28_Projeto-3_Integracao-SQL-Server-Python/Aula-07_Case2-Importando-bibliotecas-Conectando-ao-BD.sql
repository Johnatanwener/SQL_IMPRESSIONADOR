-- MÓDULO 28 - SQL SERVER - INTEGRAÇÃO SQL SERVER - PYTHON

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