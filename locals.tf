locals {
  env_variables        = concat(var.container_environment_variables, [{ name = "SERVICE_NAME", value = var.service_name }])
  env_vars_keys        = [for m in local.env_variables : lookup(m, "name")]
  env_vars_values      = [for m in local.env_variables : lookup(m, "value")]
  env_vars_as_map      = zipmap(local.env_vars_keys, local.env_vars_values)
  sorted_env_vars_keys = sort(local.env_vars_keys)

  sorted_environment_vars = [
    for key in local.sorted_env_vars_keys :
    {
      name  = key
      value = lookup(local.env_vars_as_map, key)
    }
  ]
  final_environment_vars = length(local.sorted_environment_vars) > 0 ? local.sorted_environment_vars : null

  container_environment_variables = local.final_environment_vars

  container_properties = {
    command = []
    image   = var.container_image
    fargatePlatformConfiguration = {
      platformVersion = "LATEST"
    }
    resourceRequirements = [
      {
        type  = "VCPU"
        value = var.container_vcpu
      },
      {
        type  = "MEMORY"
        value = var.container_memory
      },
    ]
    environment      = local.final_environment_vars
    executionRoleArn = aws_iam_role.batch_ecs_task_execution_role.arn
    jobRoleArn       = aws_iam_role.batch_ecs_task_job_role.arn
  }

  json_container_property_map = jsonencode(local.container_properties)
}