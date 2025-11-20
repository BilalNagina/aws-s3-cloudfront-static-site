terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"

}

data "aws_caller_identity" "current" {}

locals {
  s3_policy = templatefile("${path.module}/templates/s3-policy.json.tpl", {
    bucket_arn_all   = "arn:aws:s3:::${var.bucket_name}/*"
    distribution_arn = "arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/${module.cloudfront.distribution_id}"
  })
}

module "s3_site" {
  source             = "./modules/s3-site"
  bucket_name        = var.bucket_name
  bucket_policy_json = local.s3_policy
}

module "cloudfront" {
  source = "./modules/cloudfront"
  s3_bucket_regional_domain_name = "${module.s3_site.bucket_id}.s3.${var.region}.amazonaws.com"
  project                        = var.project
  aliases                        = var.aliases
  tags                           = var.tags
  price_class                    = var.price_class
}
