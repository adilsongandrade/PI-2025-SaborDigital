-- e) modo de preparo
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