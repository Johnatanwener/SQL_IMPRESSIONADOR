-- MÓDULO 07 - SQL SERVER - JOINs 

/* AULA 05 - Tabela Fato VS. Tabela Dimensão
Uma TABELA DIMENSÃO é uma tabela que contém características de um determinado elemento: lojas, produtos, funcionários, clientes, etc. Nesta tabela, nenhum dos elementos principais irão se repetir. É onde vamos encontrar nossas chaves primárias.

Uma TBELA FATO é uma tabela que vai registrar os fatos ou acontecimentos de uma empresa/negócio em determinados períodos de tempo (vendas, devoluções, aberturas de chamados, receitas, despesas, etc...). Geralmente é uma tabela com milhares de informações e composta essencialmente por colunas de ID usadas para buscar as informações complementares de uma tabela dimensão, conhecidas como chaves estrangeiras.

Obs.: Não necessariamente uma relação acontece entre uma tabela Fato e uma tabela Dimensão. Uma relação pode ocorrer entre 2 ou mais tabelas Dimensão.

Geralmente em um banco de dados, as tabelas Dimensão terão seu nome começando com Dim, exemplo: DimProduct, DimCustomer, DimEmployee, DimDate, DimCalendar, etc.
Por outro lado, as tabelas Fatos terão seu nome iniciando com Fact/Fatos, exemplo: FactSales, FactOnlineSales
*/