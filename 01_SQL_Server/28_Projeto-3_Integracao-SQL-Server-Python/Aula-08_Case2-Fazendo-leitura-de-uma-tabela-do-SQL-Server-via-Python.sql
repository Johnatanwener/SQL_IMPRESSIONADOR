-- M�DULO 28 - SQL SERVER - INTEGRA��O SQL SERVER - PYTHON

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
