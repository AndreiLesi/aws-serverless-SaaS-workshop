# Lambda layer for shared dependencies
module "serverless_saas_layer" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 4.18.0"
  
  create_layer = true
  create_function = false
  
  layer_name          = "serverless-saas-layer"
  description         = "Shared dependencies for serverless SaaS functions"
  compatible_runtimes = ["python3.12"]

  source_path = [
    "${path.module}/../../../src/server/layers",
    {
      pip_requirements = "${path.module}/../../../src/server/layers/python/requirements.txt"
      prefix_in_zip = "python"
    }
  ]
  # build_in_docker = true
  runtime           = "python3.12" 
  tags = {
    Name    = "serverless-saas-layer"
    Service = "shared-services"
  }
}

module "lambda_shared_services_authorizer" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 4.18.0"

  function_name = "shared-services-authorizer"
  description   = "Lambda function for shared services authorizer"
  handler       = "shared_service_authorizer.lambda_handler"
  runtime       = "python3.12"
  timeout       = 29

  source_path   = "${path.module}/../../../src/server/Resources"
  # build_in_docker = true
  create_role   = false
  lambda_role   = module.authorizer_execution_role.iam_role_arn

  memory_size   = 256
  tracing_mode  = "Active"

  layers = [
    module.serverless_saas_layer.lambda_layer_arn,
    "arn:aws:lambda:${data.aws_region.current.name}:580247275435:layer:LambdaInsightsExtension:14"
  ]

  environment_variables = {
    OPERATION_USERS_USER_POOL    = var.cognito_operation_users_user_pool_id
    OPERATION_USERS_APP_CLIENT   = var.cognito_operation_users_user_pool_client_id
    TENANT_USER_POOL  = var.cognito_user_pool_id
    TENANT_APP_CLIENT = var.cognito_user_pool_client_id
  }

  tags = {
    Name    = "shared-services-authorizer"
    Service = "shared-services"
  }
}

##################################
# User Management Lambda Functions
##################################
module "lambda_create_tenant_admin_user" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 4.18.0"

  function_name = "create-tenant-admin-user"
  description   = "Lambda function to create tenant admin user"
  handler       = "user-management.create_tenant_admin_user"
  runtime       = "python3.12"
  timeout = 29

  source_path   = "${path.module}/../../../src/server/TenantManagementService"
  # build_in_docker = true
  create_role   = false
  lambda_role   = module.create_user_lambda_execution_role.iam_role_arn

  layers        = [
    module.serverless_saas_layer.lambda_layer_arn,
    "arn:aws:lambda:${data.aws_region.current.name}:580247275435:layer:LambdaInsightsExtension:14"
  ]

  tracing_mode  = "Active"

  environment_variables = {
    LOG_LEVEL = "DEBUG"
    TENANT_USER_POOL_ID  = var.cognito_user_pool_id
    TENANT_APP_CLIENT_ID = var.cognito_user_pool_client_id
    POWERTOOLS_SERVICE_NAME = "UserManagement.CreateTenantAdmin"
    POWERTOOLS_METRICS_NAMESPACE = "ServerlessSaaS"
  }

  tags = {
    Name    = "create-tenant-admin-user"
    Service = "shared-services"
  }
}

module "lambda_create_user" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 4.18.0"

  function_name = "create-user"
  description   = "Lambda function to create user"
  handler       = "user-management.create_user"
  runtime       = "python3.12"
  timeout = 29

  source_path   = "${path.module}/../../../src/server/TenantManagementService"
  # build_in_docker = true
  create_role   = false
  lambda_role   = module.create_user_lambda_execution_role.iam_role_arn

  layers        = [
    module.serverless_saas_layer.lambda_layer_arn,
    "arn:aws:lambda:${data.aws_region.current.name}:580247275435:layer:LambdaInsightsExtension:14"
  ]

  tracing_mode  = "Active"

  environment_variables = {
    LOG_LEVEL = "DEBUG"
    TENANT_USER_POOL_ID  = var.cognito_user_pool_id
    POWERTOOLS_SERVICE_NAME = "UserManagement.CreateUser"
    POWERTOOLS_METRICS_NAMESPACE = "ServerlessSaaS"
  }

  tags = {
    Name    = "create-user"
    Service = "shared-services"
  }
}

