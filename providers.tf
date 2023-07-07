terraform {
  required_version = ">= 1.4.6"

  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "2.4.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "= 4.67.0"
    }
    grafana = {
      source  = "grafana/grafana"
      version = "= 1.41.0"
    }
  }

}
provider "aws" {
  region = var.region
}

provider "grafana" {
  url  = "https://dashboards.wildlifecams.net/"
  auth = "justin1:Deercams1!"
}
