{% macro convert_booleans(columns) %}
    {% for column in columns %}
        CASE 
            WHEN CAST({{ column }} AS TEXT) IN ('1', 'true') THEN true 
            WHEN CAST({{ column }} AS TEXT) IN ('0', 'false') THEN false 
            ELSE NULL 
        END AS {{ column }}
        {% if not loop.last %}, {% endif %}
    {% endfor %}
{% endmacro %}