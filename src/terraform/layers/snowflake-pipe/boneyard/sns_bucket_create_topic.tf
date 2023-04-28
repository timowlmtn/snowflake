resource "aws_sns_topic" "snowflake_datalake" {
  name = "${var.prefix}-snowflake-datalake-${var.environment}"
}
