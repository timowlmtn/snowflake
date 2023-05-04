resource "aws_iam_role" "snowflake_notification" {
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          AWS = snowflake_notification_integration.integration.aws_sns_iam_user_arn
        }
        Condition = {
          StringEquals = {
            "sts:ExternalId" = snowflake_notification_integration.integration.aws_sns_external_id
          }
        }
      }
    ]
  })

  name = "${var.prefix}-snowflake-notification-${var.environment}"

}



data "aws_iam_policy_document" "snowflake_notification" {

  # Bucket metadata
  statement {
    sid = "1"
    actions = [
      "sns:Publish",
      "sns:Subscribe"
    ]

    resources = [
      aws_sns_topic.snowflake_notification.arn
    ]
  }

}

resource "aws_iam_role_policy" "snowflake_notification" {
  name     = "policy-snowflake-notification"
  policy   = data.aws_iam_policy_document.snowflake_notification.json
  role     = aws_iam_role.snowflake_notification.name
}

