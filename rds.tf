module "rds_instance" {
  source  = "cloudposse/rds/aws"
  version = "0.43.0"
  #   namespace          = var.namespace
  #   stage              = var.stage
  name                = ""
  database_name       = ""
  database_user       = ""
  database_password   = ""
  database_port       = 3306
  multi_az            = false
  storage_type        = "standard"
  allocated_storage   = 5
  storage_encrypted   = false
  engine              = "mysql"
  engine_version      = "8.0.33"
  instance_class      = "db.t4g.micro"
  db_parameter_group  = "mysql8.0"
  publicly_accessible = false
  allowed_cidr_blocks = [data.aws_vpc.default.cidr_block]
  vpc_id              = data.aws_vpc.default.id
  subnet_ids          = [""]
  security_group_ids  = [""]
  apply_immediately   = true

}

# resource "aws_security_group" "ecs_rds_sg" {
#   name        = "ecs-rds-sg"
#   description = "Allow inbound access to RDS from ECS"
#   vpc_id      = data.aws_vpc.default.id
# }

# resource "aws_security_group_rule" "ecs_to_rds" {
#   security_group_id = aws_security_group.ecs_rds_sg.id
#   type              = "ingress"
#   from_port         = 3306  # Adjust this to the appropriate port for your RDS instance
#   to_port           = 3306  # Adjust this to the appropriate port for your RDS instance
#   protocol          = "tcp"
#   source_security_group_id = aws_security_group.ecs_sg.id
# }

# output "instance_id" {
#   value       = module.rds_instance.instance_id
#   description = "ID of the instance"
# }

# output "instance_address" {
#   value       = module.rds_instance.instance_address
#   description = "Address of the instance"
# }

# output "instance_endpoint" {
#   value       = module.rds_instance.instance_endpoint
#   description = "DNS Endpoint of the instance"
# }

# output "subnet_group_id" {
#   value       = module.rds_instance.subnet_group_id
#   description = "ID of the Subnet Group"
# }

# output "security_group_id" {
#   value       = module.rds_instance.security_group_id
#   description = "ID of the Security Group"
# }

# output "parameter_group_id" {
#   value       = module.rds_instance.parameter_group_id
#   description = "ID of the Parameter Group"
# }

# output "option_group_id" {
#   value       = module.rds_instance.option_group_id
#   description = "ID of the Option Group"
# }

# output "hostname" {
#   value       = module.rds_instance.hostname
#   description = "DNS host name of the instance"
# }

# output "public_subnet_cidrs" {
#   value = module.subnets.public_subnet_cidrs
# }

# output "private_subnet_cidrs" {
#   value = module.subnets.private_subnet_cidrs
# }

# output "vpc_cidr" {
#   value = module.vpc.vpc_cidr_block
# }

# module "rds_cluster" {
#   source = "cloudposse/rds-cluster/aws"
#   version = "1.5.0"
#   engine                               = var.engine
#   engine_mode                          = var.engine_mode
#   cluster_family                       = var.cluster_family
#   cluster_size                         = var.cluster_size
#   admin_user                           = var.admin_user
#   admin_password                       = "gfdbpassword"
#   db_name                              = var.db_name
#   instance_type                        = var.instance_type
#   vpc_id                               = module.vpc.vpc_id
#   subnets                              = module.subnets.private_subnet_ids
#   security_groups                      = [module.vpc.vpc_default_security_group_id]
#   deletion_protection                  = var.deletion_protection
#   autoscaling_enabled                  = var.autoscaling_enabled
#   storage_type                         = var.storage_type
#   iops                                 = var.iops
#   allocated_storage                    = var.allocated_storage
#   intra_security_group_traffic_enabled = var.intra_security_group_traffic_enabled

#   context = module.this.context
# }

# output "database_name" {
#   value       = module.rds_cluster.database_name
#   description = "Database name"
# }

# output "cluster_identifier" {
#   value       = module.rds_cluster.cluster_identifier
#   description = "Cluster Identifier"
# }

# output "arn" {
#   value       = module.rds_cluster.arn
#   description = "Amazon Resource Name (ARN) of the cluster"
# }

# output "endpoint" {
#   value       = module.rds_cluster.endpoint
#   description = "The DNS address of the RDS instance"
# }

# output "reader_endpoint" {
#   value       = module.rds_cluster.reader_endpoint
#   description = "A read-only endpoint for the Aurora cluster, automatically load-balanced across replicas"
# }

# output "master_host" {
#   value       = module.rds_cluster.master_host
#   description = "DB Master hostname"
# }

# output "replicas_host" {
#   value       = module.rds_cluster.replicas_host
#   description = "Replicas hostname"
# }

# output "dbi_resource_ids" {
#   value       = module.rds_cluster.dbi_resource_ids
#   description = "List of the region-unique, immutable identifiers for the DB instances in the cluster"
# }

# output "cluster_resource_id" {
#   value       = module.rds_cluster.cluster_resource_id
#   description = "The region-unique, immutable identifie of the cluster"
# }

# output "public_subnet_cidrs" {
#   value       = module.subnets.public_subnet_cidrs
#   description = "Public subnet CIDR blocks"
# }

# output "private_subnet_cidrs" {
#   value       = module.subnets.private_subnet_cidrs
#   description = "Private subnet CIDR blocks"
# }

# output "vpc_cidr" {
#   value       = module.vpc.vpc_cidr_block
#   description = "VPC CIDR"
# }

# output "security_group_id" {
#   value       = module.rds_cluster.security_group_id
#   description = "Security Group ID"
# }

# output "security_group_arn" {
#   value       = module.rds_cluster.security_group_arn
#   description = "Security Group ARN"
# }

# output "security_group_name" {
#   value       = module.rds_cluster.security_group_name
#   description = "Security Group name"
# }