output "datalake_stage" {
  description = "The Name of the snowflake stage object"
  value = snowflake_stage.datalake.name
}

output "notification_channel" {
  description = "THe notification channel in AWS the pipe will use"
  value = snowflake_pipe.pipe.notification_channel
}