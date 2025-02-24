{% macro fix_encoding(columns) %}
    {% for column in columns %}
        convert_from({{ column }}::bytea, 'UTF8') AS {{ column }}
        {% if not loop.last %}, {% endif %}
    {% endfor %}
{% endmacro %}