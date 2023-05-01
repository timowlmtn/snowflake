locals {
  show_definition     = jsondecode(file("../../../../domain/kexp/radio_show_kexp_pipe.json"))
  playlist_definition = jsondecode(file("../../../../domain/kexp/radio_playlist_kexp_pipe.json"))
}


locals {
  playlist_copy_columns = join(", ", [
    for key, value in local.playlist_definition["properties"] :
    format("%s", value["COLUMN_NAME"])
  ])

  playlist_copy_select = join(", ", [
    for key, map_value in local.playlist_definition["properties"] :
    lookup(map_value, "COLUMN_DEFAULT", format("$1:%s", join("::", [key, map_value["DATA_TYPE"]])))
  ])

  playlist_copy = <<EOT
copy into ${var.landing_zone_schema}.TABLE_NAME(
  ${local.playlist_copy_columns}
)
    from (
      select ${local.playlist_copy_select}
      from
        @${var.landing_zone_schema}.STAGE_NAME
    )
    file_format = (type = JSON)
EOT

}


#module "snowflake_datalake_playlists" {
#  source = "../../modules/snowflake-tables"
#  datalake_storage = "${var.prefix}-datalake-${var.environment}"
#  stage_folder = "${var.stage_folder}/${var.data_source}/playlists"
#  stage_name = "STAGE_PLAYLIST"
#  table_name = "IMPORT_PLAYLIST"
#  snowflake_database = upper("${var.environment}_CATALOG")
#  landing_zone_schema = var.landing_zone_schema
#  environment = var.environment
#  storage_integration = upper("${var.prefix}_STORAGE_INTEGRATION_DATA_LAKE_${var.environment}")
#  domain_model = local.playlist_definition
#}

#module "snowflake_datalake_shows" {
#  source = "../../modules/snowflake-tables"
#  datalake_storage = "${var.prefix}-datalake-${var.environment}"
#  stage_folder = "${var.stage_folder}/${var.data_source}/shows"
#  stage_name = "STAGE_SHOW"
#  table_name = "IMPORT_SHOW"
#  snowflake_database = upper("${var.environment}_CATALOG")
#  landing_zone_schema = var.landing_zone_schema
#  environment = var.environment
#  storage_integration = upper("${var.prefix}_STORAGE_INTEGRATION_DATA_LAKE_${var.environment}")
#  domain_model = local.show_definition
#}

