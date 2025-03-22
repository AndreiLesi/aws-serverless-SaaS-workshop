variable "cognito_tenant_user_pool_id" {
  type = string
}

variable "cognito_tenant_app_client_id" {
  type = string
}

variable "stage_name" {
  type = string
  default = "prod"
}

variable "get_order_function_arn" {
  type = string
}

variable "update_order_function_arn" {
  type = string
}

variable "delete_order_function_arn" {
  type = string
}

variable "get_orders_function_arn" {
  type = string
}

variable "create_order_function_arn" {
  type = string
}

variable "get_product_function_arn" {
  type = string
}

variable "update_product_function_arn" {
  type = string
}

variable "delete_product_function_arn" {
  type = string
}

variable "get_products_function_arn" {
  type = string
}

variable "create_product_function_arn" {
  type = string
}

variable "serverless_saas_layer_arn" {
  type = string
}
  