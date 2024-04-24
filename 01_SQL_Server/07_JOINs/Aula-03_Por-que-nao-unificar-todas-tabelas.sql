-- MÓDULO 07 - SQL SERVER - JOINs 

/* Aula 03 - Por que não criamos logo uma tabela com todas as informações para facilitar?

Quando estamos trabalhando com um banco de dados grande, como por exemplo, o ContosoRetailDW iremos perceber que algumas consultas a determinadas tabelas irão demorar muito mais tempo do que outras, isso por que, cada tabela possui uma quantidade espefica e única de informações porém, algumas tabelas como as tabelas Fatos possuem uma quantidade enorme de informações, e que ao serem consultadas demoram mais tempo para retornar o resultado da consulta.

Agora, imagine se pegassemos as informações de todas as tabelas e unificassemos em uma única tabela, embora parecesse a primeira vista uma excelente idéia ter todos os dados em um único lugar, na prática dificultaria muito na hora de realizarmos uma consulta, pois algumas informações iriam se repetir milhares ou até milhões de vezes sobrecarregando a planilha em questão e atrapalhando nossas consultas.

Por isso que, ao executarmos uma consulta a tabela FactSales perceberemos 2 tipos de informações.
1. Informações monetárias como: UnitCost, UnitPrice, DiscountAmount, TotalCost, SalesAmount, etc...
2. Informações gerais de ID, como SalesKey, ChannelKey, StoreKey, ProductKey, etc...

Isso ocorre pois cada linha é um registro de venda porém, as informações detalhadas de cada coluna geral é mantida em outra tabela para não sobrecarregar a tabela Fato ainda mais. Informações de produtos, lojas, moedas. etc são armazenadas em outras tabelas e se por ventura for necessário alguma dessas informações poderemos acessá-las utilizando a cláusula JOIN. */ 

SELECT TOP(1000) * FROM FactSales
SELECT * FROM DimProduct