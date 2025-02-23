with source_desafio_data as (
    select * from {{ source("desafio_cd", "dados_ficha_a_desafio") }}
)

final as(
    select * from source_desafio_data
)

select * from source_desafio_data