{%- macro
 destroy_s3_pipe(
    schema_name,
    table_name,
    storage_integration,
    s3_url,
    properties
 )

-%}
{%- set sql -%}
begin;

drop pipe if exists {{ schema_name }}.PIPE_{{ table_name }};
drop table if exists {{ schema_name }}.{{ table_name }};
drop stage if exists {{ schema_name }}.STAGE_{{ table_name }};

commit;
{%- endset -%}

{%- do log(sql, info=True) -%}
{%- do run_query(sql) -%}
{%- do log("Auto-ingest pipe destroyed", info=True) -%}
{%- endmacro -%}