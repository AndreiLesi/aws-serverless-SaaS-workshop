resource "aws_api_gateway_rest_api" "admin_api_gateway" {
  name        = "serverless-saas-admin-api-${data.aws_region.current.name}"
  description = "SaaS Application Admin API Gateway"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

# CloudWatch Logging Setup
resource "aws_api_gateway_account" "api_gateway_account" {
  cloudwatch_role_arn = module.admin_api_gateway_cloudwatch_role.iam_role_arn
}

resource "aws_cloudwatch_log_group" "admin_api_gateway_logs" {
  name              = "/aws/api-gateway/access-logs-serverless-saas-admin-api"
  retention_in_days = 30
}

# API Stage with logging
resource "aws_api_gateway_stage" "admin_api_gateway_prod" {
  deployment_id = aws_api_gateway_deployment.admin_api_gateway_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.admin_api_gateway.id
  stage_name    = var.stage_name

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.admin_api_gateway_logs.arn
    format          = jsonencode({
      requestId      = "$context.requestId"
      ip             = "$context.identity.sourceIp"
      caller         = "$context.identity.caller"
      user           = "$context.identity.user"
      requestTime    = "$context.requestTime"
      httpMethod     = "$context.httpMethod"
      resourcePath   = "$context.resourcePath"
      status         = "$context.status"
      protocol       = "$context.protocol"
      responseLength = "$context.responseLength"
    })
  }

  xray_tracing_enabled = true
}

# API Deployment
resource "aws_api_gateway_deployment" "admin_api_gateway_deployment" {
  rest_api_id = aws_api_gateway_rest_api.admin_api_gateway.id
  
  # Add dependencies to ensure redeployment when resources change
  triggers = {
    # Generate a hash of all resources that should trigger redeployment
    redeployment_hash = sha1(join(",", [
      # Tenant management resources and integrations
      jsonencode(aws_api_gateway_resource.admin_api_gateway_registration),
      jsonencode(aws_api_gateway_resource.admin_api_gateway_tenant_activation),
      jsonencode(aws_api_gateway_resource.admin_api_gateway_tenants),
      jsonencode(aws_api_gateway_resource.admin_api_gateway_tenant),
      jsonencode(aws_api_gateway_resource.admin_api_gateway_tenant_id),
      jsonencode(aws_api_gateway_integration.admin_api_gateway_register_tenant_integration),
      jsonencode(aws_api_gateway_integration.admin_api_gateway_activate_tenant_integration),
      jsonencode(aws_api_gateway_integration.admin_api_gateway_get_tenants_integration),
      jsonencode(aws_api_gateway_integration.admin_api_gateway_get_tenant_integration),
      
      # User management resources and integrations
      jsonencode(aws_api_gateway_resource.admin_api_gateway_users),
      jsonencode(aws_api_gateway_resource.admin_api_gateway_users_disable_tenantid),
      jsonencode(aws_api_gateway_resource.admin_api_gateway_users_enable_tenantid),
      jsonencode(aws_api_gateway_resource.admin_api_gateway_user_tenant_admin),
      jsonencode(aws_api_gateway_integration.admin_api_gateway_create_user_integration),
      jsonencode(aws_api_gateway_integration.admin_api_gateway_disable_users_put_integration),
      jsonencode(aws_api_gateway_integration.admin_api_gateway_enable_users_integration),
      jsonencode(aws_api_gateway_integration.admin_api_gateway_create_tenant_admin_integration),
      
      # Methods
      jsonencode(aws_api_gateway_method.admin_api_gateway_register_tenant_post),
      jsonencode(aws_api_gateway_method.admin_api_gateway_activate_tenant_put),
      jsonencode(aws_api_gateway_method.admin_api_gateway_get_tenants),
      jsonencode(aws_api_gateway_method.admin_api_gateway_get_tenant),
      jsonencode(aws_api_gateway_method.admin_api_gateway_create_tenant_post),
      jsonencode(aws_api_gateway_method.admin_api_gateway_update_tenant_put),
      jsonencode(aws_api_gateway_method.admin_api_gateway_create_user_post),
      jsonencode(aws_api_gateway_method.admin_api_gateway_disable_users_put),
      jsonencode(aws_api_gateway_method.admin_api_gateway_enable_users_put),
      jsonencode(aws_api_gateway_method.admin_api_gateway_create_tenant_admin_post),
      
      # CORS methods
      jsonencode(aws_api_gateway_method.admin_api_gateway_register_tenant_options),
      jsonencode(aws_api_gateway_method.admin_api_gateway_tenant_activation_options),
      jsonencode(aws_api_gateway_method.admin_api_gateway_users_options),
      jsonencode(aws_api_gateway_method.admin_api_gateway_disable_users_put_options),
      jsonencode(aws_api_gateway_method.admin_api_gateway_enable_users_put_options),
      jsonencode(aws_api_gateway_method.admin_api_gateway_tenant_options),
      jsonencode(aws_api_gateway_method.admin_api_gateway_user_tenant_admin_options),
      
      # OPTIONS integrations
      jsonencode(aws_api_gateway_integration.admin_api_gateway_register_tenant_options_integration),
      jsonencode(aws_api_gateway_integration.admin_api_gateway_tenant_activation_options_integration),
      jsonencode(aws_api_gateway_integration.admin_api_gateway_users_options_integration),
      jsonencode(aws_api_gateway_integration.admin_api_gateway_disable_users_put_options_integration),
      jsonencode(aws_api_gateway_integration.admin_api_gateway_enable_users_put_options_integration),
      jsonencode(aws_api_gateway_integration.admin_api_gateway_tenant_options_integration),
      jsonencode(aws_api_gateway_integration.admin_api_gateway_user_tenant_admin_options_integration),
      
      # Method responses
      jsonencode(aws_api_gateway_method_response.admin_api_gateway_activate_tenant_put_response),
      jsonencode(aws_api_gateway_method_response.admin_api_gateway_disable_users_put_response),
      jsonencode(aws_api_gateway_method_response.admin_api_gateway_enable_users_put_response),
      jsonencode(aws_api_gateway_method_response.admin_api_gateway_create_tenant_admin_post_response),
      
      # Integration responses
      jsonencode(aws_api_gateway_integration_response.admin_api_gateway_register_tenant_options_integration_response),
      jsonencode(aws_api_gateway_integration_response.admin_api_gateway_tenant_activation_options_integration_response),
      jsonencode(aws_api_gateway_integration_response.admin_api_gateway_disable_users_put_integration_response),
      jsonencode(aws_api_gateway_integration_response.admin_api_gateway_disable_users_put_options_integration_response),
      jsonencode(aws_api_gateway_integration_response.admin_api_gateway_enable_users_integration_response),
      jsonencode(aws_api_gateway_integration_response.admin_api_gateway_enable_users_put_options_integration_response),
      jsonencode(aws_api_gateway_integration_response.admin_api_gateway_tenant_options_integration_response),
      jsonencode(aws_api_gateway_integration_response.admin_api_gateway_user_tenant_admin_options_integration_response)
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Method Settings
resource "aws_api_gateway_method_settings" "admin_api_gateway_all" {
  rest_api_id = aws_api_gateway_rest_api.admin_api_gateway.id
  stage_name  = aws_api_gateway_stage.admin_api_gateway_prod.stage_name
  method_path = "*/*"

  settings {
    metrics_enabled    = true
    logging_level      = "INFO"
    data_trace_enabled = false
  }
}