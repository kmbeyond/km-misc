{% macro sync_columns(source_relation, target_relation) %}
    {%- set src_cols = adapter.get_columns_in_relation(source_relation) -%}
    {%- set tgt_cols = adapter.get_columns_in_relation(target_relation) -%}

    {%- for src_col in src_cols -%}
        {%- for tgt_col in tgt_cols if src_col.name == tgt_col.name -%}
            {%- if src_col.dtype != tgt_col.dtype -%}
                {{ exceptions.raise_compiler_error(
                    "Column Data Type mismatch: \n'" ~ src_col.name ~ "' has type '" ~ src_col.dtype ~
                    "' in source but '" ~ tgt_col.dtype ~ "' in target. " ~
                    "Changing data type is not supported. Please perform a full-refresh or manual migration."
                ) }}
            {%- endif -%}
        {%- endfor -%}
    {%- endfor -%}

    {%- set tgt_col_names = tgt_cols | map(attribute="name") | list -%}
    {%- set alter_stmts = [] -%}
    {%- for src_col in src_cols -%}
        {%- if src_col.name not in tgt_col_names -%}
            {%- set stmt = "ALTER TABLE " ~ target_relation ~ " ADD COLUMN " ~ src_col.name ~ " " ~ src_col.data_type %}
            {% do run_query(stmt) %}
        {%- endif -%}
    {%- endfor -%}

    {%- for stmt in alter_stmts %}
        {{ stmt }};
    {%- endfor %}
{% endmacro %}
