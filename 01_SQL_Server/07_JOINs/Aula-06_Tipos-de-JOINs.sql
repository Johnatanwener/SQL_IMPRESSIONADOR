-- MÓDULO 07 - SQL SERVER - JOINs 


/* AULA 06 - Tipos de JOIN - Explicação
Vimos que existem dois tipos de tabelas: Dimensão e Fato. Essas tabelas podem ser relacionadas através de uma coluna na tabela Dimensão, que identificamos como Chave Primária, e que será relacionada com a chave Estrangeira da tabela Fato.

Essas relações serão criadas por meio das cláusulas JOINs. OS JOINs vão nos permitir juntar/unir as nossas tabelas Fato e Dimensão de forma a complementar as informações umas das outras.

Existem diversos tipos de JOINs no SQL: 
- LEFT (OUTER) JOIN
	O LEFT JOIN permite relacionar duas tabelas e criar uma nova tabela. A tabela resultante desse JOIN terá todas as linhas exclusivas da tabela A, mais as linhas que são a interseção entre a tabela A e a tabela B. Nenhuma linha presente apenas na tabela B será incluída na tabela resultante desse JOIN.

- RIGHT (OUTER) JOIN 
	O RIGHT JOIN permite relacionar duas tabelas e criar uma nova tabela. A tabela resultante desse JOIN terá todas as linhas exclusivas da tabela B, mais as linhas que são a interseção entre a tabela A e a tabela B. Nenhuma linha presente apenas na tabela A será incluída na tabela resultante desse JOIN.

- INNER JOIN 
	O INNER JOIN permite relacionar duas tabelas e criar uma nova tabela. A tabela resultante desse JOIN terá apenas as linhas que são a interseção entre a tabela A e a tabela B.

- FULL (OUTER) JOIN 
	O FULL JOIN permite relacionar duas tabelas e criar uma nova tabela. A tabela resultante desse JOIN terá todas as linhas da tabela A e todas as linhas da tabela B.

- LEFT ANTI JOIN 
	O LEFT ANTI JOIN permite relacionar duas tabelas e criar uma nova tabela. A tabela resultande desse JOIN terá apenas as linhas que só existem na tabela A

- RIGHT ANTI JOIN 
	O RIGHT ANTI JOIN permite relacionar duas tabelas e criar uma nova tabela. A tabela resultande desse JOIN terá apenas as linhas que só existem na tabela B

- FULL ANTI JOIN
	O FULL ANTI JOIN permite relacionar duas tabelas e criar uma nova tabela. A tabela resultande desse JOIN terá apenas as linhas que só existem na tabela A ou na tabela B.
*/
