{% macro get_incremental_iceberg_merge_sql(arg_dict) %}

  {% set dest_columns = adapter.get_columns_in_relation(this) %}
  {% if dest_columns | length == 0 %}
     {% set dest_columns = adapter.get_columns_in_relation(arg_dict["temp_relation"]) %}
  {% endif %}

  {% do return(my_custom_merge_sql(arg_dict["target_relation"], arg_dict["temp_relation"], arg_dict["unique_key"], dest_columns, arg_dict["incremental_predicates"])) %}

{% endmacro %}



{% macro my_custom_merge_sql(target, source, unique_key, dest_columns, incremental_predicates) %}

{%- set dest_join_filter -%}
    {%- for col in unique_key -%}
        DBT_INTERNAL_DEST.{{ col }} = DBT_INTERNAL_SOURCE.{{ col }}{% if not loop.last %} AND {% endif %}
    {%- endfor -%}
{%- endset -%}

{%- set dest_cols_update -%}
    {%- for col in dest_columns | map(attribute="name") -%}
        {{ col }} = DBT_INTERNAL_SOURCE.{{ col }}{% if not loop.last %}, {% endif %}
    {%- endfor -%}
{%- endset -%}

{%- set dest_col_names -%}
    {%- for col in dest_columns | map(attribute="name") -%}
        {{ col }}{% if not loop.last %}, {% endif %}
    {%- endfor -%}
{%- endset -%}

{%- set dest_cols_insert_values -%}
    {%- for col in dest_columns | map(attribute="name") -%}
        DBT_INTERNAL_SOURCE.{{ col }}{% if not loop.last %}, {% endif %}
    {%- endfor -%}
{%- endset -%}


    MERGE INTO {{ target }} AS DBT_INTERNAL_DEST
    USING {{ source }} AS DBT_INTERNAL_SOURCE
      ON {{ dest_join_filter }}
    WHEN MATCHED THEN UPDATE SET
        {{ dest_cols_update }}
    WHEN NOT MATCHED THEN INSERT (
        {{ dest_col_names }}
    ) VALUES (
        {{ dest_cols_insert_values }}
    );
{% endmacro %}
