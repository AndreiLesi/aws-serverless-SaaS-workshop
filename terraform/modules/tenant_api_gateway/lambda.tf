module "lambda_business_services_authorizer" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 4.18.0"

  function_name = "business-services-authorizer"
  description   = "Lambda function for business services authorizer"
  handler       = "tenant_authorizer.lambda_handler"
  runtime       = "python3.12"
  timeout       = 29

  source_path   = "${path.module}/../../../src/server/Resources"
  # build_in_docker = true
  create_role   = false
  lambda_role   = var.authorizer_execution_role_arn

  memory_size   = 256
  tracing_mode  = "Active"

  layers = [
    var.serverless_saas_layer_arn,
    "arn:aws:lambda:${data.aws_region.current.name}:580247275435:layer:LambdaInsightsExtension:14"
  ]

  environment_variables = {
    TENANT_USER_POOL    = var.cognito_tenant_user_pool_id
    TENANT_APP_CLIENT   = var.cognito_tenant_app_client_id
  }

  tags = {
    Name    = "business-services-authorizer"
    Service = "tenant-services"
  }
}