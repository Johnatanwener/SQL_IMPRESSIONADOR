-- MÓDULO 26 - SQL SERVER - Integração SQL SERVER e EXCEL

/* AULA 12 - Tratamentos Básicos no Power Query

Chegamos novamente ao momento em que começaremos a tratar os dados para deixar nossa tabela principal pronta para que possamos criar as tabelas dinâmicas e os gráficos.
E quermos basicamente tratar duas coisas:

1: Alterar na coluna Sexo 'M' por 'Masculino e 'F' por 'Feminino'
2: Extrair a informação do mês da coluna Data Pedido.

Passo 1: Abra o Editor do Power Query.
Passo 2: Realize as alterações na coluna Sexo, clicando com o botão direito do mouse em cima do nome da coluna.
Passo 3: Nas opções que se abrirem, clique em Substituir valores...
Passo 4: Na janela que se abriu, especifique o valor a ser localizado 'M ou F' e valor que será substituido 'Masculino ou Feminino'.
Obs.: Localizar: F - Substituir por: Feminino / Localizar: M - Substituir por: Masculino.
Agora vamos criar uma nova coluna que contenha a informação do mês da coluna Data Pedido.
Passo 5: Selecione a coluna Data Pedido, navegue até o menu Adicionar Coluna. 
Passo 6: Clique opção Data do menu Data e Hora > Mês > Nome do Mês. 
Obs.: Uma nova coluna com o nome dos meses será adicionado ao final da tabela como última coluna. Arraste essa coluna e posicione ao lado da coluna Data Pedido.
Passo 7: Selecione a nova coluna, clique no menu Transformar. Clique em Formato no menu Coluna de Texto e selecione a opção MAIÚSCULA.
Passo 8: Ainda no menu Coluna de Texto clique em Extrair e selecione extrair os primeiros caracteres e na janela que abrir digite 3 e clique em OK.
Passo 8: Renomeie a coluna Nome do mês como MÊS clicando duas vezes sobre o nome da coluna.

Após feito isso, no menu Página Inicial clique em Fechar e Aplicar.

Passo 9: Selecione as colunas Custo Venda e Receita Venda e altere o tipo de dado para Moeda.		*/