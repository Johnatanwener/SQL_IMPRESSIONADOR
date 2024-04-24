-- M�DULO 28 - SQL SERVER - INTEGRA��O SQL SERVER - PYTHON

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