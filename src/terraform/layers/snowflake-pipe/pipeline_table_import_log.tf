module "snowflake_datalake_logs" {
  source = "../../modules/snowflake-tables"
  datalake_storage = "${var.prefix}-datalake-${var.environment}"
  stage_folder = "${var.stage_folder}/${var.data_source}/logs"
  stage_name = "STAGE_LOG"
  table_name = "IMPORT_LOG"
  snowflake_database = upper("${var.environment}_CATALOG")
  landing_zone_schema = var.landing_zone_schema
  environment = var.environment
  storage_integration = snowflake_storage_integration.datalake_integration.name
  snowflake_data_sns_arn = aws_sns_topic.snowflake_notification.arn
  snowflake_error_integration = snowflake_notification_integration.integration.name

  depends_on = [aws_iam_role_policy.snowflake_notification, aws_iam_role_policy.snowflake]

}