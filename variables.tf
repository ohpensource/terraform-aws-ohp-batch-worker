variable "service_name" {
  description = "Service name prefix to apply to resources"
}

variable "region" { default = "eu-west-1" }

variable "batch_type_table_name" {}

variable "batch_type_id" {
  description = "Batch type Id. Must be unique, otherwise configuration will be overridden."
  type        = number
}

variable "batch_name" {
  description = "Batch name"
  type        = string
}

variable "batch_schedule_expression" {
  description = "Batch schedule expression in cron format compatible with AWS Cloudwatch (https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html#CronExpressions)"
  type        = string
}

variable "batch_worker_queue_name" {
  description = "Batch worker queue"
  type        = string
}

variable "batch_worker_count" {
  description = "Number of parallel batch workers to run."
  type        = number
}

variable "batch_worker_polling_interval" {
  description = "Interval (in seconds) for polling batch job status. Default is 60"
  default     = 60
  type        = number
}

variable "batch_run_attempts" {
  description = "Number of attempts to run batch worker container. Defaults to 1, specify greater values for immediate retries in case of failure."
  default     = 1
  type        = number
}

variable "container_image" {
  description = "Worker container image"
  default     = ""
}

variable "container_vcpu" {
  description = "Number of vcpus for Fargate container. Can be fractional (e.g 0.5). Default is 0.5. More info at https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-cpu-memory-error.html"
  default     = "0.5"
}

variable "container_memory" {
  description = "Amount of RAM for Fargate container. Default is 1 GB. More info at https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-cpu-memory-error.html"
  default     = "1024"
}

variable "container_environment_variables" {
  type = list(object({
    name  = string
    value = string
  }))
  description = "The environment variables to pass to the container. This is a list of maps. https://docs.aws.amazon.com/batch/latest/APIReference/API_KeyValuePair.html"
  default     = []
}

variable "job_role_policy" {
  description = "JSON encoded job role policy"
  type        = string
}

variable "tags" {
  type        = map(any)
  description = "(Required) Map of tags to apply to repository"
}
