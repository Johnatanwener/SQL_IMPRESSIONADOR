-- M�DULO 07 - SQL SERVER - JOINs 

/* AULA 17 - UNION e UNION ALL
Existem outros dois comandos que usamos para jun��o de tabelas: UNION e UNION ALL. Estes dois permitem a jun��o de duas ou mais tabelas, como se estiv�ssemos empilhando as tabelas uma sobre a outra, ou seja, coloando uma tabela em cima da outra.*/

-- Se voc� tiver duas colunas com exatamente as mesmas informa��es e que voc� gostaria de unificar em uma �nica tabela, poder� utilizar o UNION, exemplo se a tabela DimCustomer estivesse separada em duas tabelas (Masculino e Feminino)
-- UNION
SELECT * FROM DimCustomer WHERE Gender = 'F'
UNION -- Entre as consultas inclu�ra o UNION
SELECT * FROM DimCustomer WHERE Gender = 'M'

-- UNION ALL
-- Se fosse utilizar o UNION teriamos linhas exclu�das pois o UNION exclu� informa��es duplicadas e nesse caso teriamos pessoas do sexo M e F com o mesmo primeiro nome e mesmo dia de anivers�rio
SELECT FirstName, BirthDate FROM DimCustomer WHERE Gender = 'F'
UNION ALL -- Entre as consultas inclu�ra o UNION ALL
SELECT FirstName, BirthDate FROM DimCustomer WHERE Gender = 'M'

-- UNION juntar� as tabelas mas remover� as linhas duplicadas.
-- UNION ALL juntar� as tabelas por�m, manter� todas as informa��es de ambas as tabelas.