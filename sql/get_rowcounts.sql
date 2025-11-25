
use database kmdb;
use schema km_schema;

-------Proc to get daily counts from all tables in a schema
--create procedure get_table_rowcounts()
--RETURNS table(TABLE_NAME varchar, COUNTS number)
--LANGUAGE SQL
--EXECUTE AS CALLER
--as
DECLARE
  tbl_name STRING;
  sql_cmd STRING := '';
  cur CURSOR FOR
    SELECT table_catalog, table_schema, table_name FROM kmdb.INFORMATION_SCHEMA.TABLES
     WHERE table_type='BASE TABLE' and table_schema in('s1')
      and table_name not in ('x1');
     --WHERE table_type='VIEW' and table_schema = 's1';
  rs_update_counts RESULTSET;
BEGIN
  FOR rec IN cur DO
    tbl_name := rec.table_name;
    tbl_name := rec.table_catalog||'."'||rec.table_schema||'"."'||rec.table_name||'"';
    sql_cmd := sql_cmd || 'SELECT ''' || tbl_name || ''' AS table_name, COUNT(*) AS COUNTS,
                  CONVERT_TIMEZONE(\'America/Los_Angeles\', \'UTC\', max(last_synced))::STRING as last_sync
                FROM ' || tbl_name || '
                --WHERE last_synced >= DATEADD(HOUR, -36, current_timestamp)
                union all ';
  END FOR;
  if (sql_cmd <> '') then
    select 'select * from (' || LEFT(:sql_cmd, LENGTH(:sql_cmd) - 11) || ')tmp order by 1' into :sql_cmd;
    rs_update_counts := (EXECUTE IMMEDIATE :sql_cmd);
  else
    rs_update_counts := (EXECUTE IMMEDIATE 'select ''NO RESULT'' as table_name, 0 as COUNTS');
  end if;
  return table(rs_update_counts);
END;

