# Admin API Gateway CloudWatch Role
module "admin_api_gateway_cloudwatch_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "~> 5.30.0"

  create_role = true
  role_name   = "admin-apigateway-cloudwatch-publish-role-${data.aws_region.current.name}"
  role_requires_mfa = false

  trusted_role_services = ["apigateway.amazonaws.com"]

  custom_role_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonAPIGatewayPushToCloudWatchLogs"
  ]
}

# Admin API Gateway Authorizer Role
module "admin_api_gateway_authorizer_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "~> 5.30.0"

  create_role = true
  role_name   = "admin-api-gateway-authorizer-role-${data.aws_region.current.name}"
  role_requires_mfa = false

  trusted_role_services = ["apigateway.amazonaws.com"]

  custom_role_policy_arns = [
    aws_iam_policy.admin_api_gateway_authorizer_policy.arn
  ]
}

# Admin API Gateway Authorizer Policy
resource "aws_iam_policy" "admin_api_gateway_authorizer_policy" {
  name        = "admin-api-gateway-authorizer-policy"
  description = "Policy for Admin API Gateway authorizer to invoke Lambda functions"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "lambda:InvokeFunction"
        Resource = var.authorizer_function_arn
      }
    ]
  })
}