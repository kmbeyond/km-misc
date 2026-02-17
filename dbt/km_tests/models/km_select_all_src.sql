{{
  config(
    materialized=materialization('view')
  )
}}

{# ,post_hook="drop view if exists {{ this }}" #}

SELECT {{ select_all_with_alias('src_km_test', 'km_test_dates') }}
 from {{ source('src_km_test', 'km_test_dates') }}
