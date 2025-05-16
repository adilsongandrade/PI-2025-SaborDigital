-- d) equipamentos necessários
SELECT
    e.descricao AS Equipamento,
    lef.quantidade AS Quantidade
FROM
    lista_equipamentos_ficha_tecnica lef
JOIN
    equipamentos e ON lef.id_equipamento = e.id_equipamento
WHERE
    lef.id_ficha_tecnica = @id_ficha; -- Use a variável @id_ficha ou o ID específico da ficha

