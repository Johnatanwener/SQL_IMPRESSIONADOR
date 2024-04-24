-- M�DULO 18 - SQL SERVER - Constraints


 /* AULA 02: NOT NULL, UNIQUE, CHECK, DEFAULT, IDENTIFY, PRIMARY KEY, FOREIGN KEY

CONSTRAINTS no SQL s�o regras (restri��es) que podemos definir para uma coluna de uma tabela. Essas regras garantem integridade ao Banco de Dados, pois � atrav�s delas que garantimos que apenas os valores que atendam �s regras pr�-estabelecidas sejam inclu�dos em cada coluna.

1. NOT NULL
- Essa constraint n�o permite que sejam adicionados valores nulos na coluna.

2. UNIQUE
- Identifica uma coluna de forma �nica, sem permitir valores duplicados (mas, permite NULL).

3. CHECK
- Verifica se o valor adicionado na coluna atende a uma determinada condi��o.

4. DEFAULT
- Retorna um valor default caso a coluna n�o seja preenchida.

5. IDENTITY
- Permite que uma coluna siga uma auto numera��o (usada em colunas de ID).

6. PRIMARY KEY
- Uma CHAVE PRIM�RIA (PRIMARY KEY) � uma coluna que identifica de forma �nica as linhas de uma tabela. Nenhum dos valores de uma coluna de chave prim�ria deve ser nulo ou se repetir.
	Ser� atrav�s dessa coluna que criaremos rela��es entre as tabelas.

7. FOREIGN KEY
- Uma CHAVE ESTRANGEIRA (FOREIGN KEY) � uma coluna que ser� relacionada com a CHAVE PRIM�RIA de uma outra tabela. */