
locals {
  playlist_copy_columns = join(", ", [
    for key, value in var.domain_model["properties"] :
    format("%s", value["COLUMN_NAME"])
  ])

  playlist_copy_select = join(", ", [
    for key, map_value in var.domain_model["properties"] :
    lookup(map_value, "COLUMN_DEFAULT", format("$1:%s", join("::", [key, map_value["DATA_TYPE"]])))
  ])

  playlist_copy = <<EOT
copy into ${var.snowflake_database}.${var.landing_zone_schema}.${var.table_name}(
  ${local.playlist_copy_columns}
)
    from (
      select ${local.playlist_copy_select}
      from
        @${var.snowflake_database}.${var.landing_zone_schema}.${snowflake_stage.datalake.name}
    )
    file_format = (type = JSON)
EOT

}



resource "snowflake_pipe" "pipe" {
  database = var.snowflake_database
  schema   = var.landing_zone_schema
  name     = "PIPE_${var.table_name}"

  comment = "Pipe for loading s3://${var.datalake_storage}/${var.stage_folder} into ${var.table_name}"

  copy_statement = local.playlist_copy

  auto_ingest    = true

  aws_sns_topic_arn    = var.snowflake_data_sns_arn
  error_integration    = var.snowflake_error_sns_arn

}