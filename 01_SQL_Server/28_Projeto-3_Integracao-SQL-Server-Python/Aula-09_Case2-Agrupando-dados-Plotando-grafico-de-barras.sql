-- M�DULO 28 - SQL SERVER - INTEGRA��O SQL SERVER - PYTHON

/* AULA 09 - Case 2 (Leitura) - Agrupamentos b�sicos no Python utilizando Group By e Plotando um gr�fico de barras
Iremos finalizar agora nosso projeto realizando a 3� etapa do nosso projeto, em que agruparemos a tabela que importamos do SQL Server para fazermos uma contagem de quantos produtos temos de cada cor.

Em seguida, iremos plotar um gr�fico de barras na tela do Jupyter.

Para agruparmos a tabela por cor, junto com � vari�vel dados (que armazena a tabela importada do SQL Server), utilizadmos o m�todo groupby(), passando para ele como par�metro o nome da coluna pela qual queremos agrupar (ColorName). Em seguida, faremos uma contagem de linhas desse agrupamento para cada cor, utilizando a fun��o Count(); Nosso script ficar� assim: 

# Criando um agrupamento do total de produtos por cores: */
dados.groupby('ColorName').count()

-- Agora, vamos criar um gr�fico a partir desse comando por�m, repare que o resultado que obtivemos n�o ficou armazenado em nenhum lugar, e dessa forma n�o temos como transform�-lo em um gr�fico. Por isso, primeiro precisaremos armazenar a nossa tabela agrupada em uma vari�vel e posteriormente plotar o nosso gr�fico. Portanto, iremos criar uma vari�vel chamada total_produtos_por_cor, e informar para ela o comando que cria o agrupamento. Nosso script ficar� assim:

--# Armazenando o agrupamento em uma vari�vel:
total_produtos_por_cor = dados.groupby('ColorName').count()

-- Em seguida, vamos utilizar o comando display e a vari�vel total_produtos_por_cor como seu par�metro, para podermos ver que a tabela agrupada foi de fato armazenada na vari�vel referida.

-- # Visualizando o agrupamento armazenado na vari�vel:
display(total_produtos_por_cor)

-- Agora sim, podemos plotar um gr�fico de barras utilizando os dados do agrupamento efetuado. Para isso, junto a vari�vel total_produtos_por_cor (que armazena a tabela agrupada), utilizaremos a fun~��o plot(), passando para ela o argumento kind='bar', que informa que queremos que seja mostrado na tela um gr�fico do tipo (kind) barras (bar):

-- # Plotando um gr�fico do agrupamento:
total_produtos_por_cor.plot(kind='bar')

-- Agora sim, com o gr�fico plotado conseguimos visualizar melhor o resultado do nosso agrupamento. E logo no primeiro momento j� podemos identificar que a cor com maior quantidade de produtos � a Black (preta), seguida da White (Branca), Silver (prata), Grey (cinza), etc...

-- Pronto! Nosso mini projeto est� conclu�do. Podemos salvar nosso arquivo.