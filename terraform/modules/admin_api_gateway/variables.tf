variable "stage_name" {
  description = "Stage name for the API Gateway deployment"
  type        = string
  default     = "prod"
}

variable "register_tenant_lambda_execution_role_arn" {
  description = "ARN of the IAM role for the register tenant Lambda function"
  type        = string
}

variable "tenant_management_lambda_execution_role_arn" {
  description = "ARN of the IAM role for the tenant management Lambda function"
  type        = string
}

# Register Tenant Function
variable "register_tenant_function_invocation_arn" {
  description = "ARN of the register tenant Lambda function"
  type        = string
}

variable "register_tenant_function_name" {
  description = "Name of the register tenant Lambda function"
  type        = string
}

# Activate Tenant Function
variable "activate_tenant_function_invocation_arn" {
  description = "ARN of the activate tenant Lambda function"
  type        = string
}

variable "activate_tenant_function_name" {
  description = "Name of the activate tenant Lambda function"
  type        = string
}

# Get Tenants Function
variable "get_tenants_function_invocation_arn" {
  description = "ARN of the get tenants Lambda function"
  type        = string
}

variable "get_tenants_function_name" {
  description = "Name of the get tenants Lambda function"
  type        = string
}

# Create Tenant Function
variable "create_tenant_function_invocation_arn" {
  description = "ARN of the create tenant Lambda function"
  type        = string
}

variable "create_tenant_function_name" {
  description = "Name of the create tenant Lambda function"
  type        = string
}

# Get Tenant Function
variable "get_tenant_function_invocation_arn" {
  description = "ARN of the get tenant Lambda function"
  type        = string
}

variable "get_tenant_function_name" {
  description = "Name of the get tenant Lambda function"
  type        = string
}

# Deactivate Tenant Function
variable "deactivate_tenant_function_invocation_arn" {
  description = "ARN of the deactivate tenant Lambda function"
  type        = string
}

variable "deactivate_tenant_function_name" {
  description = "Name of the deactivate tenant Lambda function"
  type        = string
}

# Update Tenant Function
variable "update_tenant_function_invocation_arn" {
  description = "ARN of the update tenant Lambda function"
  type        = string
}

variable "update_tenant_function_name" {
  description = "Name of the update tenant Lambda function"
  type        = string
}

# Get User Function
variable "get_user_function_invocation_arn" {
  description = "ARN of the get user Lambda function"
  type        = string
}

variable "get_user_function_name" {
  description = "Name of the get user Lambda function"
  type        = string
}

# Get Users Function
variable "get_users_function_invocation_arn" {
  description = "ARN of the get users Lambda function"
  type        = string
}

variable "get_users_function_name" {
  description = "Name of the get users Lambda function"
  type        = string
}

# Update User Function
variable "update_user_function_invocation_arn" {
  description = "ARN of the update user Lambda function"
  type        = string
}

variable "update_user_function_name" {
  description = "Name of the update user Lambda function"
  type        = string
}

# Disable User Function
variable "disable_user_function_invocation_arn" {
  description = "ARN of the disable user Lambda function"
  type        = string
}

variable "disable_user_function_name" {
  description = "Name of the disable user Lambda function"
  type        = string
}

# Create Tenant Admin User Function
variable "create_tenant_admin_user_function_invocation_arn" {
  description = "ARN of the create tenant admin user Lambda function"
  type        = string
}

variable "create_tenant_admin_user_function_name" {
  description = "Name of the create tenant admin user Lambda function"
  type        = string
}

# Create User Function
variable "create_user_function_invocation_arn" {
  description = "ARN of the create user Lambda function"
  type        = string
}

variable "create_user_function_name" {
  description = "Name of the create user Lambda function"
  type        = string
}

# Disable Users By Tenant Function
variable "disable_users_by_tenant_function_invocation_arn" {
  description = "ARN of the disable users by tenant Lambda function"
  type        = string
}

variable "disable_users_by_tenant_function_name" {
  description = "Name of the disable users by tenant Lambda function"
  type        = string
}

# Enable Users By Tenant Function
variable "enable_users_by_tenant_function_invocation_arn" {
  description = "ARN of the enable users by tenant Lambda function"
  type        = string
}

variable "enable_users_by_tenant_function_name" {
  description = "Name of the enable users by tenant Lambda function"
  type        = string
}

# Authorizer Function
variable "authorizer_function_arn" {
  description = "ARN of the authorizer Lambda function"
  type        = string
}

variable "authorizer_function_name" {
  description = "Name of the authorizer Lambda function"
  type        = string
}

variable "authorizer_function_invoke_arn" {
  description = "ARN of the authorizer Lambda function invoke"
  type        = string
}

