{% macro fix_encoding(columns) %}
    {% for column in columns %}
        CASE
            -- caso seja JSON array e não estiver vazio, converte para string
            WHEN jsonb_typeof({{ column }}::jsonb) = 'array' AND jsonb_array_length({{ column }}::jsonb) > 0 THEN 
                array_to_string(ARRAY(
                    SELECT jsonb_array_elements_text({{ column }}::jsonb)
                ), ', ')

            -- caso seja JSON array mas esteja vazio
            WHEN jsonb_typeof({{ column }}::jsonb) = 'array' AND jsonb_array_length({{ column }}::jsonb) = 0 THEN NULL

            -- caso seja uma string com formato de JSON array remove colchetes e aspas
            WHEN {{ column }} ~ '^\[.*\]$' THEN 
                regexp_replace({{ column }}, '^\["?(.*?)"?\]$', '\1', 'g')

            -- caso seja uma string "[]"
            WHEN {{ column }} = '[]' THEN NULL

            -- caso seja texto corrompido, substitui '[]' por NULL e corrige encoding
            ELSE NULLIF(convert_from({{ column }}::bytea, 'UTF8'), '[]')
        END AS {{ column }}
        {% if not loop.last %}, {% endif %}
    {% endfor %}
{% endmacro %}


