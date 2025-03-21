module "product_function_execution_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "~> 5.54.0"

  create_role = true
  role_name   = "product-function-execution-role-${data.aws_region.current.name}"
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
      name   = "product-function-policy-${data.aws_region.current.name}"
      effect = "Allow"
      actions = [
        "dynamodb:GetItem",
        "dynamodb:UpdateItem",
        "dynamodb:PutItem",
        "dynamodb:DeleteItem",
        "dynamodb:Query"
      ]
      resources = [module.product_table.dynamodb_table_arn]
    }
  ]

  tags = {
    Name = "product-function-execution-role"
    Service = "product-microservice"
  }
}