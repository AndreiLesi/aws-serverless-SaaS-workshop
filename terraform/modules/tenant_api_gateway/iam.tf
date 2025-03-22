# Tenant Authorizer Execution Role
module "tenant_authorizer_execution_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "~> 5.54.0"

  create_role = true
  role_name   = "tenant-authorizer-execution-role"
  role_path   = "/"
  role_requires_mfa = false

  trusted_role_services = ["lambda.amazonaws.com"]

  custom_role_policy_arns = [
    "arn:aws:iam::aws:policy/CloudWatchLambdaInsightsExecutionRolePolicy",
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole",
    "arn:aws:iam::aws:policy/AWSXrayWriteOnlyAccess"
  ]
  
  inline_policy_statements = [
    {
      effect = "Allow"
      actions = [
        "cognito-idp:List*"
      ]
      resources = [
        "arn:aws:cognito-idp:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:userpool/*"
      ]
    }
  ]
}