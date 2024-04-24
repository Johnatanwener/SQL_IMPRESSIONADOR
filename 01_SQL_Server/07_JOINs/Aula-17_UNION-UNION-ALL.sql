-- MÓDULO 07 - SQL SERVER - JOINs 

/* AULA 17 - UNION e UNION ALL
Existem outros dois comandos que usamos para junção de tabelas: UNION e UNION ALL. Estes dois permitem a junção de duas ou mais tabelas, como se estivéssemos empilhando as tabelas uma sobre a outra, ou seja, coloando uma tabela em cima da outra.*/

-- Se você tiver duas colunas com exatamente as mesmas informações e que você gostaria de unificar em uma única tabela, poderá utilizar o UNION, exemplo se a tabela DimCustomer estivesse separada em duas tabelas (Masculino e Feminino)
-- UNION
SELECT * FROM DimCustomer WHERE Gender = 'F'
UNION -- Entre as consultas incluíra o UNION
SELECT * FROM DimCustomer WHERE Gender = 'M'

-- UNION ALL
-- Se fosse utilizar o UNION teriamos linhas excluídas pois o UNION excluí informações duplicadas e nesse caso teriamos pessoas do sexo M e F com o mesmo primeiro nome e mesmo dia de aniversário
SELECT FirstName, BirthDate FROM DimCustomer WHERE Gender = 'F'
UNION ALL -- Entre as consultas incluíra o UNION ALL
SELECT FirstName, BirthDate FROM DimCustomer WHERE Gender = 'M'

-- UNION juntará as tabelas mas removerá as linhas duplicadas.
-- UNION ALL juntará as tabelas porém, manterá todas as informações de ambas as tabelas.