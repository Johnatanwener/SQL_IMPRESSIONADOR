-- M�DULO 07 - SQL SERVER - JOINs 

/* AULA 05 - Tabela Fato VS. Tabela Dimens�o
Uma TABELA DIMENS�O � uma tabela que cont�m caracter�sticas de um determinado elemento: lojas, produtos, funcion�rios, clientes, etc. Nesta tabela, nenhum dos elementos principais ir�o se repetir. � onde vamos encontrar nossas chaves prim�rias.

Uma TBELA FATO � uma tabela que vai registrar os fatos ou acontecimentos de uma empresa/neg�cio em determinados per�odos de tempo (vendas, devolu��es, aberturas de chamados, receitas, despesas, etc...). Geralmente � uma tabela com milhares de informa��es e composta essencialmente por colunas de ID usadas para buscar as informa��es complementares de uma tabela dimens�o, conhecidas como chaves estrangeiras.

Obs.: N�o necessariamente uma rela��o acontece entre uma tabela Fato e uma tabela Dimens�o. Uma rela��o pode ocorrer entre 2 ou mais tabelas Dimens�o.

Geralmente em um banco de dados, as tabelas Dimens�o ter�o seu nome come�ando com Dim, exemplo: DimProduct, DimCustomer, DimEmployee, DimDate, DimCalendar, etc.
Por outro lado, as tabelas Fatos ter�o seu nome iniciando com Fact/Fatos, exemplo: FactSales, FactOnlineSales
*/