module "lambda_update_user" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 4.18.0"

  function_name = "update-user"
  description   = "Lambda function to update user"
  handler       = "user-management.update_user"
  runtime       = "python3.12"
  timeout = 29

  source_path   = "${path.module}/../../../src/server/TenantManagementService"
  # build_in_docker = true
  create_role   = false
  lambda_role   = module.tenant_userpool_lambda_execution_role.iam_role_arn

  layers        = [
    module.serverless_saas_layer.lambda_layer_arn,
    "arn:aws:lambda:${data.aws_region.current.name}:580247275435:layer:LambdaInsightsExtension:14"
  ]

  tracing_mode  = "Active"

  environment_variables = {
    LOG_LEVEL = "DEBUG"
    TENANT_USER_POOL_ID  = var.cognito_user_pool_id
    POWERTOOLS_SERVICE_NAME = "UserManagement.UpdateUser"
    POWERTOOLS_METRICS_NAMESPACE = "ServerlessSaaS"
  }

  tags = {
    Name    = "update-user"
    Service = "shared-services"
  }
}

module "lambda_disable_user" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 4.18.0"

  function_name = "disable-user"
  description   = "Lambda function to disable user"
  handler       = "user-management.disable_user"
  runtime       = "python3.12"
  timeout = 29

  source_path   = "${path.module}/../../../src/server/TenantManagementService"
  # build_in_docker = true
  create_role   = false
  lambda_role   = module.tenant_userpool_lambda_execution_role.iam_role_arn

  layers        = [
    module.serverless_saas_layer.lambda_layer_arn,
    "arn:aws:lambda:${data.aws_region.current.name}:580247275435:layer:LambdaInsightsExtension:14"
  ]

  tracing_mode  = "Active"

  environment_variables = {
    LOG_LEVEL = "DEBUG"
    TENANT_USER_POOL_ID  = var.cognito_user_pool_id
    POWERTOOLS_SERVICE_NAME = "UserManagement.DisableUser"
    POWERTOOLS_METRICS_NAMESPACE = "ServerlessSaaS"
  }

  tags = {
    Name    = "disable-user"
    Service = "shared-services"
  }
}

module "lambda_disable_users_by_tenant" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 4.18.0"

  function_name = "disable-users-by-tenant"
  description   = "Lambda function to disable users by tenant"
  handler       = "user-management.disable_users_by_tenant"
  runtime       = "python3.12"
  timeout = 29

  source_path   = "${path.module}/../../../src/server/TenantManagementService"
  # build_in_docker = true
  create_role   = false
  lambda_role   = module.tenant_userpool_lambda_execution_role.iam_role_arn

  layers        = [
    module.serverless_saas_layer.lambda_layer_arn,
    "arn:aws:lambda:${data.aws_region.current.name}:580247275435:layer:LambdaInsightsExtension:14"
  ]

  tracing_mode  = "Active"

  environment_variables = {
    LOG_LEVEL = "DEBUG"
    TENANT_USER_POOL_ID  = var.cognito_user_pool_id
    POWERTOOLS_SERVICE_NAME = "UserManagement.DisableUsersByTenant"
    POWERTOOLS_METRICS_NAMESPACE = "ServerlessSaaS"
  }

  tags = {
    Name    = "disable-users-by-tenant"
    Service = "shared-services"
  }
}

module "lambda_enable_users_by_tenant" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 4.18.0"

  function_name = "enable-users-by-tenant"
  description   = "Lambda function to enable users by tenant"
  handler       = "user-management.enable_users_by_tenant"
  runtime       = "python3.12"
  timeout = 29

  source_path   = "${path.module}/../../../src/server/TenantManagementService"
  # build_in_docker = true
  create_role   = false
  lambda_role   = module.tenant_userpool_lambda_execution_role.iam_role_arn

  layers        = [
    module.serverless_saas_layer.lambda_layer_arn,
    "arn:aws:lambda:${data.aws_region.current.name}:580247275435:layer:LambdaInsightsExtension:14"
  ]

  tracing_mode  = "Active"

  environment_variables = {
    LOG_LEVEL = "DEBUG"
    TENANT_USER_POOL_ID  = var.cognito_user_pool_id
    POWERTOOLS_SERVICE_NAME = "UserManagement.EnableUsersByTenant"
    POWERTOOLS_METRICS_NAMESPACE = "ServerlessSaaS"
  }

  tags = {
    Name    = "enable-users-by-tenant"
    Service = "shared-services"
  }
}

module "lambda_get_user" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 4.18.0"

  function_name = "get-user"
  description   = "Lambda function to get user details"
  handler       = "user-management.get_user"
  runtime       = "python3.12"
  timeout = 29

  source_path   = "${path.module}/../../../src/server/TenantManagementService"
  # build_in_docker = true
  create_role   = false
  lambda_role   = module.tenant_userpool_lambda_execution_role.iam_role_arn

  layers        = [
    module.serverless_saas_layer.lambda_layer_arn,
    "arn:aws:lambda:${data.aws_region.current.name}:580247275435:layer:LambdaInsightsExtension:14"
  ]

  tracing_mode  = "Active"

  environment_variables = {
    LOG_LEVEL = "DEBUG"
    TENANT_USER_POOL_ID  = var.cognito_user_pool_id
    POWERTOOLS_SERVICE_NAME = "UserManagement.GetUser"
    POWERTOOLS_METRICS_NAMESPACE = "ServerlessSaaS"
  }

  tags = {
    Name    = "get-user"
    Service = "shared-services"
  }
}

