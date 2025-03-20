# Lambda permissions for API Gateway

# Register Tenant Lambda Permission
resource "aws_lambda_permission" "admin_api_gateway_register_tenant_permission" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.register_tenant_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.admin_api_gateway.execution_arn}/${var.stage_name}/POST/registration"
}

# Create Tenant Admin User Lambda Permission
resource "aws_lambda_permission" "admin_api_gateway_create_tenant_admin_user_permission" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.create_tenant_admin_user_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.admin_api_gateway.execution_arn}/${var.stage_name}/POST/user/tenant-admin"
}

# Create Tenant Lambda Permission
resource "aws_lambda_permission" "admin_api_gateway_create_tenant_permission" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.create_tenant_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.admin_api_gateway.execution_arn}/${var.stage_name}/POST/tenant"
}

# Activate Tenant Lambda Permission
resource "aws_lambda_permission" "admin_api_gateway_activate_tenant_permission" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.activate_tenant_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.admin_api_gateway.execution_arn}/${var.stage_name}/PUT/tenant/activation/{tenantid}"
}

# Get Tenants Lambda Permission
resource "aws_lambda_permission" "admin_api_gateway_get_tenants_permission" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.get_tenants_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.admin_api_gateway.execution_arn}/${var.stage_name}/GET/tenants"
}

# Get Tenant Lambda Permission
resource "aws_lambda_permission" "admin_api_gateway_get_tenant_permission" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.get_tenant_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.admin_api_gateway.execution_arn}/${var.stage_name}/GET/tenant/{tenantid}"
}

# Deactivate Tenant Lambda Permission
resource "aws_lambda_permission" "admin_api_gateway_deactivate_tenant_permission" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.deactivate_tenant_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.admin_api_gateway.execution_arn}/${var.stage_name}/DELETE/tenant/{tenantid}"
}

# Update Tenant Lambda Permission
resource "aws_lambda_permission" "admin_api_gateway_update_tenant_permission" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.update_tenant_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.admin_api_gateway.execution_arn}/${var.stage_name}/PUT/tenant/{tenantid}"
}

# Create User Lambda Permission
resource "aws_lambda_permission" "admin_api_gateway_create_user_permission" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.create_user_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.admin_api_gateway.execution_arn}/${var.stage_name}/POST/user"
}

# Update User Lambda Permission
resource "aws_lambda_permission" "admin_api_gateway_update_user_permission" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.update_user_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.admin_api_gateway.execution_arn}/${var.stage_name}/PUT/user/{username}"
}

# Disable User Lambda Permission
resource "aws_lambda_permission" "admin_api_gateway_disable_user_permission" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.disable_user_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.admin_api_gateway.execution_arn}/${var.stage_name}/DELETE/user/{username}"
}

# Disable Users By Tenant Lambda Permission
resource "aws_lambda_permission" "admin_api_gateway_disable_users_permission" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.disable_users_by_tenant_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.admin_api_gateway.execution_arn}/${var.stage_name}/PUT/users/disable/{tenantid}"
}

# Enable Users By Tenant Lambda Permission
resource "aws_lambda_permission" "admin_api_gateway_enable_users_permission" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.enable_users_by_tenant_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.admin_api_gateway.execution_arn}/${var.stage_name}/PUT/users/enable/{tenantid}"
}

# Get Users Lambda Permission
resource "aws_lambda_permission" "admin_api_gateway_get_users_permission" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.get_users_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.admin_api_gateway.execution_arn}/${var.stage_name}/GET/users"
}

# Get User Lambda Permission
resource "aws_lambda_permission" "admin_api_gateway_get_user_permission" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.get_user_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.admin_api_gateway.execution_arn}/${var.stage_name}/GET/user/{username}"
}

# Authorizer Lambda Permission
resource "aws_lambda_permission" "admin_api_gateway_authorizer_permission" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.authorizer_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.admin_api_gateway.execution_arn}/authorizers/${aws_api_gateway_authorizer.admin_api_gateway_authorizer.id}"
}