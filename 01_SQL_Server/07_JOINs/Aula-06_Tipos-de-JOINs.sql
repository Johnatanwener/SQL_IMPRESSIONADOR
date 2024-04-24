-- M�DULO 07 - SQL SERVER - JOINs 


/* AULA 06 - Tipos de JOIN - Explica��o
Vimos que existem dois tipos de tabelas: Dimens�o e Fato. Essas tabelas podem ser relacionadas atrav�s de uma coluna na tabela Dimens�o, que identificamos como Chave Prim�ria, e que ser� relacionada com a chave Estrangeira da tabela Fato.

Essas rela��es ser�o criadas por meio das cl�usulas JOINs. OS JOINs v�o nos permitir juntar/unir as nossas tabelas Fato e Dimens�o de forma a complementar as informa��es umas das outras.

Existem diversos tipos de JOINs no SQL: 
- LEFT (OUTER) JOIN
	O LEFT JOIN permite relacionar duas tabelas e criar uma nova tabela. A tabela resultante desse JOIN ter� todas as linhas exclusivas da tabela A, mais as linhas que s�o a interse��o entre a tabela A e a tabela B. Nenhuma linha presente apenas na tabela B ser� inclu�da na tabela resultante desse JOIN.

- RIGHT (OUTER) JOIN 
	O RIGHT JOIN permite relacionar duas tabelas e criar uma nova tabela. A tabela resultante desse JOIN ter� todas as linhas exclusivas da tabela B, mais as linhas que s�o a interse��o entre a tabela A e a tabela B. Nenhuma linha presente apenas na tabela A ser� inclu�da na tabela resultante desse JOIN.

- INNER JOIN 
	O INNER JOIN permite relacionar duas tabelas e criar uma nova tabela. A tabela resultante desse JOIN ter� apenas as linhas que s�o a interse��o entre a tabela A e a tabela B.

- FULL (OUTER) JOIN 
	O FULL JOIN permite relacionar duas tabelas e criar uma nova tabela. A tabela resultante desse JOIN ter� todas as linhas da tabela A e todas as linhas da tabela B.

- LEFT ANTI JOIN 
	O LEFT ANTI JOIN permite relacionar duas tabelas e criar uma nova tabela. A tabela resultande desse JOIN ter� apenas as linhas que s� existem na tabela A

- RIGHT ANTI JOIN 
	O RIGHT ANTI JOIN permite relacionar duas tabelas e criar uma nova tabela. A tabela resultande desse JOIN ter� apenas as linhas que s� existem na tabela B

- FULL ANTI JOIN
	O FULL ANTI JOIN permite relacionar duas tabelas e criar uma nova tabela. A tabela resultande desse JOIN ter� apenas as linhas que s� existem na tabela A ou na tabela B.
*/
