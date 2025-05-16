-- identificação da receita da Ficha Técnica:
SELECT 
	lif.`id_ficha_tecnica`,
    lif.`nome_receita`,
    lif.`descricao_receita`,
    cat.nome_categoria, 
    lif.`numero_porcoes`,
    lif.`peso_da_porcao`
FROM `ficha_tecnica` lif
JOIN
    categoria_receita cat ON lif.id_categoria = cat.id_categoria
WHERE
    lif.id_ficha_tecnica = @id_ficha; -- Use a variável @id_ficha ou o ID específico da ficha