-- MÓDULO 04 - SQL SERVER - ORDENAR E FILTRAR


/* AULA 16 - WHERE mais IS NULL e IS NOT NULL - Filtrando valores nulos
Podemos encontrar valores nulos (em branco) em uma tabela. Para filtrar esses valores, podemos usar os comandos IS NULL ou IS NOT NULL. */

-- 1. Selecione os clientes que são pessoa física.
SELECT * FROM DimCustomer
WHERE CompanyName IS NULL

-- 2. Selecione os clientes que são pessoa jurídica.
SELECT * FROM DimCustomer
WHERE CompanyName IS NOT NULL