-- M�DULO 09 - SQL SERVER - VARI�VEIS


/* AULA 02 - TIPO DE DADOS
O tipo de dado � a maneira como o SQL consegue diferenciar cada valor dentro de um banco de dados. Todo dado possui um tipo espec�fico: ele pode ser um n�mero, um texto ou uma data. Em resumo, temos abaixo os 4 principais tipos de dados:

a) Inteiro
Qualquer n�mero que seja representado apenas pela sua parte inteira, sem casa decimais.
Exemplos: 1, 100, 569
O SQL entender� que estamos trabalhando com um n�mero inteiro atrav�s do identificador: INT

b) Decimal
Qualquer n�mero que contenha casas decimais.
Exemplos: 10.33, 90.91, 410.787
O SQL entender� que estamos trabalhando com um n�mero decimal atrav�s do identificador: FLOAT
O SQL entender� que estamos trabalhando com um n�mero decimal atrav�s do identificador: DECIMAL(N, M)
	N � a quantidade de d�gitos que o n�meto pode ter, incluindo casas decimais
	M � o n�mero m�ximo de casas decimais

c) Texto/String
Toda cadeira de caracteres que pode ser interpretada commo um texto.
Exemplos: 'Carla', 'Motorola', 'Pastel', '44'
O SQL entender� que estamos trabalhando com um texto atrav�s do identificador: VARCHAR(N)

d) Data
Qualquer dado no formato de data.
Exemplos: '01/01/2021', '23/03/2021'
O SQL entender� que estamos trabalhando com uma data atrav�s do identificador: DATE
O SQL entender� que estamos trabalhando com uma data/hora atrav�s do identificador: DATETIME
 */


