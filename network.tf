
# module "subnets" {
#   source               = "cloudposse/dynamic-subnets/aws"
#   version              = "2.3.0"
#   context              = module.this.context
#   availability_zones   = var.availability_zones
#   vpc_id               = data.aws_vpc.default.id
#   igw_id               = [data.aws_internet_gateway.default.internet_gateway_id]
#   ipv4_cidr_block      = [data.aws_vpc.default.cidr_block]
#   nat_gateway_enabled  = false
#   nat_instance_enabled = false
#   tags = {
#     Name = "cedar_hill_subnet"
#     App  = "cedar_hill_grafana"
#   }
# }

resource "aws_security_group" "alb_sg" {
  name        = "alb_sg"
  description = "Security group for the ALB"
  vpc_id      = data.aws_vpc.default.id
  ingress {
    description = "Allow HTTPS from the internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb_sg"
    App  = "cedar_hill_grafana"
  }
}

resource "aws_security_group" "ecs_sg" {
  name        = "ecs_sg"
  description = "Security group for the ECS tasks"
  vpc_id      = data.aws_vpc.default.id
  ingress {
    description     = "Allow Grafana traffic from ALB"
    from_port       = 3000
    to_port         = 3000
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ecs_sg"
    App  = "cedar_hill_grafana"
  }
}


data "aws_route53_zone" "wildlifecams" {
  name = "wildlifecams.net"
}

module "route53_alias" {
  source          = "cloudposse/route53-alias/aws"
  version         = "0.13.0"
  aliases         = ["dashboards.wildlifecams.net"]
  parent_zone_id  = data.aws_route53_zone.wildlifecams.zone_id
  target_zone_id  = module.alb.alb_zone_id
  target_dns_name = module.alb.alb_dns_name
}
// for cdn
# module "route53_alias" {
#   source          = "cloudposse/route53-alias/aws"
#   version         = "0.13.0"
#   aliases         = ["dashboards.wildlifecams.net"]
#   parent_zone_id  = data.aws_route53_zone.wildlifecams.zone_id
#   target_zone_id  = module.cdn.cf_hosted_zone_id
#   target_dns_name = module.cdn.cf_domain_name
# }


// Doesn't work with the cloudposse module
# module "cdn" {
#   source = "cloudposse/cloudfront-cdn/aws"
#   # Cloud Posse recommends pinning every module to a specific version
#   version             = "0.26.0"
#   name                = "wildlifecams"
#   aliases             = ["www.dashboards.wildlifecams.net"]
#   origin_domain_name  = module.alb.alb_dns_name
#   parent_zone_name    = data.aws_route53_zone.wildlifecams.name
#   acm_certificate_arn = module.acm_request_certificate.arn
#   logging_enabled     = false
#   context             = module.this.context
#   enabled             = true
# }

module "acm_request_certificate" {
  source                            = "cloudposse/acm-request-certificate/aws"
  version                           = "0.17.0"
  domain_name                       = data.aws_route53_zone.wildlifecams.name
  zone_id                           = data.aws_route53_zone.wildlifecams.zone_id
  validation_method                 = "DNS"
  ttl                               = "300"
  subject_alternative_names         = ["*.${data.aws_route53_zone.wildlifecams.name}"]
  process_domain_validation_options = true
  wait_for_certificate_issued       = true
  name                              = "dashboards"
  context                           = module.this.context
}