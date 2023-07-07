# output "name" {
#   description = "ECS cluster name"
#   value       = module.ecs_cluster.name
# }

# output "id" {
#   description = "ECS cluster id"
#   value       = module.ecs_cluster.id
# }

# output "arn" {
#   description = "ECS cluster arn"
#   value       = module.ecs_cluster.arn
# }

# output "container_definition_json" {
#   value       = one(module.container_definition.*.json_map_encoded_list)
#   description = "JSON encoded list of container definitions for use with other terraform resources such as aws_ecs_task_definition"
# }

# output "container_definition_json_map" {
#   value       = one(module.container_definition.*.json_map_encoded)
#   description = "JSON encoded container definitions for use with other terraform resources such as aws_ecs_task_definition"
# }
