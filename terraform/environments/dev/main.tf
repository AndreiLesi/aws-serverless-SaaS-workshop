###################################################
# Lab 2 - Serverless SaaS Infrastructure Deployment
###################################################

# Tenant Details DynamoDB Table - Stores tenant configuration and metadata
module "tenant_details_db" {
  source = "../../modules/tenant_details_db"
}

# Tenant User Mapping DynamoDB Table - Maps users to their respective tenants
module "tenant_user_mapping_db" {
  source = "../../modules/tenant_user_mapping_db"
}

# Admin UI - CloudFront distribution and S3 bucket for admin portal
module "admin_ui" {
  source = "../../modules/admin_ui"
}

# Landing UI - CloudFront distribution and S3 bucket for tenant landing page
module "landing_ui" {
  source = "../../modules/landing_ui"
}

# Cognito User Authentication - User pools and identity providers for authentication
module "cognito_user_authentication" {
  source = "../../modules/cognito_user_authentication"
  admin_callback_url = "https://${module.admin_ui.admin_app_site}"
  admin_email = "lesi.andrei@gmail.com"
  admin_user_role_name = "SystemAdmin"
  tenant_callback_url = "https://${module.landing_ui.landing_app_site}"
}

# Shared Services - Lambda functions for tenant and user management
module "shared_services" {
  source = "../../modules/shared_services"
  tenant_details_table_arn = module.tenant_details_db.tenant_details_table_arn
  tenant_user_mapping_table_arn = module.tenant_user_mapping_db.tenant_user_mapping_table_arn
  cognito_user_pool_id = module.cognito_user_authentication.cognito_user_pool_id
  cognito_user_pool_client_id = module.cognito_user_authentication.cognito_user_pool_client_id
  cognito_operation_users_user_pool_id = module.cognito_user_authentication.cognito_operation_users_user_pool_id
  cognito_operation_users_user_pool_client_id = module.cognito_user_authentication.cognito_operation_users_user_pool_client_id
}

# Admin API Gateway - API endpoints for tenant and user management operations
module "admin_api_gateway" {
  source = "../../modules/admin_api_gateway"
  register_tenant_lambda_execution_role_arn = module.shared_services.register_tenant_lambda_execution_role_arn
  tenant_management_lambda_execution_role_arn = module.shared_services.tenant_management_lambda_execution_role_arn
  register_tenant_function_invocation_arn = module.shared_services.register_tenant_function.lambda_function_invoke_arn
  register_tenant_function_name = module.shared_services.register_tenant_function.lambda_function_name
  activate_tenant_function_invocation_arn = module.shared_services.activate_tenant_function.lambda_function_invoke_arn
  activate_tenant_function_name = module.shared_services.activate_tenant_function.lambda_function_name
  get_tenants_function_invocation_arn = module.shared_services.get_tenants_function.lambda_function_invoke_arn
  get_tenants_function_name = module.shared_services.get_tenants_function.lambda_function_name
  create_tenant_function_invocation_arn = module.shared_services.create_tenant_function.lambda_function_invoke_arn
  create_tenant_function_name = module.shared_services.create_tenant_function.lambda_function_name
  get_tenant_function_invocation_arn = module.shared_services.get_tenant_function.lambda_function_invoke_arn
  get_tenant_function_name = module.shared_services.get_tenant_function.lambda_function_name
  deactivate_tenant_function_invocation_arn = module.shared_services.deactivate_tenant_function.lambda_function_invoke_arn
  deactivate_tenant_function_name = module.shared_services.deactivate_tenant_function.lambda_function_name
  update_tenant_function_invocation_arn = module.shared_services.update_tenant_function.lambda_function_invoke_arn
  update_tenant_function_name = module.shared_services.update_tenant_function.lambda_function_name
  get_users_function_invocation_arn = module.shared_services.get_users_function.lambda_function_invoke_arn
  get_users_function_name = module.shared_services.get_users_function.lambda_function_name
  get_user_function_invocation_arn = module.shared_services.get_user_function.lambda_function_invoke_arn
  get_user_function_name = module.shared_services.get_user_function.lambda_function_name
  update_user_function_invocation_arn = module.shared_services.update_user_function.lambda_function_invoke_arn
  update_user_function_name = module.shared_services.update_user_function.lambda_function_name
  disable_user_function_invocation_arn = module.shared_services.disable_user_function.lambda_function_invoke_arn
  disable_user_function_name = module.shared_services.disable_user_function.lambda_function_name
  create_tenant_admin_user_function_invocation_arn = module.shared_services.create_tenant_admin_user_function.lambda_function_invoke_arn
  create_tenant_admin_user_function_name = module.shared_services.create_tenant_admin_user_function.lambda_function_name
  create_user_function_invocation_arn = module.shared_services.create_user_function.lambda_function_invoke_arn
  create_user_function_name = module.shared_services.create_user_function.lambda_function_name
  disable_users_by_tenant_function_invocation_arn = module.shared_services.disable_users_by_tenant_function.lambda_function_invoke_arn
  disable_users_by_tenant_function_name = module.shared_services.disable_users_by_tenant_function.lambda_function_name
  enable_users_by_tenant_function_invocation_arn = module.shared_services.enable_users_by_tenant_function.lambda_function_invoke_arn
  enable_users_by_tenant_function_name = module.shared_services.enable_users_by_tenant_function.lambda_function_name
  authorizer_function_arn = module.shared_services.shared_services_authorizer_function.lambda_function_arn
  authorizer_function_name = module.shared_services.shared_services_authorizer_function.lambda_function_name
}

###################################################
# Lab 3 - Serverless SaaS Application Deployment
###################################################

# Orders Microservice
module "order_microservice" {
  source = "../../modules/order_microservice"
  serverless_saas_layer_arn = module.shared_services.serverless_saas_layer.lambda_layer_arn
}

# Products Microservice
module "product_microservice" {
  source = "../../modules/product_microservice"
  serverless_saas_layer_arn = module.shared_services.serverless_saas_layer.lambda_layer_arn
}

# Tenant API Gateway
module "tenant_api_gateway" {
  source = "../../modules/tenant_api_gateway"
  
  cognito_tenant_user_pool_id = module.cognito_user_authentication.cognito_user_pool_id
  cognito_tenant_app_client_id = module.cognito_user_authentication.cognito_user_pool_client_id
  
  get_order_function = module.order_microservice.get_order_function
  update_order_function = module.order_microservice.update_order_function
  delete_order_function = module.order_microservice.delete_order_function
  get_orders_function = module.order_microservice.get_orders_function
  create_order_function = module.order_microservice.create_order_function
  
  get_product_function = module.product_microservice.get_product_function
  update_product_function = module.product_microservice.update_product_function
  delete_product_function = module.product_microservice.delete_product_function
  get_products_function = module.product_microservice.get_products_function
  create_product_function = module.product_microservice.create_product_function
  serverless_saas_layer_arn = module.shared_services.serverless_saas_layer.lambda_layer_arn
}

# Application UI
module "application_ui" {
  source = "../../modules/application_ui"
}