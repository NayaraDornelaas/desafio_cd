WITH duplicate_pacientes AS (
    SELECT 
        id_paciente,
        COUNT(*) AS registers_total
    FROM {{ source('desafio_cd', 'dados_ficha_a_desafio') }}
    GROUP BY id_paciente
    HAVING COUNT(*) > 1 
)

SELECT d.*
FROM {{ source('desafio_cd', 'dados_ficha_a_desafio') }} d
JOIN duplicate_pacientes dp ON d.id_paciente = dp.id_paciente
ORDER BY d.id_paciente