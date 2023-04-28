resource "aws_s3_bucket_notification" "snowflake_integration" {
  bucket = module.datalake.datalake_bucket_id
  queue {
    queue_arn = "arn:aws:sqs:us-east-1:832620633027:sf-snowpipe-AIDA4DXAOTPBQPDNZOC7J-qyEzIgbXVGf25tj-SVu-Ug"
    events    = ["s3:ObjectCreated:*"]
  }
}
