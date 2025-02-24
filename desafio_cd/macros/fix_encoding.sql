{% macro fix_encoding(columns) %}
    {% for column in columns %}
        CASE
            -- passar de aspas simples para aspas duplas e converte para uma string
            WHEN {{ column }} ~ '^\[.*\]$' AND {{ column }} LIKE '%''%' THEN 
                array_to_string(ARRAY(
                    SELECT jsonb_array_elements_text(
                        replace({{ column }}, '''', '"')::jsonb
                    )
                ), ', ')

            -- converter json array para string
            WHEN {{ column }} ~ '^\[.*\]$' AND ({{ column }} ~ '^\s*\[.*\]\s*$' AND {{ column }} !~ '[^\[\],{}"\s]') THEN 
                array_to_string(ARRAY(
                    SELECT jsonb_array_elements_text(replace({{ column }}, '''', '"')::jsonb)
                ), ', ')

            -- caso esteja vazio
            WHEN {{ column }} = '[]' THEN NULL

            -- remove colchetes e aspas erradas
            WHEN {{ column }} ~ '^\[.*\]$' THEN 
                regexp_replace({{ column }}, '\[|\]|''', '', 'g')

            -- caso seja bytea, converte para UTF-8
            WHEN pg_typeof({{ column }})::TEXT = 'bytea' 
                THEN convert_from({{ column }}::bytea, 'UTF8')

            -- caso nao seja json, retorna o valor original 
            ELSE {{ column }}
        END AS {{ column }}
        {% if not loop.last %}, {% endif %}
    {% endfor %}
{% endmacro %}