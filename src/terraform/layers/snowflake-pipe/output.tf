#output "aws_sns_topic_policy_name" {
#  description = "The IAM user for the Snowflake Storage Integration External ID"
#  value       = aws_sns_topic.snowflake_datalake.name
#}


output "storage_aws_iam_user_arn" {
  description = "The IAM user for the Snowflake AWS Principal"
  value       = snowflake_storage_integration.datalake_integration.storage_aws_iam_user_arn
}

output "storage_aws_external_id" {
  description = "The IAM user for the Snowflake Storage Integration External ID"
  value       = snowflake_storage_integration.datalake_integration.storage_aws_external_id
}

output "integration_aws_external_id" {
  description = "The ID value for Snowflake notification integration"
  value = snowflake_notification_integration.integration.aws_sns_external_id
}

