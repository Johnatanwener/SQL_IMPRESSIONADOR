-- M�DULO 10 - SQL SERVER - Manipulando Strings e Datas


/* AULA 07 - TRANSLATE e STUFF
Existem outras duas fun��es usadas para substituir textos: TRANSLATE e STUFF.

A fun��o TRANSLATE permite que a gente informe uma sequ�ncia de caractereres antigos que desejamos substituir, al�m da sequ�ncia de caracteres novos que ser�o usados para substituir os caracteres antigos, seguindo exatamente a mesma sequ�ncia.

A fun��o TRANSLATE pede 3 argumentos:
1. Texto
2. Sequ�ncia antiga de caracteres
3. Sequ�ncia nova de caracteres
*/

-- TRANSLATE substitui cada caractere na ordem encontrada no texto.
SELECT TRANSLATE('10.241/444.124k23/1', './k', '---')
-- Nessa aplica��o de TRANSLATE, todos os caracteres (ponto, barra e a letra k) s�o substituidos por um (tra�o -).

SELECT TRANSLATE('10.241/444.124k23/1', './k', 'abc')
-- Nessa aplica��o de TRANSLATE, todos os caracteres (ponto, barra e a letra k) s�o substituidos por (abc), sendo que, a substitui��o ocorre 1 por 1, ou seja, todos os (.) s�o substituidos por (a), todas as (/) s�o substituidas por (b) etc.

SELECT TRANSLATE('3*[2+1]/{8-4}', '[]{}', '()()')
-- Nessa aplica��o de TRANSLATE, todos os colchetes e chaves s�o substitudos por parenteses.

SELECT TRANSLATE('ABCD-490123', 'ABCD', 'WXYZ')
-- Nessa aplica��o de TRANSLATE, os 4 primeiros caracteres s�o substituidos de 'ABCD' para WXYZ'.


/* A fun��o STUFF permite que a gente substitua uma sequ�ncia de caracteres com um tamanho espec�fico, por um outro texto.
Essa fun��o pede 4 argumentos.
1. Texto
2. Posi��o inicial onde come�a o texto antigo
3. Quantidade de caracteres do texto antigo
4. Novo texto.

Nos exemplos abaixo, temos duas situa��es: VBA Impressionador e SQL Impressionador. Ambos possuem 3 caracteres iniciais (referete ao nome do curso) e podemos utilizar esse padr�o, junto com a fun��o STUFF, para substituir sempre os 3 primeiros caracteres (independente do que esteja escrito nesses 3 primeiros caracteres) pelo texto 'Excel'.
*/

SELECT STUFF('VBA Impressionador', 1, 3, 'Excel')
SELECT STUFF('SQL Impressionador', 1, 3, 'Excel')

SELECT
	STUFF('MT98-Moto G', 1, 2, 'CEL'),
	STUFF('AP01-IPhone', 1, 2, 'CEL'),
	STUFF('SS61-Samsung Galaxy', 1, 2, 'CEL')
