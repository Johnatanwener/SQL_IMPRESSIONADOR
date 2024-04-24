-- MÓDULO 28 - SQL SERVER - INTEGRAÇÃO SQL SERVER - PYTHON

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
