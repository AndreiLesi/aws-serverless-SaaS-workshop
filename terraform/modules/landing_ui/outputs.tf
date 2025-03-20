  output "landing_app_bucket" {
  description = "The name of the bucket for uploading the Landing site to"
  value       = module.landing_ui_bucket.s3_bucket_id
}

output "landing_app_site" {
  description = "The domain name of the CloudFront distribution for Landing site"
  value       = module.landing_ui_cloudfront.cloudfront_distribution_domain_name
}