module "lambda_get_users" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 4.18.0"

  function_name = "get-users"
  description   = "Lambda function to get users list"
  handler       = "user-management.get_users"
  runtime       = "python3.12"
  timeout = 29

  source_path   = "${path.module}/../../../src/server/TenantManagementService"
  # build_in_docker = true
  create_role   = false
  lambda_role   = module.tenant_userpool_lambda_execution_role.iam_role_arn

  layers        = [
    module.serverless_saas_layer.lambda_layer_arn,
    "arn:aws:lambda:${data.aws_region.current.name}:580247275435:layer:LambdaInsightsExtension:14"
  ]

  tracing_mode  = "Active"

  environment_variables = {
    LOG_LEVEL = "DEBUG"
    TENANT_USER_POOL_ID  = var.cognito_user_pool_id
    POWERTOOLS_SERVICE_NAME = "UserManagement.GetUsers"
    POWERTOOLS_METRICS_NAMESPACE = "ServerlessSaaS"
  }

  tags = {
    Name    = "get-users"
    Service = "shared-services"
  }
}

####################################
# Tenant Management Lambda Functions
####################################
module "lambda_create_tenant" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 4.18.0"

  function_name = "create-tenant"
  description   = "Lambda function to create tenant"
  handler       = "tenant-management.create_tenant"
  runtime       = "python3.12"
  timeout = 29

  source_path   = "${path.module}/../../../src/server/TenantManagementService"
  # build_in_docker = true
  create_role   = false
  lambda_role   = module.tenant_management_lambda_execution_role.iam_role_arn

  layers        = [
    module.serverless_saas_layer.lambda_layer_arn,
    "arn:aws:lambda:${data.aws_region.current.name}:580247275435:layer:LambdaInsightsExtension:14"
  ]

  tracing_mode  = "Active"

  environment_variables = {
    LOG_LEVEL = "DEBUG"
    POWERTOOLS_SERVICE_NAME = "TenantManagement.CreateTenant"
    POWERTOOLS_METRICS_NAMESPACE = "ServerlessSaaS"
  }

  tags = {
    Name    = "create-tenant"
    Service = "shared-services"
  }
}

module "lambda_activate_tenant" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 4.18.0"

  function_name = "activate-tenant"
  description   = "Lambda function to activate tenant"
  handler       = "tenant-management.activate_tenant"
  runtime       = "python3.12"
  timeout = 29

  source_path   = "${path.module}/../../../src/server/TenantManagementService"
  # build_in_docker = true
  create_role   = false
  lambda_role   = module.tenant_management_lambda_execution_role.iam_role_arn

  layers        = [
    module.serverless_saas_layer.lambda_layer_arn,
    "arn:aws:lambda:${data.aws_region.current.name}:580247275435:layer:LambdaInsightsExtension:14"
  ]

  tracing_mode  = "Active"

  environment_variables = {
    LOG_LEVEL = "DEBUG"
    POWERTOOLS_SERVICE_NAME = "TenantManagement.ActivateTenant"
    ENABLE_USERS_BY_TENANT = "/users/enable"
    PROVISION_TENANT = "/provisioning/"
    POWERTOOLS_METRICS_NAMESPACE = "ServerlessSaaS"
  }

  tags = {
    Name    = "activate-tenant"
    Service = "shared-services"
  }
}

module "lambda_get_tenant" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 4.18.0"

  function_name = "get-tenant"
  description   = "Lambda function to get tenant details"
  handler       = "tenant-management.get_tenant"
  runtime       = "python3.12"
  timeout = 29

  source_path   = "${path.module}/../../../src/server/TenantManagementService"
  # build_in_docker = true
  create_role   = false
  lambda_role   = module.tenant_management_lambda_execution_role.iam_role_arn

  layers        = [
    module.serverless_saas_layer.lambda_layer_arn,
    "arn:aws:lambda:${data.aws_region.current.name}:580247275435:layer:LambdaInsightsExtension:14"
  ]

  tracing_mode  = "Active"

  environment_variables = {
    LOG_LEVEL = "DEBUG"
    POWERTOOLS_SERVICE_NAME = "TenantManagement.GetTenant"
    POWERTOOLS_METRICS_NAMESPACE = "ServerlessSaaS"
  }

  tags = {
    Name    = "get-tenant"
    Service = "shared-services"
  }
}

