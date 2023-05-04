#resource "aws_s3_bucket_notification" "snowflake_notification" {
#  bucket = "${var.prefix}-datalake-${var.environment}"
#
#  queue {
#    queue_arn     = module.snowflake_datalake_logs.notification_channel
#    events        = ["s3:ObjectCreated:*"]
#  }
#}