-- M�DULO 18 - SQL SERVER - Constraints


/* AULA 08: Viola��o de Constraints Pt. 01

- Viola��o NOT NULL
Recapitulando, a CONSTRAINT NOT NULL n�o permite que sejam adicionados valores nulos � coluna.
Definimos a CONSTRAINT NOT NULL em diversas colunas da tabela dCliente e entre elas a coluna nome_cliente.

Isso significa que a coluna nome_cliente precisa ser devidamente preenchida quando inserimos um novo registro (linha) na tabela dCliente. Portanto, se tentarmos executar, por exemplo, o INSERT INTO abaixo, teremos um problema. */
INSERT INTO dCliente(Genero, Data_de_Nascimento, CPF) VALUES
	('F', '10/01/1989', '123.234.812-20');

/* Quando deixamos de informar uma coluna na hora de inserir novos dados, o sistema entende que aquela coluna deve ser deixada vazia (preenchida como NULL). Como definimos, quando criamos nossa tabela dCliente, a restri��o NOT NULL para a coluna nome_cliente, o sistema vai retornar o erro de c�digo. Desta forma, a tentativa de inser��o de um novo registro � considerada falha, e nenhum dado deste novo registro � salvo no banco de dados, nem mesmo nas outras colunas que atendiam �s especifica��es.


-  Viola��o CHECK
Recapitulando, a CONSTRAINT CHECK verifica se o valor adicionado na coluna atende a uma determinada condi��o.
Definimos a CONSTRAINT CHECK para a coluna genero da tabela dCliente, estabelecendo a condi��o: 
Genero IN ('M', 'F', 'O', 'PND')

Isso significa que a coluna genero s� pode ser preenchida com os valores 'M' (para masculino), 'F' (para feminino), 'O' (para outros) ou 'PND' (para prefiro n�o declarar) quando inserimos um novo registro (linha) na tabela dCliente. Portanto, se tentarmos executar, por exemplo, o INSERT INTO abaixo, teremos um problema. */
INSERT INTO dCliente(Nome_Cliente, Genero, Data_de_Nascimento, CPF) VALUES
	('Katia Lopes',  'Feminino', '10/01/1989', '123.234.812-20');

-- Quando violamos uma restri��o CHECK, o sistema retorna um erro informando os nomes da constraint, do banco de dados, da tabela e da coluna violada. Desta forma, a tentativa de inser��o de um novo registro � considerada falha, e nenhum dado deste novo registro � salvo no banco de dados, nem mesmo nas outras colunas que atendiam �s especifica��es.

------------------------------

/*  AULA 09: Viola��o de Constraints Pt. 02

- Viola��o UNIQUE
 Recapitulando, a CONSTRAINT UNIQUE identifica uma coluna de forma �nica, sem permitir valores duplicados. 
 Definimos a CONSTRAINT UNIQUE para a coluna cpf da tabela dCliente.

 Isso significa que a coluna cpf n�o pode receber um valor que j� conste na coluna como pertencente a algum outro registro (cliente) da tabela dCliente. Portanto, se tentarmos executar, por exemplo, o INSERT INTO abaixo, teremos mais um problema, pois o CPF informado j� foi informado como sendo de outro cliente. */

INSERT INTO dCliente(Nome_Cliente, Genero, Data_de_Nascimento, CPF) VALUES
	('Katia Lopes',  'F', '10/01/1989', '839.283.190-00');

-- Quando violamos uma restri��o UNIQUE, o sistema retorna um erro informando os nomes da constraint e da tabela, assim como o valor da chave duplicada. Desta forma, a tentativa de inser��o de um novo registro � considerada falha, e nenhum dado deste novo registro � salvo no banco de dados, nem mesmo nas outras colunas que atendiam �s especifica��es.

------------------------------

/* AULA 10: Viola��o de Constraints Pt. 03

- Viola��o PRIMARY KEY e FOREIGN KEY
Recapitulando, a CONSTRAINT PRYMARY KEY torna uma coluna prim�ria da tabela, ao passo que a CONSTRAINT FOREIGN KEY torna uma coluna uma chave estrangeira da tabela, que ser� relacionada � chave prim�ria (PRIMARY KEY) de outra tabela.

Definimos a CONSTRAINT FOREIGN KEY para a coluna id_gerente, que faz refer�ncia a PRIMARY KEY id_gerente estabelecida na tabela dGerente.

Isso significa que a coluna id_gerente da tabela fContratos n�o pode receber um ID de um gerente que n�o exista na coluna id_gerente da tabela dGerente. Portanto, se tentarmos executar, por exemplo, o INSERT INTO abaixo, teremos outro problema. Pois o id_gerente informado (10) n�o existe na tabela dGerente */

INSERT INTO fContratos(Data_Assinatura, ID_Cliente, ID_Gerente, Valor_Contrato) VALUES
    ('12/03/2022', 4, 10, 1500);

-- Quando violamos as restri��es PRIMARY KEY e FOREIGN KEY, o sistema retorna um erro informando os nomes da constraint, do banco de dados, da tabela e da coluna violada. Desta forma, a tentativa de inser��o de um novo registro � considerada falha, e nenhum dado deste novo registro � salvo no banco de dados, nem mesmo nas outras colunas que atendiam �s especifica��es.