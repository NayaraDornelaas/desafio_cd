{% macro fix_encoding(columns) %}
    {% for column in columns %}
        CASE
          -- caso a coluna estea no formato json, converte para uma string sql text  
            WHEN jsonb_typeof({{ column }}::jsonb) = 'array' THEN 
                array_to_string(ARRAY(
                    SELECT jsonb_array_elements_text({{ column }}::jsonb)
                ), ', ')
             -- caos seja texto corrompido, conrrige o encoding 
            ELSE convert_from({{ column }}::bytea, 'UTF8')
        END AS {{ column }}
        {% if not loop.last %}, {% endif %}
    {% endfor %}
{% endmacro %}