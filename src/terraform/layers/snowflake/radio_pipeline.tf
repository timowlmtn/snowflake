data "aws_iam_policy_document" "snowflake_pipe" {

  # Bucket metadata
  statement {
    actions = [
      "sns:Publish"
    ]

    resources = [
      "arn:aws:s3:::${var.prefix}-snowflake-pipe-${var.environment}"
    ]
  }

}

module "snowflake_datalake_playlists" {
  source = "../../modules/snowflake"
  datalake_storage = "${var.prefix}-datalake-${var.environment}"
  stage_folder = "${var.stage_folder}/${var.data_source}/playlists"
  stage_name = "STAGE_PLAYLIST"
  table_name = "IMPORT_PLAYLIST"
  snowflake_database = upper("${var.environment}_CATALOG")
  landing_zone_schema = var.landing_zone_schema
  storage_integration = upper("${var.prefix}_STORAGE_INTEGRATION_DATA_LAKE_${var.environment}")
}

module "snowflake_datalake_shows" {
  source = "../../modules/snowflake"
  datalake_storage = "${var.prefix}-datalake-${var.environment}"
  stage_folder = "${var.stage_folder}/${var.data_source}/shows"
  stage_name = "STAGE_SHOW"
  table_name = "IMPORT_SHOW"
  snowflake_database = upper("${var.environment}_CATALOG")
  landing_zone_schema = var.landing_zone_schema
  storage_integration = upper("${var.prefix}_STORAGE_INTEGRATION_DATA_LAKE_${var.environment}")

}

