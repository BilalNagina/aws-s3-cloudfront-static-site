output "cloudfront_domain" {
  value = module.cloudfront.domain_name
}

output "s3_bucket" {
  value = module.s3_site.bucket_id
}