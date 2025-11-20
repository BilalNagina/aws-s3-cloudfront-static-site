variable "region" {
  type = string
  default = "ap-south-1"
  description = "Primary AWS Region for resources"
}

variable "bucket_name" {
  type = string
  description = "Globally unique S3 bucket name for the static site. Example: bilalsfirstbucket"
}

variable "project" {
  type = string
  default = "static-site"
}

variable "aliases" {
  type = list(string)
  default = []
  description = "Optional List of alternate domain names (CNAMEs) for the cloudfront distribution"
}

variable "price_class" {
  type = string
  default = "PriceClass_100"
}

variable "tags" {
  type = map(string)
  default = { Owner = "bilal" }
  description = "Tags applied to resources for cost allocation and management"
}