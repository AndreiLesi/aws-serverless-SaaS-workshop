  output "get_product_function" {
  description = "The Lambda function that gets product details"
  value       = module.lambda_get_product
}

output "get_products_function" {
  description = "The Lambda function that gets products list"
  value       = module.lambda_get_products
}

output "create_product_function" {
  description = "The Lambda function that creates a product"
  value       = module.lambda_create_product
}

output "update_product_function" {
  description = "The Lambda function that updates a product"
  value       = module.lambda_update_product
}

output "delete_product_function" {
  description = "The Lambda function that deletes a product"
  value       = module.lambda_delete_product
}
