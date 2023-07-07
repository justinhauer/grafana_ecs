module "ecs_cluster" {
  source    = "cloudposse/ecs-cluster/aws"
  version   = "0.3.1"
  namespace = ""
  name      = ""

  container_insights_enabled      = false
  capacity_providers_fargate_spot = true
}

module "label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  namespace = ""
  name      = ""
}