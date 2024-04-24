-- MÓDULO 18 - SQL SERVER - Constraints


 /* AULA 02: NOT NULL, UNIQUE, CHECK, DEFAULT, IDENTIFY, PRIMARY KEY, FOREIGN KEY

CONSTRAINTS no SQL são regras (restrições) que podemos definir para uma coluna de uma tabela. Essas regras garantem integridade ao Banco de Dados, pois é através delas que garantimos que apenas os valores que atendam às regras pré-estabelecidas sejam incluídos em cada coluna.

1. NOT NULL
- Essa constraint não permite que sejam adicionados valores nulos na coluna.

2. UNIQUE
- Identifica uma coluna de forma única, sem permitir valores duplicados (mas, permite NULL).

3. CHECK
- Verifica se o valor adicionado na coluna atende a uma determinada condição.

4. DEFAULT
- Retorna um valor default caso a coluna não seja preenchida.

5. IDENTITY
- Permite que uma coluna siga uma auto numeração (usada em colunas de ID).

6. PRIMARY KEY
- Uma CHAVE PRIMÁRIA (PRIMARY KEY) é uma coluna que identifica de forma única as linhas de uma tabela. Nenhum dos valores de uma coluna de chave primária deve ser nulo ou se repetir.
	Será através dessa coluna que criaremos relações entre as tabelas.

7. FOREIGN KEY
- Uma CHAVE ESTRANGEIRA (FOREIGN KEY) é uma coluna que será relacionada com a CHAVE PRIMÁRIA de uma outra tabela. */