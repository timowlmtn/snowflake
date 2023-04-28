#output "aws_sns_topic_policy_name" {
#  description = "The IAM user for the Snowflake Storage Integration External ID"
#  value       = aws_sns_topic.snowflake_datalake.name
#}


output "snowflake_playlist_stage" {
  description = "The stage for the snowflake output"
  value       = module.snowflake_datalake_playlists.datalake_stage
}

output "snowflake_show_stage" {
  description = "The stage for the snowflake output"
  value       = module.snowflake_datalake_playlists.datalake_stage
}
