{{ config(materialized='table') }}

SELECT * FROM {{ref('my_first_dbt_model')}}
