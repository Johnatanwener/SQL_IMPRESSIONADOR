-- M�DULO 07 - SQL SERVER - JOINs 

/* Aula 03 - Por que n�o criamos logo uma tabela com todas as informa��es para facilitar?

Quando estamos trabalhando com um banco de dados grande, como por exemplo, o ContosoRetailDW iremos perceber que algumas consultas a determinadas tabelas ir�o demorar muito mais tempo do que outras, isso por que, cada tabela possui uma quantidade espefica e �nica de informa��es por�m, algumas tabelas como as tabelas Fatos possuem uma quantidade enorme de informa��es, e que ao serem consultadas demoram mais tempo para retornar o resultado da consulta.

Agora, imagine se pegassemos as informa��es de todas as tabelas e unificassemos em uma �nica tabela, embora parecesse a primeira vista uma excelente id�ia ter todos os dados em um �nico lugar, na pr�tica dificultaria muito na hora de realizarmos uma consulta, pois algumas informa��es iriam se repetir milhares ou at� milh�es de vezes sobrecarregando a planilha em quest�o e atrapalhando nossas consultas.

Por isso que, ao executarmos uma consulta a tabela FactSales perceberemos 2 tipos de informa��es.
1. Informa��es monet�rias como: UnitCost, UnitPrice, DiscountAmount, TotalCost, SalesAmount, etc...
2. Informa��es gerais de ID, como SalesKey, ChannelKey, StoreKey, ProductKey, etc...

Isso ocorre pois cada linha � um registro de venda por�m, as informa��es detalhadas de cada coluna geral � mantida em outra tabela para n�o sobrecarregar a tabela Fato ainda mais. Informa��es de produtos, lojas, moedas. etc s�o armazenadas em outras tabelas e se por ventura for necess�rio alguma dessas informa��es poderemos acess�-las utilizando a cl�usula JOIN. */ 

SELECT TOP(1000) * FROM FactSales
SELECT * FROM DimProduct