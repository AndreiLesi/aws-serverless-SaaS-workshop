output "api_gateway_id" {
  description = "ID of the Tenant API Gateway"
  value       = aws_api_gateway_rest_api.tenant_api_gateway.id
}

output "api_gateway_invoke_url" {
  description = "Invoke URL of the Tenant API Gateway"
  value       = aws_api_gateway_stage.tenant_api_gateway_stage.invoke_url
}