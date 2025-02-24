WITH source_data AS (
    SELECT 
        id_paciente,
        {{ format_datetime('data_cadastro') }} AS data_cadastro,
        {{ format_datetime('data_atualizacao_cadastro') }} AS data_atualizacao_cadastro,
        {{ format_datetime('updated_at') }} AS updated_at
    FROM {{ source('desafio_cd', 'dados_ficha_a_desafio') }}
)

SELECT * FROM source_data
