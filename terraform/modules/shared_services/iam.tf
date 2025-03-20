# Authorizer execution role
module "authorizer_execution_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "~> 5.54.0"

  create_role = true
  role_name   = "authorizer-execution-role"
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
        "cognito-idp:list*"
      ]
      resources = [
        "arn:aws:cognito-idp:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:userpool/*"
      ]
    },
    {
      effect = "Allow"
      actions = [
        "dynamodb:getitem"
      ]
      resources = [
        var.tenant_details_table_arn
      ]
    }
  ]

  tags = {
    Name = "authorizer-execution-role"
    Service = "shared-services"
  }
}

# Tenant Userpool Lambda execution role
module "tenant_userpool_lambda_execution_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "~> 5.54.0"

  create_role = true
  role_name   = "tenant-userpool-lambda-execution-role-${data.aws_region.current.name}"
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
      name   = "tenant-userpool-lambda-execution-policy-${data.aws_region.current.name}"
      effect = "Allow"
      actions = [
        "cognito-idp:*"
      ]
      resources = ["*"]
    },
    {
      effect = "Allow"
      actions = [
        "dynamodb:GetItem"
      ]
      resources = [var.tenant_details_table_arn]
    },
    {
      effect = "Allow"
      actions = [
        "dynamodb:GetItem",
        "dynamodb:Query"
      ]
      resources = [var.tenant_user_mapping_table_arn]
    }
  ]

  tags = {
    Name = "tenant-userpool-lambda-execution-role"
  }
}

module "create_user_lambda_execution_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "~> 5.54.0"

  create_role = true
  role_name   = "create-user-lambda-execution-role-${data.aws_region.current.name}"
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
      name   = "create-user-lambda-execution-policy-${data.aws_region.current.name}"
      effect = "Allow"
      actions = [
        "cognito-idp:*"
      ]
      resources = ["*"]
    },
    {
      effect = "Allow"
      actions = [
        "dynamodb:PutItem"
      ]
      resources = [var.tenant_user_mapping_table_arn]
    },
    {
      effect = "Allow"
      actions = [
        "dynamodb:GetItem"
      ]
      resources = [var.tenant_details_table_arn]
    }
  ]

  tags = {
    Name = "create-user-lambda-execution-role"
  }
}



module "tenant_management_lambda_execution_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "~> 5.54.0"

  create_role = true
  role_name   = "tenant-management-lambda-execution-role-${data.aws_region.current.name}"
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
      name   = "create-tenant-execution-policy-${data.aws_region.current.name}"
      effect = "Allow"
      actions = [
        "dynamodb:PutItem",
        "dynamodb:GetItem",
        "dynamodb:UpdateItem",
        "dynamodb:Scan",
        "dynamodb:Query"
      ]
      resources = [
        var.tenant_details_table_arn,
        "${var.tenant_details_table_arn}/index/*"
      ]
    }
  ]

  tags = {
    Name = "tenant-management-lambda-execution-role"
  }
}

# Tenant Registration Lambda Execution Role
module "register_tenant_lambda_execution_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "~> 5.54.0"

  create_role = true
  role_name   = "tenant-registration-lambda-execution-role-${data.aws_region.current.name}"
  role_path   = "/"
  role_requires_mfa = false

  trusted_role_services = ["lambda.amazonaws.com"]

  custom_role_policy_arns = [
    "arn:aws:iam::aws:policy/CloudWatchLambdaInsightsExecutionRolePolicy",
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole",
    "arn:aws:iam::aws:policy/AWSXrayWriteOnlyAccess"
  ]

  tags = {
    Name = "tenant-registration-lambda-execution-role"
  }
}