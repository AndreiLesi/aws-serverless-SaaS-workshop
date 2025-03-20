  output "admin_bucket" {
  description = "The name of the bucket for uploading the Admin Management site to"
  value       = module.admin_ui_bucket.s3_bucket_id
}

output "admin_app_site" {
  description = "The CloudFront domain name for Admin Management site"
  value       = module.admin_ui_cloudfront.cloudfront_distribution_domain_name
}