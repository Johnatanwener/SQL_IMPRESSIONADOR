-- M�DULO 28 - SQL SERVER - INTEGRA��O SQL SERVER - PYTHON

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