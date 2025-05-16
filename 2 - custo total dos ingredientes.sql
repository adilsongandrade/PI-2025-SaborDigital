-- b) custo total dos ingredientes componentes da receita
SELECT
    SUM(custo_total_item) AS CustoTotalIngredientes
FROM
    lista_ingredientes_ficha_tecnica
WHERE
    id_ficha_tecnica = @id_ficha; -- Use a variável @id_ficha ou o ID específico da ficha