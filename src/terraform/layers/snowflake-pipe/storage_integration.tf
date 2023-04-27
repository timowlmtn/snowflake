resource "snowflake_storage_integration" "datalake_integration" {
  name    = upper("${var.prefix}_STORAGE_INTEGRATION_DATA_LAKE_${var.environment}")
  comment = "A Storage integration for the datalake"
  type    = "EXTERNAL_STAGE"

  enabled = true

  storage_provider         = "S3"
  storage_aws_role_arn     = "arn:aws:iam::${var.aws_account_id}:role/${var.prefix}-snowflake-data-lake--${var.domain}-${var.environment}"

  storage_allowed_locations = ["s3://${var.prefix}-datalake-${var.environment}/${var.stage_folder}/"]

}