  output "application_app_bucket" {
  description = "The name of the bucket for uploading the Application site to"
  value       = module.application_ui_bucket.s3_bucket_id
}

output "application_app_site" {
  description = "The domain name of the CloudFront distribution for Application site"
  value       = module.application_ui_cloudfront.cloudfront_distribution_domain_name
}