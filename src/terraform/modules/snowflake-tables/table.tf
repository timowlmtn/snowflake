
resource "snowflake_table" "table" {
  for_each = var.domain_model["properties"]

  database            = var.snowflake_database
  schema              = var.landing_zone_schema
  name                = var.table_name
  comment             = "Terraform created ${var.table_name} for ${var.datalake_storage}/${var.stage_folder}"
  cluster_by          = var.cluster_columns

  change_tracking     = false

  column {
    name     = each.value["COLUMN_NAME"]
    type     = each.value["DATA_TYPE"]
    nullable = each.value == "YES" ? true : false

  }


}