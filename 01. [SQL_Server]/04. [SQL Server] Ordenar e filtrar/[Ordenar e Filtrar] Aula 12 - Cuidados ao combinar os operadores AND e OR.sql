-- M�DULO 04 - SQL SERVER - ORDENAR E FILTRAR


-- AULA 12 - Cuidados ao utilizar o AND em conjunto com o OR

-- Exemplo: Selecione todas as linhas da tabela dimProduct onde a cor do Produto pode ser igual a Preto OU vermelho, MAS a marca deve ser obrigatoriamente igual a Fabrikam.
SELECT * FROM DimProduct
WHERE (ColorName = 'Black' OR ColorName = 'Red') AND BrandName = 'Fabrikam'

-- Obs: Lembre-se de incluir par�nteses para agrupar os testes l�gicos que voc� deseja fazer ao mesmo tempo, para assim chegar no resultado que voc� espera.