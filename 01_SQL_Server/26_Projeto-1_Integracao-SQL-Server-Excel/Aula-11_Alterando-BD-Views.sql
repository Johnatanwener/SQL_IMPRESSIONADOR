-- MÓDULO 26 - SQL SERVER - Integração SQL SERVER e EXCEL

/* AULA 11 - Alterando o banco e atualizando a Visualização da Tabela

Agora, vamos verificar como podemos alterar nosso código SQL que criamos diretamente no Excel para incluir a coluna Gender da tabela dimCustomer.

No exemplo anterior, voltamos ao SSMS e modificamos a View que havíamos utilizado para importar o código para o Excel, depois fomos no Excel e atualizamos a planilha.

Dessa vez, como carregamos os dados do SQL Server para o Excel utilizando um SELECT criado diretamente no Excel quando estabelecemos a conexão, faremos diferente, editaremos esse código no próprio Editor do Power Query.

Passo 1: Clique em qualquer campo DENTRO da tabela para que a guia Design da Tabela apareça;
Passo 2: Na guia Consulta, clique em Editar. O Editor do Power Query será aberto em uma nova janela.
Passo 3: Já dentro do Editor Power Query, no lado direito da tela em ETAPAS APLICADAS, clique na engrenagem de Fonte.
Passo 4: Dessa forma, abriremos a mesma janela que utilizamos para criar nossa conexão com o SQL Server.
Passo 5: Agora, basta alterarmos o código do nosso SELECT incluindo a coluna que 'esquecemos' e depois clicar em OK.
Passo 6: Repare que a coluna Sexo foi incluída na visualização do Power Query.
Passo 7: Para efetivar essa alteração na planilha do Excel, devemos agora fechar o Editor do Power Query clicando em Fechar e Carregar no canto superior esquerdo da tela.
Passo 8: Feito isso, após aguardar um pouco, veremos a coluna Sexo incluída em nossa tabela.
Obs.: Se após aguardar um pouco a nova coluna não for inserida, basta ir na guia Consulta e clicar na opção Atualizar. */