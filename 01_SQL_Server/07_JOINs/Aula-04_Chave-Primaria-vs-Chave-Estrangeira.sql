-- MÓDULO 07 - SQL SERVER - JOINs 

/* AULA 04 - Chave Primária VS. Chave Estrangeira
Uma CHAVE PRIMÁRIA é uma coluna que identifica as informações distintas em uma tabela. Geralmente é uma coluna de ID. Toda tabela terá uma, e somente uma, Chave Primária. Essa chave é utilizada como identificador único da tabela, sendo representada por uma coluna que não receberá valores repetidos.

Uma CHAVE ESTRANGEIRA é uma coluna que permite relacionar as linhas de uma segunda tabela com a Chave Primária de uma primeira tabela.

Como será possível identificar, cada tabela de um banco de dados irá possui uma coluna chamada ID, com valores que não se repetem, geralmente será a coluna1. Essa coluna será a Chave Primária, exemplo (Col1_Tab1). Essa mesma coluna poderá ser vinculada em outra tabela que também terá a sua própria Chave Primária, exemplo (Col1_Tab2), e ao ser vinculada em outra tabela, essa Chave Primária (Col1_Tab1), passará a ser uma Chave Estrangeira na (Tabela 2), pois pertence originalmente a outra tabela (Tabela 1).
*/