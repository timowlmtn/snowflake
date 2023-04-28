resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = "${var.prefix}-datalake-${var.environment}"

  topic {
    topic_arn     = aws_sns_topic.snowflake_datalake.arn
    events        = ["s3:ObjectCreated:*"]
  }
}

