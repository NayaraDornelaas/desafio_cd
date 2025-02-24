SELECT
    {{ convert_booleans([
        'obito',
        'luz_eletrica',
        'em_situacao_de_rua',
        'frequenta_escola',
        'possui_plano_saude',
        'vulnerabilidade_social',
        'familia_beneficiaria_auxilio_brasil'
    ]) }}
FROM {{ source('desafio_cd', 'dados_ficha_a_desafio') }}