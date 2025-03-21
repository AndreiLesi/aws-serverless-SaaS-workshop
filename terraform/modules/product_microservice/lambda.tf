module "lambda_get_product" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 4.18.0"

  function_name = "get-product"
  description   = "Lambda function to get product details"
  handler       = "product_service.get_product"
  runtime       = "python3.12"
  timeout = 29

  source_path   = "${path.module}/../../../src/server/ProductService"
  create_role   = false
  lambda_role   = module.product_function_execution_role.iam_role_arn

  layers        = [
    var.serverless_saas_layer_arn,
    "arn:aws:lambda:${data.aws_region.current.name}:580247275435:layer:LambdaInsightsExtension:14"
  ]

  tracing_mode  = "Active"

  environment_variables = {
    LOG_LEVEL = "DEBUG"
    POWERTOOLS_SERVICE_NAME = "ProductService"
    POWERTOOLS_METRICS_NAMESPACE = "ServerlessSaaS"
    PRODUCT_TABLE_NAME = module.product_table.dynamodb_table_id
  }

  tags = {
    Name    = "get-product"
    Service = "product-service"
  }
}

module "lambda_get_products" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 4.18.0"

  function_name = "get-products"
  description   = "Lambda function to get products list"
  handler       = "product_service.get_products"
  runtime       = "python3.12"
  timeout = 29

  source_path   = "${path.module}/../../../src/server/ProductService"
  create_role   = false
  lambda_role   = module.product_function_execution_role.iam_role_arn

  layers        = [
    var.serverless_saas_layer_arn,
    "arn:aws:lambda:${data.aws_region.current.name}:580247275435:layer:LambdaInsightsExtension:14"
  ]

  tracing_mode  = "Active"

  environment_variables = {
    LOG_LEVEL = "DEBUG"
    POWERTOOLS_SERVICE_NAME = "ProductService"
    POWERTOOLS_METRICS_NAMESPACE = "ServerlessSaaS"
    PRODUCT_TABLE_NAME = module.product_table.dynamodb_table_id
  }

  tags = {
    Name    = "get-products"
    Service = "product-service"
  }
}

module "lambda_create_product" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 4.18.0"

  function_name = "create-product"
  description   = "Lambda function to create product"
  handler       = "product_service.create_product"
  runtime       = "python3.12"
  timeout = 29

  source_path   = "${path.module}/../../../src/server/ProductService"
  create_role   = false
  lambda_role   = module.product_function_execution_role.iam_role_arn

  layers        = [
    var.serverless_saas_layer_arn,
    "arn:aws:lambda:${data.aws_region.current.name}:580247275435:layer:LambdaInsightsExtension:14"
  ]

  tracing_mode  = "Active"

  environment_variables = {
    LOG_LEVEL = "DEBUG"
    POWERTOOLS_SERVICE_NAME = "ProductService"
    POWERTOOLS_METRICS_NAMESPACE = "ServerlessSaaS"
    PRODUCT_TABLE_NAME = module.product_table.dynamodb_table_id
  }

  tags = {
    Name    = "create-product"
    Service = "product-service"
  }
}

module "lambda_update_product" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 4.18.0"

  function_name = "update-product"
  description   = "Lambda function to update product"
  handler       = "product_service.update_product"
  runtime       = "python3.12"
  timeout = 29

  source_path   = "${path.module}/../../../src/server/ProductService"
  create_role   = false
  lambda_role   = module.product_function_execution_role.iam_role_arn

  layers        = [
    var.serverless_saas_layer_arn,
    "arn:aws:lambda:${data.aws_region.current.name}:580247275435:layer:LambdaInsightsExtension:14"
  ]

  tracing_mode  = "Active"

  environment_variables = {
    LOG_LEVEL = "DEBUG"
    POWERTOOLS_SERVICE_NAME = "ProductService"
    POWERTOOLS_METRICS_NAMESPACE = "ServerlessSaaS"
    PRODUCT_TABLE_NAME = module.product_table.dynamodb_table_id
  }

  tags = {
    Name    = "update-product"
    Service = "product-service"
  }
}

module "lambda_delete_product" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 4.18.0"

  function_name = "delete-product"
  description   = "Lambda function to delete product"
  handler       = "product_service.delete_product"
  runtime       = "python3.12"
  timeout = 29

  source_path   = "${path.module}/../../../src/server/ProductService"
  create_role   = false
  lambda_role   = module.product_function_execution_role.iam_role_arn

  layers        = [
    var.serverless_saas_layer_arn,
    "arn:aws:lambda:${data.aws_region.current.name}:580247275435:layer:LambdaInsightsExtension:14"
  ]

  tracing_mode  = "Active"

  environment_variables = {
    LOG_LEVEL = "DEBUG"
    POWERTOOLS_SERVICE_NAME = "ProductService"
    POWERTOOLS_METRICS_NAMESPACE = "ServerlessSaaS"
    PRODUCT_TABLE_NAME = module.product_table.dynamodb_table_id
  }

  tags = {
    Name    = "delete-product"
    Service = "product-service"
  }
}