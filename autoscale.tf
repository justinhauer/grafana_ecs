# // Scale down to 0 if ECS tasks are at 1 or greater
# resource "aws_appautoscaling_target" "grafana" {
#   max_capacity       = 1
#   min_capacity       = 0
#   resource_id        = "service/${module.ecs_cluster.name}/${module.ecs_alb_service_task.service_name}"
#   scalable_dimension = "ecs:service:DesiredCount"
#   service_namespace  = "ecs"
# }

# resource "aws_appautoscaling_scheduled_action" "grafana_scale_down" {
#   name               = "ecs"
#   service_namespace  = aws_appautoscaling_target.grafana.service_namespace
#   resource_id        = aws_appautoscaling_target.grafana.resource_id
#   scalable_dimension = aws_appautoscaling_target.grafana.scalable_dimension
#   schedule           = "cron(0 4 * * ? *)"

#   scalable_target_action {
#     # min_capacity = 0
#     max_capacity = 0
#   }
# }

# output "schedule_ecs_scale_down" {
#   value = aws_appautoscaling_scheduled_action.grafana_scale_down.arn
# }

// Scale Up
# resource "aws_appautoscaling_scheduled_action" "grafana_scale_up" {
#   name               = "ecs"
#   service_namespace  = aws_appautoscaling_target.grafana.service_namespace
#   resource_id        = aws_appautoscaling_target.grafana.resource_id
#   scalable_dimension = aws_appautoscaling_target.grafana.scalable_dimension
#   schedule           = "cron(0 15 * * ? *)"

#   scalable_target_action {
#     # min_capacity = 0
#     max_capacity = 1
#   }
# }

# output "schedule_ecs_scale_up" {
#   value = aws_appautoscaling_scheduled_action.grafana_scale_up.arn
# }