-- c) informações nutricionais da receita
-- Exemplo de consulta para calcular o total nutricional da receita
-- Esta consulta funcionará APENAS se as tabelas informacao_nutricional e ingrediente_nutriente
-- estiverem populadas com dados nutricionais por ingrediente
SELECT
    inf.nome_nutriente AS Nutriente,
    SUM(
        (inf.valor_por_100g / 100) * (lif.quantidade * IF(um.abreviacao = 'kg', 1000, IF(um.abreviacao = 'g', 1, IF(um.abreviacao = 'ml', 1, 0)))) -- Converte a quantidade do ingrediente para gramas para o cálculo
        * (IFNULL(lif.fator_correcao, 1.00)) -- Aplica fator de correção se existir
    ) AS QuantidadeTotalNaReceita,
    inf.unidade_medida AS UnidadeMedidaNutriente
FROM
    lista_ingredientes_ficha_tecnica lif
JOIN
    ingredientes i ON lif.id_ingrediente = i.id_ingrediente
JOIN
    unidades_medida um ON lif.id_unidade = um.id_unidade
JOIN
    ingrediente_nutriente inn ON i.id_ingrediente = inn.id_ingrediente
JOIN
    informacao_nutricional inf ON inn.id_nutriente = inf.id_nutriente
WHERE
    lif.id_ficha_tecnica = @id_ficha -- Use a variável @id_ficha ou o ID específico da ficha
GROUP BY
    inf.nome_nutriente, inf.unidade_medida;

-- Nota: A ficha técnica fornecida apresenta os valores nutricionais TOTAIS e por porção da receita.
-- Se você precisa armazenar esses valores totais diretamente, seria necessário adicionar colunas
-- específicas na tabela ficha_tecnica ou criar uma nova tabela para o resumo nutricional da receita.
-- Com base na sua instrução no ponto 3, o esquema atual foca na nutrição por ingrediente para cálculo.