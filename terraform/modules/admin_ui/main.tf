/**
 * Admin UI Module
 * 
 * This module creates the CloudFront distribution and S3 bucket for hosting the admin UI.
 * These resources allow administrators to manage tenants and users.
 *
 * Resources to be created:
 * - S3 bucket for static website content
 * - CloudFront Origin Access Control
 * - S3 bucket policy for CloudFront access
 * - CloudFront distribution
 */

module "admin_ui_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 4.6.0"

  bucket = "${lower(data.aws_default_tags.this.tags.Workshop)}-admin-ui-bucket"
  
  # S3 ownership controls
  control_object_ownership = true
  object_ownership         = "BucketOwnerEnforced"

  # Block public access
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  # Enable server-side encryption
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }

  # Versioning for content management
  versioning = {
    enabled = true
  }

  tags = {
    Service = "admin-ui"
  }
}

# CloudFront distribution for admin UI using terraform-aws-modules/cloudfront
module "admin_ui_cloudfront" {
  source  = "terraform-aws-modules/cloudfront/aws"
  version = "~> 4.1.0"

  # aliases = var.admin_ui_domain_names

  comment             = "Admin UI CloudFront Distribution"
  enabled             = true
  price_class         = "PriceClass_100"
  retain_on_delete    = false
  wait_for_deployment = false
  default_root_object = "index.html"

  # Origin configuration for S3 with Origin Access Control
  create_origin_access_control = true
  origin_access_control = {
    admin_ui_s3 = {
      description      = "Admin UI CloudFront OAC"
      origin_type      = "s3"
      signing_behavior = "always"
      signing_protocol = "sigv4"
    }
  }

  origin = {
    admin_ui_s3 = {
      domain_name           = module.admin_ui_bucket.s3_bucket_bucket_regional_domain_name
      origin_access_control = "admin_ui_s3"
    }
  }

  # Default cache behavior
  default_cache_behavior = {
    target_origin_id       = "admin_ui_s3"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD", "OPTIONS"]

    min_ttl     = 0
    default_ttl = 3600
    max_ttl     = 86400
  }

  # Custom error responses for SPA routing
  custom_error_response = [
    {
      error_code         = 403
      response_code      = 200
      response_page_path = "/index.html"
    },
    {
      error_code         = 404
      response_code      = 200
      response_page_path = "/index.html"
    }
  ]

  # Restrictions
  geo_restriction = {
    restriction_type = "none"
  }

  # SSL Certificate
  viewer_certificate = {
    cloudfront_default_certificate = true
  }

  tags = {
    Service     = "admin-ui"
  }
}

# Update bucket policy to allow CloudFront access using Origin Access Control
resource "aws_s3_bucket_policy" "admin_ui_bucket_policy" {
  bucket = module.admin_ui_bucket.s3_bucket_id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowCloudFrontOAC"
        Effect    = "Allow"
        Principal = {
          Service = "cloudfront.amazonaws.com"
        }
        Action   = "s3:GetObject"
        Resource = "${module.admin_ui_bucket.s3_bucket_arn}/*"
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = module.admin_ui_cloudfront.cloudfront_distribution_arn
          }
        }
      }
    ]
  })
}
