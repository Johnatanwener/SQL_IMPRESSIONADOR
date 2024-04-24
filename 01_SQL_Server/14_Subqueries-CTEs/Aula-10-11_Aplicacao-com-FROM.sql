-- Módulo 14 - SQL SERVER - Subqueries e CTE's


/* AULA 10 - Subquery na prática (Aplicação com o FROM)
Nos exemplos abaixo, vemos duas formas de descobrir o total de produtos da marca Contoso.

Na opção 1, fizemos uma contagem na tabela dimProduct e por fim um filtro na coluna BrandName.
Na opção 2, utilizamos a ideia de subqueries: a contagem foi feita não na tabela dimProduct, mas sim em uma tabela que foi filtrada antes de ser aplicada no FROM.

Exemplo: Retornar a quantidade total de produtos da marca Contoso. */

SELECT 
	COUNT(*) 
FROM DimProduct
WHERE BrandName = 'Contoso'

SELECT
	COUNT(*)
FROM (SELECT * FROM DimProduct WHERE BrandName = 'Contoso') AS T

------------------------------

/* AULA 11 - Plano de Execução estimado
No exercício acima foi mostrado como resolver o mesmo problema de duas maneiras. Porém, uma vez que a primeira forma já estava sendo utilizada e possivelmente memorizada, por que eu deveria aprender uma segunda forma de fazer a mesma coisa?

Assim, como nas ferramentas de Excel, Power BI, etc. No SQL também teremos mais de uma forma de resolver o mesmo problema e se existe duas ou mais formas de resolver um problema é interessante que eu saíba todas as formas para identificar qual é a maneira mais simples e rápida de resolver o problema em questão.

No SQL Server temos uma opção que nos ajdua a identificar qual das possiveis formas de resolver um problema é a mais otimizada, rápida, simples. E essa opção é o Plano de Execução Estimado, que se encontra na barra de menu 'Editor do SQL' ou através do atalho  CTRL + L.

Embora no exemplo anterior o Custo da consulta (relativo ao lote) tenha sido de '50%', o que nos diz que não importa qual das opções fosse usada, o resultado de processamento seria o mesmo. 
Em outras ocasiões, dependendo do código e da consulta realizada, a diferença de Custo da consulta pode ser grande, por exemplo (20% e 70%), o que nos informaria qual seria a melhor e mais otimizada forma de usar uma consulta nesta ocasião. */