use database kmdb;
use schema km_schema;

create or replace procedure refresh_iceberg_tables()
    returns string
    language sql
    execute as caller
as
$$
declare
    tbl_name STRING;
    status_msg STRING;
    sql_cmd STRING;
    failures int := 0;
    event_id VARCHAR := (SELECT TO_VARCHAR(convert_timezone('US/Eastern', CURRENT_TIMESTAMP()), 'YYYYMMDDHH24MISS'));
    cur CURSOR FOR
     SELECT table_catalog, table_schema, table_name FROM kmdb.INFORMATION_SCHEMA.TABLES
      WHERE table_type='BASE TABLE' and table_schema in ('s1')
       and table_name not in ('xx');
begin
    create or replace temporary table temp_refresh_result(event_id varchar, table_name varchar, created timestamp, status varchar);
    FOR rec IN cur DO
        tbl_name := rec.table_catalog||'."'||rec.table_schema||'"."'||rec.table_name||'"';
        sql_cmd := 'alter table ' || tbl_name || ' refresh';

        begin
            execute immediate :sql_cmd;
            status_msg := 'SUCCESS';
        exception
            when other then
                status_msg := 'FAILED: '||sql_cmd|| ':' ||SQLERRM;
                failures := failures + 1;
        end;

        insert into temp_refresh_result(event_id, table_name, created, status) values (:event_id, :tbl_name, current_timestamp(), :status_msg);
    end for;

    return 'Completed, Failures:'||failures||': Log in table: temp_refresh_result for event_id='||event_id;
end;
$$;

call refresh_iceberg_tables();

select * from kmdb.km_schema.temp_refresh_result
 where event_id='20251125184116'
 order by created desc, 1;



