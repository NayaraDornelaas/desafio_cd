with source_desafio_data as (
    select * from {{ source("desafio_cd", "dados_ficha_a_desafio") }}
)

select * from source_desafio_data