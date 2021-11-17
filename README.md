# Terraform Module - Batch Worker Resources

[![license](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

![GitHub Workflow Status](https://img.shields.io/github/workflow/status/ohpensource/terraform-aws-ohp-batch-worker/continuous-delivery)

![GitHub tag (latest by date)](https://img.shields.io/github/v/tag/ohpensource/terraform-aws-ohp-batch-worker)

## Maintainer

New Stack / Investments

## Author

* Serhii Daletskyi

## Documentation

Describe how to use your module here.
[confluence](https://ohpendev.atlassian.net/wiki/spaces/CCE/pages/2062320795/Terraform+Modules)

## Usage

<!--- BEGIN_TF_DOCS --->
### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0 |

### Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.0 |

### Modules

No modules.

### Resources

| Name | Type |
|------|------|
| [aws_batch_job_definition.batch_job_definition](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/batch_job_definition) | resource |
| [aws_dynamodb_table_item.batch_type_record](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table_item) | resource |
| [aws_iam_role.batch_ecs_task_execution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.batch_ecs_task_job_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.batch_ecs_task_job_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.batch_ecs_task_execution_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.ecs_task_execution_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_batch_name"></a> [batch\_name](#input\_batch\_name) | Batch name | `string` | n/a | yes |
| <a name="input_batch_run_attempts"></a> [batch\_run\_attempts](#input\_batch\_run\_attempts) | Number of attempts to run batch worker container. Defaults to 1, specify greater values for immediate retries in case of failure. | `number` | `1` | no |
| <a name="input_batch_schedule_expression"></a> [batch\_schedule\_expression](#input\_batch\_schedule\_expression) | Batch schedule expression in cron format compatible with AWS Cloudwatch (https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html#CronExpressions) | `string` | n/a | yes |
| <a name="input_batch_type_id"></a> [batch\_type\_id](#input\_batch\_type\_id) | Batch type Id. Must be unique, otherwise configuration will be overridden. | `number` | n/a | yes |
| <a name="input_batch_type_table_name"></a> [batch\_type\_table\_name](#input\_batch\_type\_table\_name) | n/a | `any` | n/a | yes |
| <a name="input_batch_worker_count"></a> [batch\_worker\_count](#input\_batch\_worker\_count) | Number of parallel batch workers to run. | `number` | n/a | yes |
| <a name="input_batch_worker_polling_interval"></a> [batch\_worker\_polling\_interval](#input\_batch\_worker\_polling\_interval) | Interval (in seconds) for polling batch job status. Default is 60 | `number` | `60` | no |
| <a name="input_batch_worker_queue_name"></a> [batch\_worker\_queue\_name](#input\_batch\_worker\_queue\_name) | Batch worker queue | `string` | n/a | yes |
| <a name="input_container_environment_variables"></a> [container\_environment\_variables](#input\_container\_environment\_variables) | The environment variables to pass to the container. This is a list of maps. https://docs.aws.amazon.com/batch/latest/APIReference/API_KeyValuePair.html | <pre>list(object({<br>    name  = string<br>    value = string<br>  }))</pre> | `[]` | no |
| <a name="input_container_image"></a> [container\_image](#input\_container\_image) | Worker container image | `string` | `""` | no |
| <a name="input_container_memory"></a> [container\_memory](#input\_container\_memory) | Amount of RAM for Fargate container. Default is 1 GB. More info at https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-cpu-memory-error.html | `string` | `"1024"` | no |
| <a name="input_container_vcpu"></a> [container\_vcpu](#input\_container\_vcpu) | Number of vcpus for Fargate container. Can be fractional (e.g 0.5). Default is 0.5. More info at https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-cpu-memory-error.html | `string` | `"0.5"` | no |
| <a name="input_job_role_policy"></a> [job\_role\_policy](#input\_job\_role\_policy) | JSON encoded job role policy | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"eu-west-1"` | no |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | Service name prefix to apply to resources | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Required) Map of tags to apply to repository | `map(any)` | n/a | yes |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_container_environment_variables"></a> [container\_environment\_variables](#output\_container\_environment\_variables) | n/a |

<!--- END_TF_DOCS --->