-- M�dulo 14 - SQL SERVER - Subqueries e CTE's


/* AULA 10 - Subquery na pr�tica (Aplica��o com o FROM)
Nos exemplos abaixo, vemos duas formas de descobrir o total de produtos da marca Contoso.

Na op��o 1, fizemos uma contagem na tabela dimProduct e por fim um filtro na coluna BrandName.
Na op��o 2, utilizamos a ideia de subqueries: a contagem foi feita n�o na tabela dimProduct, mas sim em uma tabela que foi filtrada antes de ser aplicada no FROM.

Exemplo: Retornar a quantidade total de produtos da marca Contoso. */

SELECT 
	COUNT(*) 
FROM DimProduct
WHERE BrandName = 'Contoso'

SELECT
	COUNT(*)
FROM (SELECT * FROM DimProduct WHERE BrandName = 'Contoso') AS T

------------------------------

/* AULA 11 - Plano de Execu��o estimado
No exerc�cio acima foi mostrado como resolver o mesmo problema de duas maneiras. Por�m, uma vez que a primeira forma j� estava sendo utilizada e possivelmente memorizada, por que eu deveria aprender uma segunda forma de fazer a mesma coisa?

Assim, como nas ferramentas de Excel, Power BI, etc. No SQL tamb�m teremos mais de uma forma de resolver o mesmo problema e se existe duas ou mais formas de resolver um problema � interessante que eu sa�ba todas as formas para identificar qual � a maneira mais simples e r�pida de resolver o problema em quest�o.

No SQL Server temos uma op��o que nos ajdua a identificar qual das possiveis formas de resolver um problema � a mais otimizada, r�pida, simples. E essa op��o � o Plano de Execu��o Estimado, que se encontra na barra de menu 'Editor do SQL' ou atrav�s do atalho  CTRL + L.

Embora no exemplo anterior o Custo da consulta (relativo ao lote) tenha sido de '50%', o que nos diz que n�o importa qual das op��es fosse usada, o resultado de processamento seria o mesmo. 
Em outras ocasi�es, dependendo do c�digo e da consulta realizada, a diferen�a de Custo da consulta pode ser grande, por exemplo (20% e 70%), o que nos informaria qual seria a melhor e mais otimizada forma de usar uma consulta nesta ocasi�o. */