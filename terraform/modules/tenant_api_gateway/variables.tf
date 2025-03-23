variable "cognito_tenant_user_pool_id" {
  description = "ID of the Cognito User Pool for tenant users"
  type        = string
}

variable "cognito_tenant_app_client_id" {
  description = "Client ID of the Cognito User Pool for tenant users"
  type        = string
}

variable "stage_name" {
  description = "Stage name for the API Gateway deployment"
  type        = string
  default     = "prod"
}
variable "get_order_function" {
  description = "Get order Lambda function object"
  type = any
}

variable "update_order_function" {
  description = "Update order Lambda function object"
  type = any
}

variable "delete_order_function" {
  description = "Delete order Lambda function object"
  type = any
}

variable "get_orders_function" {
  description = "Get orders Lambda function object"
  type = any
}

variable "create_order_function" {
  description = "Create order Lambda function object"
  type = any
}

variable "get_product_function" {
  description = "Get product Lambda function object"
  type = any
}

variable "update_product_function" {
  description = "Update product Lambda function object"
  type = any
}

variable "delete_product_function" {
  description = "Delete product Lambda function object"
  type = any
}

variable "get_products_function" {
  description = "Get products Lambda function object"
  type = any
}

variable "create_product_function" {
  description = "Create product Lambda function object"
  type = any
}

variable "serverless_saas_layer_arn" {
  description = "ARN of the Lambda layer containing shared serverless SaaS code"
  type        = string
}