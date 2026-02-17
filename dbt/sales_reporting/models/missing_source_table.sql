{{
 config(materialized='view')
}}

{% set source_rowcount = check_source_table('mycompany', 'mycompany', 'T_PRODUCTSx') %}

{% if source_rowcount %}
 select * from mycompany.T_PRODUCTSx
{% else %}
 select 0 as id where 1=0
{% endif %}
