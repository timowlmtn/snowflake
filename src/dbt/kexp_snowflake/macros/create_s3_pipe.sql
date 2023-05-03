{%- macro
 create_s3_pipe(
    schema_name,
    table_name,
    storage_integration,
    s3_url,
    properties
 )

-%}
{%- set sql -%}
begin;
create schema if not exists {{  schema_name }};

create stage if not exists {{  schema_name }}.STAGE_{{ table_name }}
storage_integration = {{ storage_integration|upper }}
url = "{{ s3_url }}";

create table if not exists {{ schema_name }}.{{ table_name }} (
   {%- for col, column_mapping in properties.items() %}
   {{ col }} {{ column_mapping['DATA_TYPE'] }}{% if not loop.last %},{% endif %}
   {%- endfor %}
 );

create pipe if not exists {{ schema_name }}.PIPE_{{ table_name }}
    AUTO_INGEST = true
    ERROR_INTEGRATION = S3_LAKE_KEXP_NOTIFICATION
as
    copy into {{ schema_name }}.{{ table_name }}(
        {%- for col, column_mapping in properties.items() %}
            {{ col }}{% if not loop.last %},{% endif %}
        {%- endfor %}
        )
    from (
        select {%- for col, column_mapping in properties.items() %}
            {% if column_mapping['DEFAULT'] is defined %}{{ column_mapping['DEFAULT'] }} {{ col }}
            {% else %}$1:{{ col }}::{{ column_mapping['DATA_TYPE'] }} {{ col }}{% endif %}{% if not loop.last %},{% endif %}
        {%- endfor %}
        from @{{ schema_name }}.STAGE_{{ table_name }}
    )
    FILE_FORMAT = (type = 'JSON')
    PATTERN = '.*.json';

commit;
{%- endset -%}

{%- do log(sql, info=True) -%}
{%- do run_query(sql) -%}
{%- do log("Auto-ingest pipe created", info=True) -%}
{%- endmacro -%}