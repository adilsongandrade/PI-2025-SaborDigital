-- a) ingredientes componentes da receita:
SELECT
    i.descricao_ingrediente AS Ingrediente,
    lif.quantidade AS Quantidade,
    um.abreviacao AS Unidade,
    lif.custo_unitario AS CustoUnitario,
    lif.custo_total_item AS CustoTotalItem
FROM
    lista_ingredientes_ficha_tecnica lif
JOIN
    ingredientes i ON lif.id_ingrediente = i.id_ingrediente
JOIN
    unidades_medida um ON lif.id_unidade = um.id_unidade
WHERE
    lif.id_ficha_tecnica = @id_ficha; -- Use a variável @id_ficha ou o ID específico da ficha