use schema LANDING_ZONE;

select current_role();

show integrations ;


describe integration OWLMTN_STORAGE_INTEGRATION_DATA_LAKE_DEMO;

/*
+-------------------------+-------------+-------------------------------------------------------------+----------------+
|property                 |property_type|property_value                                               |property_default|
+-------------------------+-------------+-------------------------------------------------------------+----------------+
|ENABLED                  |Boolean      |true                                                         |false           |
|STORAGE_PROVIDER         |String       |S3                                                           |                |
|STORAGE_ALLOWED_LOCATIONS|List         |s3://owlmtn-datalake-dev/stage/                              |[]              |
|STORAGE_BLOCKED_LOCATIONS|List         |                                                             |[]              |
|STORAGE_AWS_IAM_USER_ARN |String       |arn:aws:iam::098765432101:user/asdf-b-a9b83ss9               |                |
|STORAGE_AWS_ROLE_ARN     |String       |arn:aws:iam::123456789012:role/owlmtn-snowflake-data-lake-dev|                |
|STORAGE_AWS_EXTERNAL_ID  |String       |CBA12345_SFCRole=ASDFGBJJDFKS1234ASDFL499LLABS=              |                |
|COMMENT                  |String       |A Storage integration for the datalake                       |                |
+-------------------------+-------------+-------------------------------------------------------------+----------------+

 */

show stages;

describe stage LANDING_ZONE.STAGE_LOG;

show pipes;


describe stage LANDING_ZONE.STAGE_LOG;

list @LANDING_ZONE.STAGE_LOG;

select parse_json(system$pipe_status('PIPE_IMPORT_LOG'));



select min(JSON_OBJECT), max(JSON_OBJECT), count(*)
from LANDING_ZONE.IMPORT_LOG;

select parse_json(system$get_aws_sns_iam_policy('arn:aws:sns:us-east-1:170292442142:owlmtn-snowflake-datalake-dev'));



