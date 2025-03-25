# Tenant API Gateway Authorizer Role
module "tenant_api_gateway_authorizer_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "~> 5.54.0"

  create_role = true
  role_name   = "tenant-api-gateway-authorizer-role-${data.aws_region.current.name}"
  role_requires_mfa = false

  trusted_role_services = ["apigateway.amazonaws.com"]

  inline_policy_statements = [
    {
      name        = "tenant-api-gateway-authorizer-policy"
      effect      = "Allow"
      actions     = ["lambda:InvokeFunction"]
      resources   = [module.lambda_business_services_authorizer.lambda_function_arn]
    }
  ]
}