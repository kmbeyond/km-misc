--{{ config(severity = 'warn') }}

SELECT year(issue_date) as year, count(1) as violations_count
 FROM parking_violations_2023
  GROUP BY 1
   ORDER BY 2 DESC
   LIMIT 10