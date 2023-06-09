data "aws_iam_policy_document" "sns_topic_policy" {
  policy_id = "__default_policy_ID"

  statement {
    actions = [
      "SNS:Subscribe",
      "SNS:SetTopicAttributes",
      "SNS:RemovePermission",
      "SNS:Receive",
      "SNS:Publish",
      "SNS:ListSubscriptionsByTopic",
      "SNS:GetTopicAttributes",
      "SNS:DeleteTopic",
      "SNS:AddPermission",
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceOwner"

      values = [
        var.aws_account_id,
      ]
    }

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    resources = [
      aws_sns_topic.snowflake_datalake.arn,
    ]

    sid = "__default_statement_ID"
  }
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = [snowflake_storage_integration.datalake_integration.storage_aws_iam_user_arn]
    }

    actions   = ["sns:Subscribe"]
    resources = [aws_sns_topic.snowflake_datalake.arn]
    sid       = 1
  }
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com"]
    }

    actions   = ["sns:Publish"]
    resources = [aws_sns_topic.snowflake_datalake.arn]
    sid       = "s3-event-notifier"

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"
      values   = ["arn:aws:s3:::${var.prefix}-datalake-${var.environment}"]
    }

  }
}

resource "aws_sns_topic_policy" "this" {
  arn    = aws_sns_topic.snowflake_datalake.arn
  policy = data.aws_iam_policy_document.sns_topic_policy.json
}