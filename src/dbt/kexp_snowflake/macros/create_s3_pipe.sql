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
   {{ col }}
        {{ column_mapping['DATA_TYPE'] }}
        {% if column_mapping['IS_IDENTITY'] %}PRIMARY KEY AUTOINCREMENT{% endif %}
        {% if not column_mapping['IS_NULLABLE'] %}not null{% endif %}
        {% if column_mapping['COLUMN_DEFAULT'] %}DEFAULT {{ column_mapping['COLUMN_DEFAULT'] }}{% endif %}
        {% if column_mapping['COMMENT'] %}COMMENT '{{ column_mapping['COMMENT'] }}'{% endif %}

        {% if not loop.last %},{% endif %}
   {%- endfor %}
 );

create pipe if not exists {{ schema_name }}.PIPE_{{ table_name }}
    AUTO_INGEST = true
    ERROR_INTEGRATION = S3_LAKE_KEXP_NOTIFICATION
as
    copy into {{ schema_name }}.{{ table_name }}(
        {%- for col, column_mapping in properties.items() %}
            {% if not column_mapping['IS_IDENTITY'] %}
                {{ col }}
                {% if not loop.last %},{% endif %}
            {% endif %}
        {%- endfor %}
        )
    from (
        select {%- for col, column_mapping in properties.items() %}
            {% if not column_mapping['IS_IDENTITY'] %}
                {% if column_mapping['DEFAULT'] is defined %}{{ column_mapping['DEFAULT'] }} {{ col }}
                {% else %}$1:{{ col }}::{{ column_mapping['DATA_TYPE'] }} {{ col }}{% endif %}{% if not loop.last %},{% endif %}
            {% endif %}
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