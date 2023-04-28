resource "snowflake_stage" "datalake" {
  name                = var.stage_name
  comment             = "Stage for s3://${var.datalake_storage}/${var.stage_folder}"
  url                 = "s3://${var.datalake_storage}/${var.stage_folder}/"
  database            = var.snowflake_database
  schema              = var.landing_zone_schema
  storage_integration = var.storage_integration
}

resource "snowflake_pipe" "pipe" {
  database = var.snowflake_database
  schema   = var.landing_zone_schema
  name     = "PIPE_${var.table_name}"

  comment = "Pipe for loading s3://${var.datalake_storage}/${var.stage_folder} into ${var.table_name}"

  copy_statement = <<EOT
copy into ${var.snowflake_database}.${var.landing_zone_schema}.${var.table_name}
    from @${var.snowflake_database}.${var.landing_zone_schema}.${var.stage_name}
    file_format = (type = JSON)
EOT

  auto_ingest    = true

  aws_sns_topic_arn    = var.snowflake_data_sns_arn
  error_integration    = var.snowflake_error_sns_arn

}