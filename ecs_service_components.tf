module "container_definition" {
  source                   = "cloudposse/ecs-container-definition/aws"
  version                  = "0.60.0"
  container_name           = "grafana"
  container_image          = "grafana/grafana:10.0.0"
  container_memory         = 512
  container_cpu            = 256
  port_mappings            = var.container_port_mappings
  essential                = true
  readonly_root_filesystem = false
  log_configuration = {
    logDriver = "awslogs"
    options = {
      "awslogs-stream-prefix" = "ecs"
      "awslogs-group"         = "/ecs/grafana"
      "awslogs-region"        = "us-east-2"
    }
  }
  map_environment = {
    "GF_SECURITY_DISABLE_INITIAL_ADMIN_CREATION" = false
    "GF_SECURITY_ADMIN_USER"                     = ""
    "GF_SECURITY_ADMIN_PASSWORD"                 = ""
    # "GF_AUTH_SIGV4_AUTH_ENABLED"                 = false
    "GF_PATHS_PLUGINS" = "/etc/grafana/provisioning/plugins"
    "GF_LOG_LEVEL"     = "INFO"

    // Alerting
    # "GF_UNIFIED_ALERTING_HA_LISTENING_ADDRESS" = ""
    # "GF_UNIFIED_ALERTING_HA_PEERS"             = ""
    # "GF_UNIFIED_ALERTING_HA_ADVERTISE_ADDRESS" = ""
    # "GF_UNIFIED_ALERTING_ENABLED"              = ""

    #   // DATABASE
    "GF_DATABASE_TYPE"     = "mysql"
    "GF_DATABASE_HOST"     = "${module.rds_instance.instance_endpoint}"
    "GF_DATABASE_NAME"     = ""
    "GF_DATABASE_USER"     = ""
    "GF_DATABASE_SSL_MODE" = "false"
    "GF_DATABASE_PASSWORD" = ""


    #   // EMAIL
    #   "GF_SMTP_ENABLED" = ""
    #   "GF_SMTP_HOST"    = ""
  }

  # map_secrets = {
  #   "GF_DATABASE_PASSWORD" = ""
  # }
}

module "cloudwatch_logs" {
  source            = "cloudposse/cloudwatch-logs/aws"
  enabled           = true
  version           = "0.6.7"
  retention_in_days = 1
  name              = "/ecs/grafana"
  principals = {
    "Service" : [
      "ecs.amazonaws.com"
    ]
  }
}


module "ecs_alb_service_task" {
  source = "cloudposse/ecs-alb-service-task/aws"
  # Cloud Posse recommends pinning every module to a specific version
  version   = "0.70.0"
  namespace = ""
  # stage                              = var.stage
  name = "grafana"
  # attributes                         = var.attributes
  # delimiter                          = var.delimiter
  alb_security_group        = aws_security_group.alb_sg.id
  container_definition_json = one(module.container_definition.*.json_map_encoded_list)
  ecs_cluster_arn           = module.ecs_cluster.arn
  launch_type               = "FARGATE"
  vpc_id                    = data.aws_vpc.default.id
  security_group_ids        = [aws_security_group.alb_sg.id, aws_security_group.ecs_sg.id]
  subnet_ids                = ["", "", ""]
  ecs_load_balancers = [{
    container_name   = "grafana"
    container_port   = "3000"
    target_group_arn = module.alb.default_target_group_arn
    elb_name         = null
  }]

  # tags                               = var.tags
  ignore_changes_task_definition = true
  # network_mode                       = var.network_mode
  assign_public_ip = "true"
  # propagate_tags                     = var.propagate_tags
  health_check_grace_period_seconds = 120
  # deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent
  # deployment_maximum_percent         = var.deployment_maximum_percent
  deployment_controller_type = "ECS"
  desired_count              = 0
  task_memory                = 512
  task_cpu                   = 256
  redeploy_on_apply          = true
  force_new_deployment       = false
}

