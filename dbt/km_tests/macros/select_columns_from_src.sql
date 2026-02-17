{% macro select_columns_from_src(source_name, table_name) %}
    {% set relation = builtins.source(source_name, table_name) %}
    {{ log(' -->'~relation, info=True) }}
    {{ log(' -->'~relation.render(), info=True) }}
    {% set cols = adapter.get_columns_in_relation(relation) %}
    {% if target.type == 'snowflake' %}
        {% for col in cols %}
            "{{ col.name }}" as "{{ col.name.upper() }}" {% if not loop.last %}, {% endif %}
        {% endfor %}
    {% else %}
        {% for col in cols %}
            {{ col.name }} {% if not loop.last %}, {% endif %}
        {% endfor %}
    {% endif %}
{% endmacro %}
