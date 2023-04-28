
resource "snowflake_table" "table" {
  database            = var.snowflake_database
  schema              = var.landing_zone_schema
  name                = var.table_name
  comment             = "Terraform created ${var.table_name} for ${var.datalake_storage}/${var.stage_folder}"
  cluster_by          = var.cluster_columns

  change_tracking     = false

  column {
    name     = "JSON_OBJECT"
    type     = "VARIANT"
    nullable = true

  }


}