{{ config(materialized='table') }}

SELECT plate_id, count(*) as violations_count
 FROM parking_violations_2023
  group by 1 order by 2 desc
  LIMIT 10