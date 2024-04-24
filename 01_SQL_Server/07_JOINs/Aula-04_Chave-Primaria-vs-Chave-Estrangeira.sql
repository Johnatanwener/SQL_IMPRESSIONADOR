-- M�DULO 07 - SQL SERVER - JOINs 

/* AULA 04 - Chave Prim�ria VS. Chave Estrangeira
Uma CHAVE PRIM�RIA � uma coluna que identifica as informa��es distintas em uma tabela. Geralmente � uma coluna de ID. Toda tabela ter� uma, e somente uma, Chave Prim�ria. Essa chave � utilizada como identificador �nico da tabela, sendo representada por uma coluna que n�o receber� valores repetidos.

Uma CHAVE ESTRANGEIRA � uma coluna que permite relacionar as linhas de uma segunda tabela com a Chave Prim�ria de uma primeira tabela.

Como ser� poss�vel identificar, cada tabela de um banco de dados ir� possui uma coluna chamada ID, com valores que n�o se repetem, geralmente ser� a coluna1. Essa coluna ser� a Chave Prim�ria, exemplo (Col1_Tab1). Essa mesma coluna poder� ser vinculada em outra tabela que tamb�m ter� a sua pr�pria Chave Prim�ria, exemplo (Col1_Tab2), e ao ser vinculada em outra tabela, essa Chave Prim�ria (Col1_Tab1), passar� a ser uma Chave Estrangeira na (Tabela 2), pois pertence originalmente a outra tabela (Tabela 1).
*/