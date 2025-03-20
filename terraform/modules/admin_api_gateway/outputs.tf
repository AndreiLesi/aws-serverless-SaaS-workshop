output "api_gateway_id" {
  description = "ID of the API Gateway"
  value       = aws_api_gateway_rest_api.admin_api_gateway.id
}

output "api_gateway_root_resource_id" {
  description = "ID of the API Gateway root resource"
  value       = aws_api_gateway_rest_api.admin_api_gateway.root_resource_id
}

output "api_gateway_execution_arn" {
  description = "Execution ARN of the API Gateway"
  value       = aws_api_gateway_rest_api.admin_api_gateway.execution_arn
}

output "api_gateway_invoke_url" {
  description = "Invoke URL of the API Gateway"
  value       = "https://${aws_api_gateway_rest_api.admin_api_gateway.id}.execute-api.${data.aws_region.current.name}.amazonaws.com/${var.stage_name}"
}