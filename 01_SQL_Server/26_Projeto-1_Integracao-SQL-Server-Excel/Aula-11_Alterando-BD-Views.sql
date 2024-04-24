-- M�DULO 26 - SQL SERVER - Integra��o SQL SERVER e EXCEL

/* AULA 11 - Alterando o banco e atualizando a Visualiza��o da Tabela

Agora, vamos verificar como podemos alterar nosso c�digo SQL que criamos diretamente no Excel para incluir a coluna Gender da tabela dimCustomer.

No exemplo anterior, voltamos ao SSMS e modificamos a View que hav�amos utilizado para importar o c�digo para o Excel, depois fomos no Excel e atualizamos a planilha.

Dessa vez, como carregamos os dados do SQL Server para o Excel utilizando um SELECT criado diretamente no Excel quando estabelecemos a conex�o, faremos diferente, editaremos esse c�digo no pr�prio Editor do Power Query.

Passo 1: Clique em qualquer campo DENTRO da tabela para que a guia Design da Tabela apare�a;
Passo 2: Na guia Consulta, clique em Editar. O Editor do Power Query ser� aberto em uma nova janela.
Passo 3: J� dentro do Editor Power Query, no lado direito da tela em ETAPAS APLICADAS, clique na engrenagem de Fonte.
Passo 4: Dessa forma, abriremos a mesma janela que utilizamos para criar nossa conex�o com o SQL Server.
Passo 5: Agora, basta alterarmos o c�digo do nosso SELECT incluindo a coluna que 'esquecemos' e depois clicar em OK.
Passo 6: Repare que a coluna Sexo foi inclu�da na visualiza��o do Power Query.
Passo 7: Para efetivar essa altera��o na planilha do Excel, devemos agora fechar o Editor do Power Query clicando em Fechar e Carregar no canto superior esquerdo da tela.
Passo 8: Feito isso, ap�s aguardar um pouco, veremos a coluna Sexo inclu�da em nossa tabela.
Obs.: Se ap�s aguardar um pouco a nova coluna n�o for inserida, basta ir na guia Consulta e clicar na op��o Atualizar. */