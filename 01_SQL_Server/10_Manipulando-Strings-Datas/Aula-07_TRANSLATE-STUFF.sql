-- MÓDULO 10 - SQL SERVER - Manipulando Strings e Datas


/* AULA 07 - TRANSLATE e STUFF
Existem outras duas funções usadas para substituir textos: TRANSLATE e STUFF.

A função TRANSLATE permite que a gente informe uma sequência de caractereres antigos que desejamos substituir, além da sequência de caracteres novos que serão usados para substituir os caracteres antigos, seguindo exatamente a mesma sequência.

A função TRANSLATE pede 3 argumentos:
1. Texto
2. Sequência antiga de caracteres
3. Sequência nova de caracteres
*/

-- TRANSLATE substitui cada caractere na ordem encontrada no texto.
SELECT TRANSLATE('10.241/444.124k23/1', './k', '---')
-- Nessa aplicação de TRANSLATE, todos os caracteres (ponto, barra e a letra k) são substituidos por um (traço -).

SELECT TRANSLATE('10.241/444.124k23/1', './k', 'abc')
-- Nessa aplicação de TRANSLATE, todos os caracteres (ponto, barra e a letra k) são substituidos por (abc), sendo que, a substituição ocorre 1 por 1, ou seja, todos os (.) são substituidos por (a), todas as (/) são substituidas por (b) etc.

SELECT TRANSLATE('3*[2+1]/{8-4}', '[]{}', '()()')
-- Nessa aplicação de TRANSLATE, todos os colchetes e chaves são substitudos por parenteses.

SELECT TRANSLATE('ABCD-490123', 'ABCD', 'WXYZ')
-- Nessa aplicação de TRANSLATE, os 4 primeiros caracteres são substituidos de 'ABCD' para WXYZ'.


/* A função STUFF permite que a gente substitua uma sequência de caracteres com um tamanho específico, por um outro texto.
Essa função pede 4 argumentos.
1. Texto
2. Posição inicial onde começa o texto antigo
3. Quantidade de caracteres do texto antigo
4. Novo texto.

Nos exemplos abaixo, temos duas situações: VBA Impressionador e SQL Impressionador. Ambos possuem 3 caracteres iniciais (referete ao nome do curso) e podemos utilizar esse padrão, junto com a função STUFF, para substituir sempre os 3 primeiros caracteres (independente do que esteja escrito nesses 3 primeiros caracteres) pelo texto 'Excel'.
*/

SELECT STUFF('VBA Impressionador', 1, 3, 'Excel')
SELECT STUFF('SQL Impressionador', 1, 3, 'Excel')

SELECT
	STUFF('MT98-Moto G', 1, 2, 'CEL'),
	STUFF('AP01-IPhone', 1, 2, 'CEL'),
	STUFF('SS61-Samsung Galaxy', 1, 2, 'CEL')
