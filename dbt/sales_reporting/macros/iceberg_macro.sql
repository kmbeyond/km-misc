{% macro get_incremental_iceberg_merge_sql(arg_dict) %}

 {% set target = arg_dict["target_relation"] %}
 {% set source = arg_dict["temp_relation"] %}
 {% set unique_key = arg_dict["unique_key"] %}
 {% set incremental_predicates = arg_dict["incremental_predicates"] %}

 {{ sync_columns(source, target) }}

 {%- set dest_join_filter -%}
    {%- for col in unique_key -%}
        DBT_INTERNAL_DEST.{{ col }} = DBT_INTERNAL_SOURCE.{{ col }}{% if not loop.last %} AND {% endif %}
    {%- endfor -%}
 {%- endset -%}

 {% set source_columns = adapter.get_columns_in_relation(source) %}
 {%- set dest_cols_update -%}
    {%- for col in source_columns | map(attribute="name") -%}
        {{ col }} = DBT_INTERNAL_SOURCE.{{ col }}{% if not loop.last %}, {% endif %}
    {%- endfor -%}
 {%- endset -%}

 {%- set dest_col_names -%}
    {%- for col in source_columns | map(attribute="name") -%}
        {{ col }}{% if not loop.last %}, {% endif %}
    {%- endfor -%}
 {%- endset -%}

 {%- set dest_cols_insert_values -%}
    {%- for col in source_columns | map(attribute="name") -%}
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
