{% macro format_datetime(column) %}
    TO_CHAR({{ column }}, 'DD/MM/YYYY HH24:MI')
{% endmacro %}