module "lambda_deactivate_tenant" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 4.18.0"

  function_name = "deactivate-tenant"
  description   = "Lambda function to deactivate tenant"
  handler       = "tenant-management.deactivate_tenant"
  runtime       = "python3.12"
  timeout = 29

  source_path   = "${path.module}/../../../src/server/TenantManagementService"
  # build_in_docker = true
  create_role   = false
  lambda_role   = module.tenant_management_lambda_execution_role.iam_role_arn

  layers        = [
    module.serverless_saas_layer.lambda_layer_arn,
    "arn:aws:lambda:${data.aws_region.current.name}:580247275435:layer:LambdaInsightsExtension:14"
  ]

  tracing_mode  = "Active"

  environment_variables = {
    LOG_LEVEL = "DEBUG"
    POWERTOOLS_SERVICE_NAME = "TenantManagement.DeactivateTenant"
    DEPROVISION_TENANT = "/provisioning/"
    DISABLE_USERS_BY_TENANT = "/users/disable"
    POWERTOOLS_METRICS_NAMESPACE = "ServerlessSaaS"
  }

  tags = {
    Name    = "deactivate-tenant"
    Service = "shared-services"
  }
}

module "lambda_update_tenant" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 4.18.0"

  function_name = "update-tenant"
  description   = "Lambda function to update tenant"
  handler       = "tenant-management.update_tenant"
  runtime       = "python3.12"
  timeout = 29

  source_path   = "${path.module}/../../../src/server/TenantManagementService"
  # build_in_docker = true
  create_role   = false
  lambda_role   = module.tenant_management_lambda_execution_role.iam_role_arn

  layers        = [
    module.serverless_saas_layer.lambda_layer_arn,
    "arn:aws:lambda:${data.aws_region.current.name}:580247275435:layer:LambdaInsightsExtension:14"
  ]

  tracing_mode  = "Active"

  environment_variables = {
    LOG_LEVEL = "DEBUG"
    POWERTOOLS_SERVICE_NAME = "TenantManagement.UpdateTenant"
    POWERTOOLS_METRICS_NAMESPACE = "ServerlessSaaS"
  }

  tags = {
    Name    = "update-tenant"
    Service = "shared-services"
  }
}

module "get_tenants_lambda" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 4.18.0"

  function_name = "get-tenants"
  description   = "Lambda function to get tenants list"
  handler       = "tenant-management.get_tenants"
  runtime       = "python3.12"
  timeout = 29

  source_path   = "${path.module}/../../../src/server/TenantManagementService"
  # build_in_docker = true
  create_role   = false
  lambda_role   = module.tenant_management_lambda_execution_role.iam_role_arn

  layers        = [
    module.serverless_saas_layer.lambda_layer_arn,
    "arn:aws:lambda:${data.aws_region.current.name}:580247275435:layer:LambdaInsightsExtension:14"
  ]

  tracing_mode  = "Active"

  environment_variables = {
    LOG_LEVEL = "DEBUG"
    POWERTOOLS_SERVICE_NAME = "TenantManagement.GetTenants"
    POWERTOOLS_METRICS_NAMESPACE = "ServerlessSaaS"
  }

  tags = {
    Name    = "get-tenants"
    Service = "shared-services"
  }
}

# Tenant Registration Lambda Function
module "lambda_register_tenant" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 4.18.0"

  function_name = "register-tenant"
  description   = "Lambda function to register tenant"
  handler       = "tenant-registration.register_tenant"
  runtime       = "python3.12"
  timeout = 29

  source_path   = "${path.module}/../../../src/server/TenantManagementService"
  # build_in_docker = true
  create_role   = false
  lambda_role   = module.register_tenant_lambda_execution_role.iam_role_arn

  layers        = [
    module.serverless_saas_layer.lambda_layer_arn,
    "arn:aws:lambda:${data.aws_region.current.name}:580247275435:layer:LambdaInsightsExtension:14"
  ]

  tracing_mode  = "Active"

  environment_variables = {
    LOG_LEVEL = "DEBUG"
    POWERTOOLS_SERVICE_NAME = "TenantRegistration.RegisterTenant"
    CREATE_TENANT_ADMIN_USER_RESOURCE_PATH = "/user/tenant-admin"
    CREATE_TENANT_RESOURCE_PATH = "/tenant"
    PROVISION_TENANT_RESOURCE_PATH = "/provisioning"
    POWERTOOLS_METRICS_NAMESPACE = "ServerlessSaaS"
  }

  tags = {
    Name    = "register-tenant"
    Service = "shared-services"
  }
}










