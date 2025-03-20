output "tenant_details_table_arn" {
  value = module.tenant_details_table.dynamodb_table_arn
}

output "tenant_details_table_name" {
  value = module.tenant_details_table.dynamodb_table_id
}