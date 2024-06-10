--  {{ config(materialized='table') }}  --

SELECT prod.ID, prod.NAME, prod.LIST_PRICE
 FROM mycompany.T_PRODUCTS prod
  WHERE 1=1
   AND NOT EXISTS (SELECT distinct PROD_ID FROM mycompany.T_ORDER_LINES ol WHERE ol.PROD_ID=prod.ID)