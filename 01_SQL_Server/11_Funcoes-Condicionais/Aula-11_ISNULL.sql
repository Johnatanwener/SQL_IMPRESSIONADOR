-- M�dulo 11 - SQL SERVER - FUN��ES CONDICIONAIS


/*AULA 11 - ISNULL - Tratando valores nulos
A fun��o ISNULL nos permite retornar um resultado alternativo para o caso de um valor ser nulo (NULL). Na consulta abaixo, diversas cidades na coluna CityName est�o com o valor NULL. Podemos utilizar a fun��o ISNULL para verificar essa coluna (no 1� argumento) e caso o valor seja nulo, ele retornar� um resultado alternativo. Neste caso, o resultado alternativo que queremos para as cidades com o nome NULL ser� o texto 'Local desconhecido'. */

-- Exemplo: Fa�a uma consulta que substitua todos os valores nulos de CityName da tabela DimGeography pelo texto 'Local desconhecido'.
SELECT * FROM DimGeography

SELECT
	GeographyKey AS 'ID Geogr�fico',
	ContinentName AS 'Continente',
	CityName AS 'Cidade',
	ISNULL(CityName, 'Local desconhecido')
FROM
	DimGeography