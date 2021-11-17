resource "aws_dynamodb_table_item" "batch_type_record" {
  table_name = var.batch_type_table_name
  hash_key   = "BatchTypeId"

  item = <<ITEM
    {
        "BatchTypeId": {"N": "${var.batch_type_id}"},
        "Label": {"S": "${var.batch_name}"},
        "ScheduleExpression": {"S": "${var.batch_schedule_expression}"},
        "WorkerJobDefinitionArn": {"S": "${aws_batch_job_definition.batch_job_definition.arn}"},
        "WorkerJobQueueName": {"S": "${var.batch_worker_queue_name}"},
        "WorkerCount": {"N": "${var.batch_worker_count}"},
        "PollingIntervalInSeconds": {"N": "${var.batch_worker_polling_interval}"},
        "Attempts": {"N": "${var.batch_run_attempts}"},
        "IsFloatable": {"BOOL": true },
        "RetryInterval": {"N": "5"},
        "IsRecoverable": {"BOOL": true},
        "CanRunDuringOfficeHours": {"BOOL": true },
        "AllowRecoveryDuringOfficeHours": {"BOOL": false },
        "AllowManualRecovery": {"BOOL": false }
    }
    ITEM
}

resource "aws_iam_role" "batch_ecs_task_execution_role" {
  name               = "${var.service_name}-execution-iam"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_execution_role_policy.json
  tags               = var.tags
}

resource "aws_iam_role_policy_attachment" "batch_ecs_task_execution_role_policy" {
  role       = aws_iam_role.batch_ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role" "batch_ecs_task_job_role" {
  name               = "${var.service_name}-job-iam"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_execution_role_policy.json
  tags               = var.tags
}

resource "aws_iam_role_policy" "batch_ecs_task_job_role_policy" {
  name   = "${var.service_name}-job-iam-policy"
  role   = aws_iam_role.batch_ecs_task_job_role.id
  policy = var.job_role_policy
}

resource "aws_batch_job_definition" "batch_job_definition" {
  name = "${var.service_name}-job-definition"
  type = "container"
  tags = var.tags

  platform_capabilities = [
    "FARGATE"
  ]

  container_properties = local.json_container_property_map
}