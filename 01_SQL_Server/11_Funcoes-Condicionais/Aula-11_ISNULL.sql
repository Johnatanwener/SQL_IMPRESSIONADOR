-- Módulo 11 - SQL SERVER - FUNÇÕES CONDICIONAIS


/*AULA 11 - ISNULL - Tratando valores nulos
A função ISNULL nos permite retornar um resultado alternativo para o caso de um valor ser nulo (NULL). Na consulta abaixo, diversas cidades na coluna CityName estão com o valor NULL. Podemos utilizar a função ISNULL para verificar essa coluna (no 1º argumento) e caso o valor seja nulo, ele retornará um resultado alternativo. Neste caso, o resultado alternativo que queremos para as cidades com o nome NULL será o texto 'Local desconhecido'. */

-- Exemplo: Faça uma consulta que substitua todos os valores nulos de CityName da tabela DimGeography pelo texto 'Local desconhecido'.
SELECT * FROM DimGeography

SELECT
	GeographyKey AS 'ID Geográfico',
	ContinentName AS 'Continente',
	CityName AS 'Cidade',
	ISNULL(CityName, 'Local desconhecido')
FROM
	DimGeography