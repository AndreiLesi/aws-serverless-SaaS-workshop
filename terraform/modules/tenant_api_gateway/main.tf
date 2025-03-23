# API Gateway
resource "aws_api_gateway_rest_api" "tenant_api_gateway" {
  name        = "serverless-saas-tenant-api"
  description = "SaaS Application Tenant API Gateway"
  api_key_source = "AUTHORIZER"
  
  body = templatefile("${path.module}/api.yaml", {
    GetOrderFunction = var.get_order_function.lambda_function_invoke_arn,
    UpdateOrderFunction = var.update_order_function.lambda_function_invoke_arn,
    DeleteOrderFunction = var.delete_order_function.lambda_function_invoke_arn,
    GetOrdersFunction = var.get_orders_function.lambda_function_invoke_arn,
    CreateOrderFunction = var.create_order_function.lambda_function_invoke_arn,
    GetProductFunction = var.get_product_function.lambda_function_invoke_arn,
    UpdateProductFunction = var.update_product_function.lambda_function_invoke_arn,
    DeleteProductFunction = var.delete_product_function.lambda_function_invoke_arn,
    GetProductsFunction = var.get_products_function.lambda_function_invoke_arn,
    CreateProductFunction = var.create_product_function.lambda_function_invoke_arn,
    BusinessServicesAuthorizerFunction = module.lambda_business_services_authorizer.lambda_function_invoke_arn
    TenantAuthorizerExecutionRole = module.tenant_api_gateway_authorizer_role.iam_role_arn
  })

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

# CloudWatch Logging Setup
resource "aws_cloudwatch_log_group" "tenant_api_gateway_logs" {
  name              = "/aws/api-gateway/access-logs-serverless-saas-tenant-api"
  retention_in_days = 30
}

# API Gateway Deployment - Move before stage
resource "aws_api_gateway_deployment" "tenant_api_gateway_deployment" {
  rest_api_id = aws_api_gateway_rest_api.tenant_api_gateway.id
  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.tenant_api_gateway.body))
  }

  lifecycle {
    create_before_destroy = true
  }
  
  # Ensure deployment happens after API is fully configured
  depends_on = [
    aws_api_gateway_rest_api.tenant_api_gateway
  ]
}

# API Gateway Stage
resource "aws_api_gateway_stage" "tenant_api_gateway_stage" {
  rest_api_id = aws_api_gateway_rest_api.tenant_api_gateway.id
  deployment_id = aws_api_gateway_deployment.tenant_api_gateway_deployment.id
  stage_name = var.stage_name

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.tenant_api_gateway_logs.arn
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

# Method Settings
resource "aws_api_gateway_method_settings" "tenant_api_gateway_all" {
  rest_api_id = aws_api_gateway_rest_api.tenant_api_gateway.id
  stage_name  = aws_api_gateway_stage.tenant_api_gateway_stage.stage_name
  method_path = "*/*"

  settings {
    metrics_enabled    = true
    logging_level      = "INFO"
    data_trace_enabled = false
  }
}