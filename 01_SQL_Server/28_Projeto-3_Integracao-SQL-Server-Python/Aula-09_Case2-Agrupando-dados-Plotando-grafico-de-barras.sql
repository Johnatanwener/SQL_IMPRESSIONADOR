-- MÓDULO 28 - SQL SERVER - INTEGRAÇÃO SQL SERVER - PYTHON

/* AULA 09 - Case 2 (Leitura) - Agrupamentos básicos no Python utilizando Group By e Plotando um gráfico de barras
Iremos finalizar agora nosso projeto realizando a 3ª etapa do nosso projeto, em que agruparemos a tabela que importamos do SQL Server para fazermos uma contagem de quantos produtos temos de cada cor.

Em seguida, iremos plotar um gráfico de barras na tela do Jupyter.

Para agruparmos a tabela por cor, junto com à variável dados (que armazena a tabela importada do SQL Server), utilizadmos o método groupby(), passando para ele como parâmetro o nome da coluna pela qual queremos agrupar (ColorName). Em seguida, faremos uma contagem de linhas desse agrupamento para cada cor, utilizando a função Count(); Nosso script ficará assim: 

# Criando um agrupamento do total de produtos por cores: */
dados.groupby('ColorName').count()

-- Agora, vamos criar um gráfico a partir desse comando porém, repare que o resultado que obtivemos não ficou armazenado em nenhum lugar, e dessa forma não temos como transformá-lo em um gráfico. Por isso, primeiro precisaremos armazenar a nossa tabela agrupada em uma variável e posteriormente plotar o nosso gráfico. Portanto, iremos criar uma variável chamada total_produtos_por_cor, e informar para ela o comando que cria o agrupamento. Nosso script ficará assim:

--# Armazenando o agrupamento em uma variável:
total_produtos_por_cor = dados.groupby('ColorName').count()

-- Em seguida, vamos utilizar o comando display e a variável total_produtos_por_cor como seu parâmetro, para podermos ver que a tabela agrupada foi de fato armazenada na variável referida.

-- # Visualizando o agrupamento armazenado na variável:
display(total_produtos_por_cor)

-- Agora sim, podemos plotar um gráfico de barras utilizando os dados do agrupamento efetuado. Para isso, junto a variável total_produtos_por_cor (que armazena a tabela agrupada), utilizaremos a fun~ção plot(), passando para ela o argumento kind='bar', que informa que queremos que seja mostrado na tela um gráfico do tipo (kind) barras (bar):

-- # Plotando um gráfico do agrupamento:
total_produtos_por_cor.plot(kind='bar')

-- Agora sim, com o gráfico plotado conseguimos visualizar melhor o resultado do nosso agrupamento. E logo no primeiro momento já podemos identificar que a cor com maior quantidade de produtos é a Black (preta), seguida da White (Branca), Silver (prata), Grey (cinza), etc...

-- Pronto! Nosso mini projeto está concluído. Podemos salvar nosso arquivo.