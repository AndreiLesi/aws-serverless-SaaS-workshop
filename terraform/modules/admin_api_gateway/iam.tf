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