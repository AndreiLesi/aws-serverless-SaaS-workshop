module "lambda_get_orders" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 4.18.0"

  function_name = "get-orders"
  description   = "Lambda function to get orders list"
  handler       = "order_service.get_orders"
  runtime       = "python3.12"
  timeout = 29

  source_path   = "${path.module}/../../../src/server/OrderService"
  create_role   = false
  lambda_role   = module.order_function_execution_role.iam_role_arn

  layers        = [
    var.serverless_saas_layer_arn,
    "arn:aws:lambda:${data.aws_region.current.name}:580247275435:layer:LambdaInsightsExtension:14"
  ]

  tracing_mode  = "Active"

  environment_variables = {
    LOG_LEVEL = "DEBUG"
    POWERTOOLS_SERVICE_NAME = "OrderService"
    POWERTOOLS_METRICS_NAMESPACE = "ServerlessSaaS"
    ORDER_TABLE_NAME = module.order_table.dynamodb_table_id
  }

  tags = {
    Name    = "get-orders"
    Service = "order-service"
  }
}


module "lambda_get_order" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 4.18.0"

  function_name = "get-order"
  description   = "Lambda function to get order details"
  handler       = "order_service.get_order"
  runtime       = "python3.12"
  timeout = 29

  source_path   = "${path.module}/../../../src/server/OrderService"
  create_role   = false
  lambda_role   = module.order_function_execution_role.iam_role_arn

  layers        = [
    var.serverless_saas_layer_arn,
    "arn:aws:lambda:${data.aws_region.current.name}:580247275435:layer:LambdaInsightsExtension:14"
  ]

  tracing_mode  = "Active"

  environment_variables = {
    LOG_LEVEL = "DEBUG"
    POWERTOOLS_SERVICE_NAME = "OrderService"
    POWERTOOLS_METRICS_NAMESPACE = "ServerlessSaaS"
    ORDER_TABLE_NAME = module.order_table.dynamodb_table_id
  }

  tags = {
    Name    = "get-order"
    Service = "order-service"
  }
}

module "lambda_create_order" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 4.18.0"

  function_name = "create-order"
  description   = "Lambda function to create order"
  handler       = "order_service.create_order"
  runtime       = "python3.12"
  timeout = 29

  source_path   = "${path.module}/../../../src/server/OrderService"
  create_role   = false
  lambda_role   = module.order_function_execution_role.iam_role_arn

  layers        = [
    var.serverless_saas_layer_arn,
    "arn:aws:lambda:${data.aws_region.current.name}:580247275435:layer:LambdaInsightsExtension:14"
  ]

  tracing_mode  = "Active"

  environment_variables = {
    LOG_LEVEL = "DEBUG"
    POWERTOOLS_SERVICE_NAME = "OrderService"
    POWERTOOLS_METRICS_NAMESPACE = "ServerlessSaaS"
    ORDER_TABLE_NAME = module.order_table.dynamodb_table_id
  }

  tags = {
    Name    = "create-order"
    Service = "order-service"
  }
}

module "lambda_update_order" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 4.18.0"

  function_name = "update-order"
  description   = "Lambda function to update order"
  handler       = "order_service.update_order"
  runtime       = "python3.12"
  timeout = 29

  source_path   = "${path.module}/../../../src/server/OrderService"
  create_role   = false
  lambda_role   = module.order_function_execution_role.iam_role_arn

  layers        = [
    var.serverless_saas_layer_arn,
    "arn:aws:lambda:${data.aws_region.current.name}:580247275435:layer:LambdaInsightsExtension:14"
  ]

  tracing_mode  = "Active"

  environment_variables = {
    LOG_LEVEL = "DEBUG"
    POWERTOOLS_SERVICE_NAME = "OrderService"
    POWERTOOLS_METRICS_NAMESPACE = "ServerlessSaaS"
    ORDER_TABLE_NAME = module.order_table.dynamodb_table_id
  }

  tags = {
    Name    = "update-order"
    Service = "order-service"
  }
}

module "lambda_delete_order" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 4.18.0"

  function_name = "delete-order"
  description   = "Lambda function to delete order"
  handler       = "order_service.delete_order"
  runtime       = "python3.12"
  timeout = 29

  source_path   = "${path.module}/../../../src/server/OrderService"
  create_role   = false
  lambda_role   = module.order_function_execution_role.iam_role_arn

  layers        = [
    var.serverless_saas_layer_arn,
    "arn:aws:lambda:${data.aws_region.current.name}:580247275435:layer:LambdaInsightsExtension:14"
  ]

  tracing_mode  = "Active"

  environment_variables = {
    LOG_LEVEL = "DEBUG"
    POWERTOOLS_SERVICE_NAME = "OrderService"
    POWERTOOLS_METRICS_NAMESPACE = "ServerlessSaaS"
    ORDER_TABLE_NAME = module.order_table.dynamodb_table_id
  }

  tags = {
    Name    = "delete-order"
    Service = "order-service"
  }
}