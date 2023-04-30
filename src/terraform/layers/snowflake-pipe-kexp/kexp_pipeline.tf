locals {
  show_definition = jsondecode(file("../../../../domain/kexp/radio_show_kexp_pipe.json"))
  playlist_definition = jsondecode(file("../../../../domain/kexp/simple.json"))
}

module "snowflake_datalake_playlists" {
  source = "../../modules/snowflake-tables"
  datalake_storage = "${var.prefix}-datalake-${var.environment}"
  stage_folder = "${var.stage_folder}/${var.data_source}/playlists"
  stage_name = "STAGE_PLAYLIST"
  table_name = "IMPORT_PLAYLIST"
  snowflake_database = upper("${var.environment}_CATALOG")
  landing_zone_schema = var.landing_zone_schema
  environment = var.environment
  storage_integration = upper("${var.prefix}_STORAGE_INTEGRATION_DATA_LAKE_${var.environment}")
  domain_model = local.playlist_definition
}

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

