terraform {
  backend "s3" {}
}

provider "aws" {
  region = var.aws_region
}

data "aws_caller_identity" "current" {}

module "api_gateway" {
  source       = "./api_gateway"
  project_name = var.project_name
  stage_name   = var.stage_name
}

module "cognito" {
  source       = "./cognito"
  url          = module.api_gateway.flask_url
  project_name = var.project_name
}

module "s3_buckets" {
  source       = "./s3_buckets"
  project_name = var.project_name
  aws_region   = var.aws_region
}

module "flask_app" {
  source         = "./flask_app"
  project_name   = var.project_name
  aws_account_id = data.aws_caller_identity.current.account_id
  aws_region     = var.aws_region
}
