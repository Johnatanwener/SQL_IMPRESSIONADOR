-- MÓDULO 18 - SQL SERVER - Constraints


/* AULA 08: Violação de Constraints Pt. 01

- Violação NOT NULL
Recapitulando, a CONSTRAINT NOT NULL não permite que sejam adicionados valores nulos à coluna.
Definimos a CONSTRAINT NOT NULL em diversas colunas da tabela dCliente e entre elas a coluna nome_cliente.

Isso significa que a coluna nome_cliente precisa ser devidamente preenchida quando inserimos um novo registro (linha) na tabela dCliente. Portanto, se tentarmos executar, por exemplo, o INSERT INTO abaixo, teremos um problema. */
INSERT INTO dCliente(Genero, Data_de_Nascimento, CPF) VALUES
	('F', '10/01/1989', '123.234.812-20');

/* Quando deixamos de informar uma coluna na hora de inserir novos dados, o sistema entende que aquela coluna deve ser deixada vazia (preenchida como NULL). Como definimos, quando criamos nossa tabela dCliente, a restrição NOT NULL para a coluna nome_cliente, o sistema vai retornar o erro de código. Desta forma, a tentativa de inserção de um novo registro é considerada falha, e nenhum dado deste novo registro é salvo no banco de dados, nem mesmo nas outras colunas que atendiam às especificações.


-  Violação CHECK
Recapitulando, a CONSTRAINT CHECK verifica se o valor adicionado na coluna atende a uma determinada condição.
Definimos a CONSTRAINT CHECK para a coluna genero da tabela dCliente, estabelecendo a condição: 
Genero IN ('M', 'F', 'O', 'PND')

Isso significa que a coluna genero só pode ser preenchida com os valores 'M' (para masculino), 'F' (para feminino), 'O' (para outros) ou 'PND' (para prefiro não declarar) quando inserimos um novo registro (linha) na tabela dCliente. Portanto, se tentarmos executar, por exemplo, o INSERT INTO abaixo, teremos um problema. */
INSERT INTO dCliente(Nome_Cliente, Genero, Data_de_Nascimento, CPF) VALUES
	('Katia Lopes',  'Feminino', '10/01/1989', '123.234.812-20');

-- Quando violamos uma restrição CHECK, o sistema retorna um erro informando os nomes da constraint, do banco de dados, da tabela e da coluna violada. Desta forma, a tentativa de inserção de um novo registro é considerada falha, e nenhum dado deste novo registro é salvo no banco de dados, nem mesmo nas outras colunas que atendiam às especificações.

------------------------------

/*  AULA 09: Violação de Constraints Pt. 02

- Violação UNIQUE
 Recapitulando, a CONSTRAINT UNIQUE identifica uma coluna de forma única, sem permitir valores duplicados. 
 Definimos a CONSTRAINT UNIQUE para a coluna cpf da tabela dCliente.

 Isso significa que a coluna cpf não pode receber um valor que já conste na coluna como pertencente a algum outro registro (cliente) da tabela dCliente. Portanto, se tentarmos executar, por exemplo, o INSERT INTO abaixo, teremos mais um problema, pois o CPF informado já foi informado como sendo de outro cliente. */

INSERT INTO dCliente(Nome_Cliente, Genero, Data_de_Nascimento, CPF) VALUES
	('Katia Lopes',  'F', '10/01/1989', '839.283.190-00');

-- Quando violamos uma restrição UNIQUE, o sistema retorna um erro informando os nomes da constraint e da tabela, assim como o valor da chave duplicada. Desta forma, a tentativa de inserção de um novo registro é considerada falha, e nenhum dado deste novo registro é salvo no banco de dados, nem mesmo nas outras colunas que atendiam às especificações.

------------------------------

/* AULA 10: Violação de Constraints Pt. 03

- Violação PRIMARY KEY e FOREIGN KEY
Recapitulando, a CONSTRAINT PRYMARY KEY torna uma coluna primária da tabela, ao passo que a CONSTRAINT FOREIGN KEY torna uma coluna uma chave estrangeira da tabela, que será relacionada à chave primária (PRIMARY KEY) de outra tabela.

Definimos a CONSTRAINT FOREIGN KEY para a coluna id_gerente, que faz referência a PRIMARY KEY id_gerente estabelecida na tabela dGerente.

Isso significa que a coluna id_gerente da tabela fContratos não pode receber um ID de um gerente que não exista na coluna id_gerente da tabela dGerente. Portanto, se tentarmos executar, por exemplo, o INSERT INTO abaixo, teremos outro problema. Pois o id_gerente informado (10) não existe na tabela dGerente */

INSERT INTO fContratos(Data_Assinatura, ID_Cliente, ID_Gerente, Valor_Contrato) VALUES
    ('12/03/2022', 4, 10, 1500);

-- Quando violamos as restrições PRIMARY KEY e FOREIGN KEY, o sistema retorna um erro informando os nomes da constraint, do banco de dados, da tabela e da coluna violada. Desta forma, a tentativa de inserção de um novo registro é considerada falha, e nenhum dado deste novo registro é salvo no banco de dados, nem mesmo nas outras colunas que atendiam às especificações.