code .

<!-- BEGIN_TF_DOCS -->




## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_assign_public_ip"></a> [assign\_public\_ip](#input\_assign\_public\_ip) | Whether to assign a public IP to the container | `bool` | `false` | no |
| <a name="input_cloudwatch_retention_days"></a> [cloudwatch\_retention\_days](#input\_cloudwatch\_retention\_days) | The number of days to retain logs in CloudWatch | `number` | `7` | no |
| <a name="input_cpu"></a> [cpu](#input\_cpu) | The CPU value to assign to the container (vCPU) | `number` | `256` | no |
| <a name="input_cpu_architecture"></a> [cpu\_architecture](#input\_cpu\_architecture) | The CPU architecture to use for the container. Either X86\_64 or ARM64. | `string` | `"X86_64"` | no |
| <a name="input_ecs_cluster_id"></a> [ecs\_cluster\_id](#input\_ecs\_cluster\_id) | The ID of the ECS cluster | `string` | n/a | yes |
| <a name="input_memory"></a> [memory](#input\_memory) | The memory value to assign to the container (MiB) | `number` | `512` | no |
| <a name="input_name"></a> [name](#input\_name) | A name for the Tailscale subnet router | `string` | n/a | yes |
| <a name="input_recorder_version"></a> [recorder\_version](#input\_recorder\_version) | The version of the Tailscale session recorder to use | `string` | `"stable"` | no |
| <a name="input_s3_bucket_name"></a> [s3\_bucket\_name](#input\_s3\_bucket\_name) | The name of the S3 bucket to use for storing recordings | `string` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | The subnet IDs to use for the ECS task | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to the resources | `map(string)` | `{}` | no |
| <a name="input_tailscale_auth_key"></a> [tailscale\_auth\_key](#input\_tailscale\_auth\_key) | The auth key for the session recorder | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The VPC ID to use for the ECS task | `string` | n/a | yes |

## Modules

No modules.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloudwatch_log_group_name"></a> [cloudwatch\_log\_group\_name](#output\_cloudwatch\_log\_group\_name) | n/a |
| <a name="output_task_definition_arn"></a> [task\_definition\_arn](#output\_task\_definition\_arn) | n/a |
| <a name="output_task_definition_family"></a> [task\_definition\_family](#output\_task\_definition\_family) | n/a |
| <a name="output_task_definition_revision"></a> [task\_definition\_revision](#output\_task\_definition\_revision) | n/a |
| <a name="output_task_exec_role_arn"></a> [task\_exec\_role\_arn](#output\_task\_exec\_role\_arn) | n/a |
| <a name="output_task_exec_role_name"></a> [task\_exec\_role\_name](#output\_task\_exec\_role\_name) | n/a |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.30 |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.30 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.tailscale](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_ecs_service.tailscale](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.tailscale](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_iam_policy.ecs_task_logs_tailscale](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.s3_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.ecs_task_tailscale](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.exec_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.task_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.ecs_task_logs_tailscale](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.exec_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.s3_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_security_group.tailscale](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_iam_policy_document.ecs_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ecs_task_logs_tailscale](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.s3_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_s3_bucket.bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/s3_bucket) | data source |
<!-- END_TF_DOCS -->
