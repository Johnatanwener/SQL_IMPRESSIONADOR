-- MÓDULO 28 - SQL SERVER - INTEGRAÇÃO SQL SERVER - PYTHON

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