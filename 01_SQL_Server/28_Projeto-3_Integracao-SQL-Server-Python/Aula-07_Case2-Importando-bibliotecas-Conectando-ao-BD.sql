-- M�DULO 28 - SQL SERVER - INTEGRA��O SQL SERVER - PYTHON

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