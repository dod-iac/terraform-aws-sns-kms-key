/**
 * ## Usage
 *
 * Creates a KMS Key for use with SNS.
 *
 * ```hcl
 * module "sns_kms_key" {
 *   source = "dod-iac/sns-kms-key/aws"
 *
 *   name = format("alias/app-%s-sns-%s", var.application, var.environment)
 *   description = format("A SNS key used to encrypt SNS messages at rest for %s:%s.", var.application, var.environment)
 *   tags = {
 *     Application = var.application
 *     Environment = var.environment
 *     Automation  = "Terraform"
 *   }
 * }
 * ```
 *
 * ## Terraform Version
 *
 * Terraform 0.12. Pin module version to ~> 1.0.0 . Submit pull-requests to master branch.
 *
 * Terraform 0.11 is not supported.
 *
 * ## License
 *
 * This project constitutes a work of the United States Government and is not subject to domestic copyright protection under 17 USC § 105.  However, because the project utilizes code licensed from contributors and other third parties, it therefore is licensed under the MIT License.  See LICENSE file for more information.
 */

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_partition" "current" {}

# The following websites were useful guides when creating the policy document.
# https://stackoverflow.com/questions/56397828/aws-cloudwatch-can-not-publish-to-sns-topic-with-sse
# https://docs.aws.amazon.com/sns/latest/dg/sns-key-management.html
# https://aws.amazon.com/blogs/compute/encrypting-messages-published-to-amazon-sns-with-aws-kms/

data "aws_iam_policy_document" "sns" {
  policy_id = "key-policy-sns"
  statement {
    sid = "Enable IAM User Permissions"
    actions = [
      "kms:*",
    ]
    effect = "Allow"
    principals {
      type = "AWS"
      identifiers = [
        format(
          "arn:%s:iam::%s:root",
          data.aws_partition.current.partition,
          data.aws_caller_identity.current.account_id
        )
      ]
    }
    resources = ["*"]
  }
  statement {
    sid = "Allow CloudWatch"
    actions = [
      "kms:GenerateDataKey*",
      "kms:Decrypt"
    ]
    effect = "Allow"
    principals {
      type = "Service"
      identifiers = [
        "cloudwatch.amazonaws.com"
      ]
    }
    resources = ["*"]
  }
  statement {
    sid = "Allow CloudWatch Events"
    actions = [
      "kms:GenerateDataKey*",
      "kms:Decrypt"
    ]
    effect = "Allow"
    principals {
      type = "Service"
      identifiers = [
        "events.amazonaws.com"
      ]
    }
    resources = ["*"]
  }
  statement {
    sid = "Allow SNS"
    actions = [
      "kms:GenerateDataKey*",
      "kms:Decrypt"
    ]
    effect = "Allow"
    principals {
      type = "Service"
      identifiers = [
        "sns.amazonaws.com"
      ]
    }
    resources = ["*"]
  }
}

resource "aws_kms_key" "sns" {
  description             = var.description
  deletion_window_in_days = var.key_deletion_window_in_days
  enable_key_rotation     = "true"
  policy                  = data.aws_iam_policy_document.sns.json
  tags                    = var.tags
}

resource "aws_kms_alias" "sns" {
  name          = var.name
  target_key_id = aws_kms_key.sns.key_id
}
