-- M�DULO 26 - SQL SERVER - Integra��o SQL SERVER e EXCEL

/* AULA 12 - Tratamentos B�sicos no Power Query

Chegamos novamente ao momento em que come�aremos a tratar os dados para deixar nossa tabela principal pronta para que possamos criar as tabelas din�micas e os gr�ficos.
E quermos basicamente tratar duas coisas:

1: Alterar na coluna Sexo 'M' por 'Masculino e 'F' por 'Feminino'
2: Extrair a informa��o do m�s da coluna Data Pedido.

Passo 1: Abra o Editor do Power Query.
Passo 2: Realize as altera��es na coluna Sexo, clicando com o bot�o direito do mouse em cima do nome da coluna.
Passo 3: Nas op��es que se abrirem, clique em Substituir valores...
Passo 4: Na janela que se abriu, especifique o valor a ser localizado 'M ou F' e valor que ser� substituido 'Masculino ou Feminino'.
Obs.: Localizar: F - Substituir por: Feminino / Localizar: M - Substituir por: Masculino.
Agora vamos criar uma nova coluna que contenha a informa��o do m�s da coluna Data Pedido.
Passo 5: Selecione a coluna Data Pedido, navegue at� o menu Adicionar Coluna. 
Passo 6: Clique op��o Data do menu Data e Hora > M�s > Nome do M�s. 
Obs.: Uma nova coluna com o nome dos meses ser� adicionado ao final da tabela como �ltima coluna. Arraste essa coluna e posicione ao lado da coluna Data Pedido.
Passo 7: Selecione a nova coluna, clique no menu Transformar. Clique em Formato no menu Coluna de Texto e selecione a op��o MAI�SCULA.
Passo 8: Ainda no menu Coluna de Texto clique em Extrair e selecione extrair os primeiros caracteres e na janela que abrir digite 3 e clique em OK.
Passo 8: Renomeie a coluna Nome do m�s como M�S clicando duas vezes sobre o nome da coluna.

Ap�s feito isso, no menu P�gina Inicial clique em Fechar e Aplicar.

Passo 9: Selecione as colunas Custo Venda e Receita Venda e altere o tipo de dado para Moeda.		*/