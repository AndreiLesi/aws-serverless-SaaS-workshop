output "tenant_user_mapping_table_arn" {
  value = module.tenant_user_mapping_table.dynamodb_table_arn
}

output "tenant_user_mapping_table_name" {
  value = module.tenant_user_mapping_table.dynamodb_table_id
}