```
CREDENCIAIS ACESSO AO BANCO DE DADOS:

MySQL Hostname: sql106.infinityfree.com
MySQL Database Name: if0_39000213_sabor_digital
MySQL Username: if0_39000213
MySQL Password: univesPI2025
MySQL Port (optional): 3306
```

![FichaTécnicaSaborDigital](https://github.com/user-attachments/assets/e3e956e6-5fb7-4640-84dc-45f3076ef876)

0) Retorna identificação da receita da Ficha Técnica:
![image](https://github.com/user-attachments/assets/264508f5-cde0-44a1-b91a-df18139c00f8)

```sql
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
```

1) Consulta ingredientes componentes da receita:

![image](https://github.com/user-attachments/assets/fc57e95d-09ae-4f53-a1b2-f8d78c9d17c3)

```sql
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
```


2) Retorna o custo total dos ingredientes componentes da receita (*** Falta Atualizar a Fórmula para simular o PREÇO DE VENDA ***)

![image](https://github.com/user-attachments/assets/a5856100-3077-4041-bd90-c0fb662ad50f)

```sql
SELECT
    SUM(custo_total_item) AS CustoTotalIngredientes
FROM
    lista_ingredientes_ficha_tecnica
WHERE
    id_ficha_tecnica = @id_ficha; -- Use a variável @id_ficha ou o ID específico da ficha
```


3) Retorna informações nutricionais da receita (** AINDA APRESENTA INCONSISTÊNCIAS **)

```sql
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
```


4) Retorna os equipamentos necessários
```sql
SELECT
    e.descricao AS Equipamento,
    lef.quantidade AS Quantidade
FROM
    lista_equipamentos_ficha_tecnica lef
JOIN
    equipamentos e ON lef.id_equipamento = e.id_equipamento
WHERE
    lef.id_ficha_tecnica = @id_ficha; -- Use a variável @id_ficha ou o ID específico da ficha
```

5) Retorna modo de preparo

```sql
SELECT
    sequencia AS Passo,
    texto_passo AS Descricao,
    tempo_minutos AS TempoEstimadoMinutos
FROM
    modo_preparo_passos
WHERE
    id_ficha_tecnica = @id_ficha -- Use a variável @id_ficha ou o ID específico da ficha
ORDER BY
    sequencia;
```
