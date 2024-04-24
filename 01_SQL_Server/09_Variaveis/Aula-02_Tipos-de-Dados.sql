-- MÓDULO 09 - SQL SERVER - VARIÁVEIS


/* AULA 02 - TIPO DE DADOS
O tipo de dado é a maneira como o SQL consegue diferenciar cada valor dentro de um banco de dados. Todo dado possui um tipo específico: ele pode ser um número, um texto ou uma data. Em resumo, temos abaixo os 4 principais tipos de dados:

a) Inteiro
Qualquer número que seja representado apenas pela sua parte inteira, sem casa decimais.
Exemplos: 1, 100, 569
O SQL entenderá que estamos trabalhando com um número inteiro através do identificador: INT

b) Decimal
Qualquer número que contenha casas decimais.
Exemplos: 10.33, 90.91, 410.787
O SQL entenderá que estamos trabalhando com um número decimal através do identificador: FLOAT
O SQL entenderá que estamos trabalhando com um número decimal através do identificador: DECIMAL(N, M)
	N é a quantidade de dígitos que o númeto pode ter, incluindo casas decimais
	M é o número máximo de casas decimais

c) Texto/String
Toda cadeira de caracteres que pode ser interpretada commo um texto.
Exemplos: 'Carla', 'Motorola', 'Pastel', '44'
O SQL entenderá que estamos trabalhando com um texto através do identificador: VARCHAR(N)

d) Data
Qualquer dado no formato de data.
Exemplos: '01/01/2021', '23/03/2021'
O SQL entenderá que estamos trabalhando com uma data através do identificador: DATE
O SQL entenderá que estamos trabalhando com uma data/hora através do identificador: DATETIME
 */


