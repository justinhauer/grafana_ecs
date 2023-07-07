

module "alb" {
  source             = "cloudposse/alb/aws"
  version            = "1.9.0"
  vpc_id             = data.aws_vpc.default.id
  security_group_ids = [aws_security_group.alb_sg.id, aws_security_group.ecs_sg.id]
  subnet_ids         = ["", "", ""]
  # internal                          = var.internal
  https_enabled                     = true
  http_redirect                     = false
  access_logs_enabled               = false
  cross_zone_load_balancing_enabled = false
  http2_enabled                     = false
  # idle_timeout                      = var.idle_timeout
  #   ip_address_type                   = var.ip_address_type
  deletion_protection_enabled = false
  #   deregistration_delay              = var.deregistration_delay
  health_check_path = "/api/health"
  #   health_check_timeout              = var.health_check_timeout
  # health_check_healthy_threshold    = var.health_check_healthy_threshold
  # health_check_unhealthy_threshold  = var.health_check_unhealthy_threshold
  # health_check_interval             = var.health_check_interval
  # health_check_matcher              = var.health_check_matcher
  target_group_port        = 3000
  target_group_target_type = "ip"
  #   stickiness                        = var.stickiness
  certificate_arn = module.acm_request_certificate.arn
  #   alb_access_logs_s3_bucket_force_destroy         = var.alb_access_logs_s3_bucket_force_destroy
  #   alb_access_logs_s3_bucket_force_destroy_enabled = var.alb_access_logs_s3_bucket_force_destroy_enabled

  context = module.this.context
}

module "alb_ingress" {
  source              = "cloudposse/alb-ingress/aws"
  version             = "0.26.0"
  vpc_id              = data.aws_vpc.default.id
  authentication_type = ""
  # unauthenticated_priority      = var.unauthenticated_priority
  # unauthenticated_paths         = var.unauthenticated_paths
  # slow_start                    = var.slow_start
  stickiness_enabled           = false
  default_target_group_enabled = false
  target_group_arn             = module.alb.default_target_group_arn
  # unauthenticated_listener_arns = [module.alb.http_listener_arn]

  context = module.this.context
}