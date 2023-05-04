resource "aws_sns_topic" "snowflake_notification" {
  name = "${var.prefix}-snowflake-notification-${var.environment}"
}
