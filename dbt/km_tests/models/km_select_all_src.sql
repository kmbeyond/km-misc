{{
  config(
    materialized='view'
  )
}}

{# ,post_hook="drop view if exists {{ this }}" #}

SELECT {{ select_columns_from_src('src_duckdb', 'data_customers') }}
 from {{ source('src_duckdb', 'data_customers') }}
