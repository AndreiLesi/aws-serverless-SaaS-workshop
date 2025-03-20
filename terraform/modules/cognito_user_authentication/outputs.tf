output "cognito_user_pool_id" {
  value = aws_cognito_user_pool.tenant_user_pool.id
}

output "cognito_user_pool_client_id" {
  value = aws_cognito_user_pool_client.tenant_user_pool_client.id
}

output "cognito_operation_users_user_pool_id" {
  value = aws_cognito_user_pool.operations_user_pool.id
}

output "cognito_operation_users_user_pool_client_id" {
  value = aws_cognito_user_pool_client.operations_user_pool_client.id
}

output "cognito_operation_users_user_pool_provider_url" {
  value = aws_cognito_user_pool.operations_user_pool.endpoint
}

output "cognito_admin_user_group_name" {
  value = aws_cognito_user_group.operations_system_admins.name
}