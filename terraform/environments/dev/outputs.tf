# Admin Site URL
output "admin_site_url" {
  value = module.admin_ui.admin_app_site
}

# Admin Site Bucket
output "admin_site_bucket" {
  value = module.admin_ui.admin_bucket
}

# Landing Site URL
output "landing_site_url" {
  value = module.landing_ui.landing_app_site
}

# Landing Site Bucket
output "landing_site_bucket" {
  value = module.landing_ui.landing_app_bucket
}

# Application Site URL
output "application_site_url" {
  value = module.application_ui.application_app_site
}

# Application Site Bucket
output "application_site_bucket" {
  value = module.application_ui.application_app_bucket
}

# Admin API Gateway URL
output "admin_api_gateway_url" {
  value = module.admin_api_gateway.api_gateway_invoke_url
}

# Admin User Pool ID
output "admin_user_pool_id" {
  value = module.cognito_user_authentication.cognito_operation_users_user_pool_id
}

# Admin App Client ID
output "admin_app_client_id" {
  value = module.cognito_user_authentication.cognito_operation_users_user_pool_client_id
}

# Tenant API Gateway
output "tenant_api_gateway_url" {
  value = module.tenant_api_gateway.api_gateway_invoke_url
}

# Tenant User Pool ID
output "tenant_user_pool_id" {
  value = module.cognito_user_authentication.cognito_user_pool_id
}

# Tenant App Client ID
output "tenant_app_client_id" {
  value = module.cognito_user_authentication.cognito_user_pool_client_id
}