variable "project" {
  type = string
}

variable "aliases" {
  type = list(string)
  default = []
  description = "Optional List of alternate domain names (CNAMEs) for the cloudfront distribution"
}

variable "s3_bucket_regional_domain_name" {
  type = string
  description = "The regional S3 endpoint of the bucket, e.g. bilalsfirstbucket.s3.ap-south-1.amazonaws.com"
}

variable "price_class" {
  type = string
  default = "PriceClass_100"
}

variable "tags" {
  type = map(string)
  default = {}
}