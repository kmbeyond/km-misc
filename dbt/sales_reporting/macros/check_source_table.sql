{% macro check_source_table(database, schema, table_name) %}
 {% set query %}
  SELECT EXISTS (
   select 1 from information_schema.tables
    where table_schema='{{ schema }}' and table_name='{{ table_name }}'
    ) AS table_exists
  {% endset %}
  {{ log("*** Execute SQL:" ~ query) }}
  {% set results = run_query(query) %}
  {% if execute %}
    {% set row_count = results.columns[0].values()[0] %}
    {{ log("*** rowcount:" ~ row_count) }}
    {{ return(row_count) }}
  {% endif %}
{% endmacro %}
