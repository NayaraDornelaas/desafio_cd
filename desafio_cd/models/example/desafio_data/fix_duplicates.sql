WITH ids_duplicados AS (
    SELECT 
        id_paciente,
        data_nascimento,
        sexo,
        raca_cor,
        data_cadastro,
        ROW_NUMBER() OVER (
            PARTITION BY id_paciente 
            ORDER BY data_atualizacao_cadastro DESC
        ) AS rn
    FROM {{ source('desafio_cd', 'dados_ficha_a_desafio') }}
)

SELECT 
    CASE 
        WHEN rn = 1 THEN id_paciente::uuid  
        ELSE 
            -- Gerar um identificador único a partir de um hash MD5 e converter para UUID
            md5(
                COALESCE(data_nascimento::TEXT, '') || 
                COALESCE(sexo, '') || 
                COALESCE(raca_cor, '') || 
                COALESCE(data_cadastro::TEXT, '')
            )::uuid 
    END AS novo_id_paciente,
    *
FROM ids_duplicados