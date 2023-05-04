resource "snowflake_pipe" "pipe" {
  database = var.snowflake_database
  schema   = var.landing_zone_schema
  name     = "PIPE_${var.table_name}"

  comment = "Pipe for loading stage ${snowflake_stage.datalake.name}"

  copy_statement = <<EOT
copy into ${var.snowflake_database}.${var.landing_zone_schema}.${var.table_name}
    from @${var.snowflake_database}.${var.landing_zone_schema}.${snowflake_stage.datalake.name}
    file_format = (type = JSON)
EOT

  auto_ingest    = true


  #  aws_sns_topic_arn    = var.snowflake_data_sns_arn
  error_integration    = var.snowflake_error_integration

}