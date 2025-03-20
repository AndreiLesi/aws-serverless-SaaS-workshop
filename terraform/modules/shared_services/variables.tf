  variable "cognito_operation_users_user_pool_id" {
    description = "ID of the Cognito User Pool for operation users"
    type        = string
  }
  
  variable "cognito_operation_users_user_pool_client_id" {
    description = "Client ID of the Cognito User Pool for operation users"
    type        = string
  }
  
  variable "cognito_user_pool_id" {
    description = "ID of the Cognito User Pool"
    type        = string
  }
  
  variable "cognito_user_pool_client_id" {
    description = "Client ID of the Cognito User Pool"
    type        = string
  }
  
  variable "tenant_details_table_arn" {
    description = "ARN of the Tenant Details table"
    type        = string
  }
  
  variable "tenant_user_mapping_table_arn" {
    description = "ARN of the Tenant User Mapping table"
    type        = string
  }