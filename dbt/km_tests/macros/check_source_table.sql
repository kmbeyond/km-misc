{% macro check_source_table(database, schema, table_name) %}
 {% set query %}
  SELECT EXISTS (
   select 1 from {{ database }}.information_schema.tables
    where table_schema='{{ schema }}' and table_name='{{ table_name }}'
    ) AS table_exists
  {% endset %}
  {% set results = run_query(query) %}
  {% if execute %}
    {% set row_count = results.columns[0].values()[0] %}
    {{ return(row_count) }}
  {% endif %}
{% endmacro %}
