with keys as (
    select object_agg(lpad(ORDINAL_POSITION,2, '0')|| '-' || lower( column_name ), object_construct(
            'COLUMN_NAME', COLUMN_NAME,
            'DATA_TYPE', DATA_TYPE,
            'IS_NULLABLE', IS_NULLABLE,
            'IS_IDENTITY', IS_IDENTITY,
            'COLUMN_DEFAULT', COLUMN_DEFAULT,
            'COMMENT', COALESCE(COMMENT, 'Add a comment here.'),
            'ORDINAL_POSITION', ORDINAL_POSITION
        )   )  properties
        from information_schema.columns
    where table_name = 'IMPORT_KEXP_PLAYLIST' and TABLE_SCHEMA = 'STAGE'
    order by ORDINAL_POSITION

)
select object_construct('properties', properties)
from keys;

use role ROLE_TIMBURNSDEV;
with keys as (
    select object_agg(lpad(ORDINAL_POSITION,2, '0')|| '-' || lower( column_name ), object_construct(
            'COLUMN_NAME', COLUMN_NAME,
            'DATA_TYPE', DATA_TYPE,
            'IS_NULLABLE', IS_NULLABLE,
            'IS_IDENTITY', IS_IDENTITY,
            'COLUMN_DEFAULT', COLUMN_DEFAULT,
            'COMMENT', COALESCE(COMMENT, 'Add a comment here.'),
            'ORDINAL_POSITION', ORDINAL_POSITION
        )   )  properties
        from information_schema.columns
    where table_name = 'IMPORT_KEXP_SHOW' and TABLE_SCHEMA = 'STAGE'
    order by ORDINAL_POSITION

)
select object_construct('properties', properties)
from keys;

use role ACCOUNTADMIN;

show grants on table OWLMTN.STAGE.IMPORT_KEXP_SHOW;
