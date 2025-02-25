with base as (
    select 
        nome, {{ fix_encoding(['religiao']) }} as religiao -- austar o encoding da coluna
    from {{ source('desafio_cd', 'dados_ficha_a_desafio') }} 
),

ajustado as (
    select
        nome,
        case 
            when religiao in ('Catolicismo', 'Evangelismo', 'Espiritismo', 
                              'Candomblé', 'Islamismo', 'Judaísmo', 'Budismo', 
                              'Religião de matriz africana', 'Sem religião', 'Outra') 
            then religiao
            else null
        end as religiao
    from base
)

select * from ajustado
