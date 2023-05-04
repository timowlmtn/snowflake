resource "snowflake_notification_integration" "integration" {
  name    = upper("${var.prefix}_NOTIFICATION_INTEGRATION_${var.environment}")
  comment = "The integration using ${var.prefix}-snowflake-notification-${var.environment}"

  enabled   = true
  type      = "QUEUE"
  direction = "OUTBOUND"

  notification_provider = "AWS_SNS"
  aws_sns_topic_arn     = "arn:aws:sns:${var.region}:${var.aws_account_id}:${var.prefix}-snowflake-notification-${var.environment}"
  aws_sns_role_arn      = "arn:aws:iam::${var.aws_account_id}:role/${var.prefix}-snowflake-notification-${var.environment}"
}