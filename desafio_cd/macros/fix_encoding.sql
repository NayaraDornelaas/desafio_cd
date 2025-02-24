{% macro fix_encoding(columns) %}
    {% for column in columns %}
        CASE
            -- caso sea um JSON converte para uma string formatada
            WHEN jsonb_typeof({{ column }}::jsonb) = 'array' AND jsonb_array_length({{ column }}::jsonb) > 0 THEN
                array_to_string(ARRAY(
                    SELECT jsonb_array_elements_text({{ column }}::jsonb)
                ), ', ')

            -- caso seja um JSON array vazio converte para null
            WHEN jsonb_typeof({{ column }}::jsonb) = 'array' THEN NULL 

            -- caso seja texto corrompido, corrige o encoding
            ELSE convert_from({{ column }}::bytea, 'UTF8')
        END AS {{ column }}
        {% if not loop.last %}, {% endif %}
    {% endfor %}
{% endmacro %}
