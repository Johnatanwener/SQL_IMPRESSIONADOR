-- M�DULO 13 - SQL SERVER - CRUD

/* AULA 02 - O que � CRUD?
Opera��es CRUD s�o opera��es que conseguimos fazer em um Banco de Dados. Essa sigla significa:

C > CREATE	- Permite criar Banco de Dados, Tabelas ou Exibi��es (Views)
R > READ	- Permite ler os dados do banco de dados. Basicamente foi o que mais fizemos no Curso, atrav�s do SELECT
U > UPDATE	- Permite atualizar os dados do banco de dados, tabelas ou views. 
D > UELETE	- Permite deletar dados de um banco de dados, tabelas ou views.

Com os comandos acima, conseguimos Criar, Ler, Atualizar e Deletar dados do nosso Banco de Dados. 

Lembrando:
- Um banco de dados � composto por um conjunto de tabelas (exemplo Contoso)
- As tabelas armazenam dados em linhas e colunas.
- Uma linha abrange v�rias colunas que juntas descrevem alguma caracter�stica de um objeto. Desta forma, uma coluna � como se fosse uma categoria.
- Portando, cada objeto (registro/record) possui caracter�sticas que pertencem a essas categorias. 

- Um Banco de Dados ser� usado para guardar todas as tabelas criadas. E � importante entender que as tabelas de um banco de dados precisam ter algum tipo de rela��o.

- Para criar um Banco de Dados existem 2 formas.
1. Manualmente, atrav�s do menu "Pesquisador de Objetos" clicando com o bot�o direito do mouse em cima de Banco de Dados e em seguida Novo Banco de Dados...
2. Usando o SQL, atrav�s do comando CREATE DATABASE, seguido do nome que quer dar ao banco de dados.

- Para deletar um Banco de Dados existem 2 formas.
1. Manualmente, atrav�s do menu "Pesquisador de Objetos" clicando com o bot�o direito do mouse em cima do nome do Banco de Dados e em seguida Excluir.
2. Usando o SQL, atrav�s do comando DROP DATABASE, seguido do nome do banco de dados que quer excluir.

Obs: Sempre que fizer uma altera��o no Banco de Dados ou sempre que criar ou excluir um Banco de Dados, n�o esque�a de clicar em atualizar no menu "Pesquisador de Objetos" */