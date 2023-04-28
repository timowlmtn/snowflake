use schema LANDING_ZONE;

select current_role();

show integrations ;


describe integration OWLMTN_STORAGE_INTEGRATION_DATA_LAKE_DEV;


show stages;

describe stage DEV_CATALOG.LANDING_ZONE.STAGE_LOG;

show pipes;


describe stage DEV_CATALOG.LANDING_ZONE.STAGE_LOG;

list @DEV_CATALOG.LANDING_ZONE.STAGE_LOG;



select parse_json(system$pipe_status('PIPE_IMPORT_LOG'));

select min(JSON_OBJECT), max(JSON_OBJECT), count(*)
from DEV_CATALOG.LANDING_ZONE.IMPORT_LOG;

select parse_json(system$get_aws_sns_iam_policy('arn:aws:sns:us-east-1:170292442142:owlmtn-snowflake-datalake-dev'));



