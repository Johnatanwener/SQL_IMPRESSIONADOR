-- MÓDULO 18 - SQL SERVER - Constraints


-- AULA 11: Gerenciando CONSTRAINTS
-- Vejamos agora como fazemos para adicionar, renomear e remover CONSTRAINTS.

/* 1. Adicionar constraints
Para ADICIONAR uma nova CONSTRAINT a uma tabela, utilizamos a seguinte sintaxe: 
ALTER TABLE nome_da_tabela
ADD CONSTRAINT nome_da_nova_constraint tipo_da_nova_constraint (nome_da_coluna);
Exemplos: */

-- Adicione a constraint PK id_venda na tabela fContratos.
ALTER TABLE fContratos
ADD CONSTRAINT fcontratos_id_contrato_pk PRIMARY KEY(id_contrato)

-- Adicione a constraint FK id_cliente na tabela fContratos.
ALTER TABLE fContratos
ADD CONSTRAINT fcontratos_id_cliente_fk FOREIGN KEY(id_cliente) REFERENCES dCliente(id_cliente)

/* 2. Renomear constraints
Para RENOMEAR uma CONSTRAINT de uma tabela, devemos clicar com o botão direito sobre o nome constraint no menu lateral esquerdo da tela (Bancos de Dados > Nome_do_Banco_de_Dados > Tabelas > Nome_da_Tabela > Chaves > Nome_da_Constraint), após em Renomear: */

/* 3. Remover constraints
Para REMOVER uma CONSTRAINT de uma tabela, utilizamos a seguinte sintaxe:

ALTER TABLE nome_da_tabela
DROP CONSTRAINT nome_da_constraint;
Exemplos:	*/

-- Remova a constraint PK da tabela fContratos.
ALTER TABLE fContratos
DROP CONSTRAINT fcontratos_id_contrato_pk

-- Remova a constraint FK Cliente da tabela fContratos.
ALTER TABLE fContratos
DROP CONSTRAINT fcontratos_id_cliente_fk