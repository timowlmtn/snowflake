
output "datalake_bucket_arn" {
  description = "The ARN of the bucket. Will be of format arn:aws:s3:::bucketname."
  value       = aws_s3_bucket.datalake_s3_resource.arn
}

output "datalake_bucket_url" {
  description = "The URL of the bucket"
  value       = "${var.prefix}-datalake-${var.environment}"
}

output "datalake_bucket_id" {
  description = "The ID of the bucket"
  value = aws_s3_bucket.datalake_s3_resource.id
}