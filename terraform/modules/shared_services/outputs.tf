output "register_tenant_lambda_execution_role_arn" {
  value = module.register_tenant_lambda_execution_role.iam_role_arn
}

output "tenant_management_lambda_execution_role_arn" {
  value = module.tenant_management_lambda_execution_role.iam_role_arn
}

output "register_tenant_function" {
  value = module.lambda_register_tenant
}

output "activate_tenant_function" {
  value = module.lambda_activate_tenant
}

output "get_tenants_function" {
  value = module.get_tenants_lambda
}

output "create_tenant_function" {
  value = module.lambda_create_tenant
}

output "get_tenant_function" {
  value = module.lambda_get_tenant
}

output "deactivate_tenant_function" {
  value = module.lambda_deactivate_tenant
}

output "update_tenant_function" {
  value = module.lambda_update_tenant
}

output "get_users_function" {
  value = module.lambda_get_users
}

output "get_user_function" {
  value = module.lambda_get_user
}

output "update_user_function" {
  value = module.lambda_update_user
}

output "disable_user_function" {
  value = module.lambda_disable_user
}

output "create_tenant_admin_user_function" {
  value = module.lambda_create_tenant_admin_user
}

output "create_user_function" {
  value = module.lambda_create_user
}

output "disable_users_by_tenant_function" {
  value = module.lambda_disable_users_by_tenant
}

output "enable_users_by_tenant_function" {
  value = module.lambda_enable_users_by_tenant
}

output "shared_services_authorizer_function" {
  value = module.lambda_shared_services_authorizer
}