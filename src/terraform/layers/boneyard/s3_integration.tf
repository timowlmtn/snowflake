module "datalake" {
  source = "../datalake"

  aws_account_id = var.aws_account_id
  domain         = var.domain
  environment    = var.environment
  prefix         = var.prefix
  region         = var.region
}


data "aws_iam_policy_document" "datalake_queue" {
  statement {
    effect = "Allow"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions   = ["sqs:SendMessage"]
    resources = ["arn:aws:sqs:*:*:s3-event-notification-queue"]

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"
      values   = [module.datalake.datalake_bucket_arn]
    }
  }
}






data "aws_iam_policy_document" "snowflake_integration" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::832620633027:user/s4du-s-p2ss9090"]
    }

    actions   = ["sns:Subscribe"]
    resources = ["arn:aws:sns:us-east-1:170292442142:owlmtn-snowflake-datalake-dev"]
    sid       = 1
  }
}

