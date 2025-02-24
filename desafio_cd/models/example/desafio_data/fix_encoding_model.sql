WITH source_data AS (
    SELECT 
        {%  set columns = [
            'bairro',
            'religiao',
            'escolaridade',
            'nacionalidade',
            'renda_familiar',
            'meios_transporte',
            'doencas_condicoes',
            'identidade_genero',
            'meios_comunicacao',
            'orientacao_sexual',
            'em_caso_doenca_procura',
            'situacao_profissional',
            'tipo'
        ] %}

        {{ fix_encoding(columns) }}
        
    FROM {{ source('desafio_cd', 'dados_ficha_a_desafio') }}
)

SELECT * FROM source_data

