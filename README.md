<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Usage

Creates a KMS Key for use with SNS.

```hcl
module "sns_kms_key" {
  source = "dod-iac/sns-kms-key/aws"

  name = format("alias/app-%s-sns-%s", var.application, var.environment)
  description = format("A SNS key used to encrypt SNS messages at rest for %s:%s.", var.application, var.environment)
  tags = {
    Application = var.application
    Environment = var.environment
    Automation  = "Terraform"
  }
}
```

## Terraform Version

Terraform 0.12. Pin module version to ~> 1.0.0 . Submit pull-requests to master branch.

Terraform 0.11 is not supported.

## License

This project constitutes a work of the United States Government and is not subject to domestic copyright protection under 17 USC § 105.  However, because the project utilizes code licensed from contributors and other third parties, it therefore is licensed under the MIT License.  See LICENSE file for more information.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| aws | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_kms_alias.sns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.sns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.sns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| allow\_services | The list of services that will be allowed kms GenerateDataKey and Decrypt IAM permissions. | `list(string)` | <pre>[<br>  "cloudwatch.amazonaws.com",<br>  "events.amazonaws.com"<br>]</pre> | no |
| description | n/a | `string` | `"A KMS key used to encrypt SNS messages at-rest."` | no |
| key\_deletion\_window\_in\_days | Duration in days after which the key is deleted after destruction of the resource, must be between 7 and 30 days. | `string` | `30` | no |
| name | The display name of the alias. The name must start with the word "alias" followed by a forward slash (alias/). | `string` | `"alias/sns"` | no |
| tags | Tags applied to the KMS key. | `map(string)` | <pre>{<br>  "Automation": "Terraform"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| aws\_kms\_alias\_arn | The Amazon Resource Name (ARN) of the key alias. |
| aws\_kms\_alias\_name | The display name of the alias. |
| aws\_kms\_key\_arn | The Amazon Resource Name (ARN) of the key. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->