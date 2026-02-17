{{ 
  config(
    materialized='incremental',
    enabled=true,
    unique_key = ['rec_id'],
    cluster_by = ['rec_id'],
    incremental_strategy = 'iceberg_merge',
    file_format='iceberg',
  ) 
}}

with
src as (
  select * from (
   select *, row_number() over (PARTITION BY campaign_id order by day desc,`_fivetran_synced` desc) as row_number_x
     from {{ source('kmdb', 'km_tbl') }}
   ) where row_number_x=1
)
select * except (row_number_x)
 from src
   {% if is_incremental() %}
     where to_date(day, 'MM/dd/yyyy')>=current_date-3
   {% endif %}
;

