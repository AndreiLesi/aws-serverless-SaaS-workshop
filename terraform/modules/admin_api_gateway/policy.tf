# Resource Policy
resource "aws_api_gateway_rest_api_policy" "admin_api_gateway_policy" {
  rest_api_id = aws_api_gateway_rest_api.admin_api_gateway.id
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = "execute-api:Invoke"
        Resource  = ["execute-api:/*/*/*"]
      },
      {
        Effect    = "Deny"
        Principal = "*"
        Action    = "execute-api:Invoke"
        Resource  = [
          "execute-api:/${var.stage_name}/POST/tenant",
          "execute-api:/${var.stage_name}/POST/user/tenant-admin"
        ]
        Condition = {
          StringNotEquals = {
            "aws:PrincipalArn" = [
              var.register_tenant_lambda_execution_role_arn,
              var.tenant_management_lambda_execution_role_arn
            ]
          }
        }
      },
      {
        Effect    = "Deny"
        Principal = "*"
        Action    = "execute-api:Invoke"
        Resource  = ["execute-api:/${var.stage_name}/PUT/users/disable"]
        Condition = {
          StringNotEquals = {
            "aws:PrincipalArn" = [var.tenant_management_lambda_execution_role_arn]
          }
        }
      },
      {
        Effect    = "Deny"
        Principal = "*"
        Action    = "execute-api:Invoke"
        Resource  = ["execute-api:/${var.stage_name}/PUT/users/enable"]
        Condition = {
          StringNotEquals = {
            "aws:PrincipalArn" = [var.tenant_management_lambda_execution_role_arn]
          }
        }
      }
    ]
  })
}

# Authorizer
resource "aws_api_gateway_authorizer" "admin_api_gateway_authorizer" {
  name                   = "api-authorizer"
  rest_api_id            = aws_api_gateway_rest_api.admin_api_gateway.id
  authorizer_uri         = var.authorizer_function_invoke_arn
  authorizer_result_ttl_in_seconds = 60
}