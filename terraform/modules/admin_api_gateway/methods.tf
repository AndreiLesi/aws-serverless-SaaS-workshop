# POST /registration
resource "aws_api_gateway_method" "admin_api_gateway_register_tenant_post" {
  rest_api_id   = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id   = aws_api_gateway_resource.admin_api_gateway_registration.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_method_response" "admin_api_gateway_register_tenant_post_response" {
  rest_api_id   = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id   = aws_api_gateway_resource.admin_api_gateway_registration.id
  http_method   = aws_api_gateway_method.admin_api_gateway_register_tenant_post.http_method
  status_code   = "200"
  
  response_models = {
    "application/json" = "Empty"
  }
  
}

resource "aws_api_gateway_integration" "admin_api_gateway_register_tenant_integration" {
  rest_api_id             = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id             = aws_api_gateway_resource.admin_api_gateway_registration.id
  http_method             = aws_api_gateway_method.admin_api_gateway_register_tenant_post.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.register_tenant_function_invocation_arn
}

# OPTIONS /registration (CORS)
resource "aws_api_gateway_method" "admin_api_gateway_register_tenant_options" {
  rest_api_id   = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id   = aws_api_gateway_resource.admin_api_gateway_registration.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "admin_api_gateway_register_tenant_options_integration" {
  rest_api_id             = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id             = aws_api_gateway_resource.admin_api_gateway_registration.id
  http_method             = aws_api_gateway_method.admin_api_gateway_register_tenant_options.http_method
  type                    = "MOCK"
  request_templates = {
    "application/json" = "{\"statusCode\": 200}"
  }
  passthrough_behavior = "WHEN_NO_MATCH"
}

resource "aws_api_gateway_method_response" "admin_api_gateway_register_tenant_options_response" {
  rest_api_id   = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id   = aws_api_gateway_resource.admin_api_gateway_registration.id
  http_method   = aws_api_gateway_method.admin_api_gateway_register_tenant_options.http_method
  status_code   = "200"
  
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin"  = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Headers" = true
  }
}

resource "aws_api_gateway_integration_response" "admin_api_gateway_register_tenant_options_integration_response" {
  rest_api_id   = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id   = aws_api_gateway_resource.admin_api_gateway_registration.id
  http_method   = aws_api_gateway_method.admin_api_gateway_register_tenant_options.http_method
  status_code   = aws_api_gateway_method_response.admin_api_gateway_register_tenant_options_response.status_code
  
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
    "method.response.header.Access-Control-Allow-Methods" = "'DELETE,GET,HEAD,OPTIONS,PATCH,POST,PUT'"
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,Authorization,X-Amz-Date,X-Api-Key,X-Amz-Security-Token'"
  }
}

# PUT /tenant/activation/{tenantid}
resource "aws_api_gateway_method" "admin_api_gateway_activate_tenant_put" {
  rest_api_id   = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id   = aws_api_gateway_resource.admin_api_gateway_tenant_activation.id
  http_method   = "PUT"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.admin_api_gateway_authorizer.id
  # api_key_required = true
}

resource "aws_api_gateway_method_response" "admin_api_gateway_activate_tenant_put_response" {
  rest_api_id   = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id   = aws_api_gateway_resource.admin_api_gateway_tenant_activation.id
  http_method   = aws_api_gateway_method.admin_api_gateway_activate_tenant_put.http_method
  status_code   = "200"
  
  response_models = {
    "application/json" = "Empty"
  }
  
}

resource "aws_api_gateway_integration" "admin_api_gateway_activate_tenant_integration" {
  rest_api_id             = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id             = aws_api_gateway_resource.admin_api_gateway_tenant_activation.id
  http_method             = aws_api_gateway_method.admin_api_gateway_activate_tenant_put.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.activate_tenant_function_invocation_arn
}

# OPTIONS /tenant/{tenantid} (CORS)
resource "aws_api_gateway_method" "admin_api_gateway_tenant_activation_options" {
  rest_api_id   = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id   = aws_api_gateway_resource.admin_api_gateway_tenant_activation.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "admin_api_gateway_tenant_activation_options_integration" {
  rest_api_id             = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id             = aws_api_gateway_resource.admin_api_gateway_tenant_activation.id
  http_method             = aws_api_gateway_method.admin_api_gateway_tenant_activation_options.http_method
  type                    = "MOCK"
  request_templates = {
    "application/json" = "{\"statusCode\": 200}"
  }
  passthrough_behavior = "WHEN_NO_MATCH"
}

resource "aws_api_gateway_method_response" "admin_api_gateway_tenant_activation_options_response" {
  rest_api_id   = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id   = aws_api_gateway_resource.admin_api_gateway_tenant_activation.id
  http_method   = aws_api_gateway_method.admin_api_gateway_tenant_activation_options.http_method
  status_code   = "200"
  
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin"  = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Headers" = true
  }
}

resource "aws_api_gateway_integration_response" "admin_api_gateway_tenant_activation_options_integration_response" {
  rest_api_id   = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id   = aws_api_gateway_resource.admin_api_gateway_tenant_activation.id
  http_method   = aws_api_gateway_method.admin_api_gateway_tenant_activation_options.http_method
  status_code   = aws_api_gateway_method_response.admin_api_gateway_tenant_activation_options_response.status_code
  
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
    "method.response.header.Access-Control-Allow-Methods" = "'DELETE,GET,HEAD,OPTIONS,PATCH,POST,PUT'"
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,Authorization,X-Amz-Date,X-Api-Key,X-Amz-Security-Token'"
  }
}

# GET /tenants
resource "aws_api_gateway_method" "admin_api_gateway_get_tenants" {
  rest_api_id   = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id   = aws_api_gateway_resource.admin_api_gateway_tenants.id
  http_method   = "GET"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.admin_api_gateway_authorizer.id
  # api_key_required = true
}

resource "aws_api_gateway_method_response" "admin_api_gateway_get_tenants_response" {
  rest_api_id   = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id   = aws_api_gateway_resource.admin_api_gateway_tenants.id
  http_method   = aws_api_gateway_method.admin_api_gateway_get_tenants.http_method
  status_code   = "200"
  
  response_models = {
    "application/json" = "Empty"
  }
  
}

resource "aws_api_gateway_integration" "admin_api_gateway_get_tenants_integration" {
  rest_api_id             = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id             = aws_api_gateway_resource.admin_api_gateway_tenants.id
  http_method             = aws_api_gateway_method.admin_api_gateway_get_tenants.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.get_tenants_function_invocation_arn
}

# OPTIONS /tenants
resource "aws_api_gateway_method" "admin_api_gateway_tenants_options" {
  rest_api_id   = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id   = aws_api_gateway_resource.admin_api_gateway_tenants.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "admin_api_gateway_tenants_options_integration" {
  rest_api_id             = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id             = aws_api_gateway_resource.admin_api_gateway_tenants.id
  http_method             = aws_api_gateway_method.admin_api_gateway_tenants_options.http_method
  type                    = "MOCK"
  request_templates = {
    "application/json" = "{\"statusCode\": 200}"
  }
  passthrough_behavior = "WHEN_NO_MATCH"
}

resource "aws_api_gateway_method_response" "admin_api_gateway_tenants_options_response" {
  rest_api_id   = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id   = aws_api_gateway_resource.admin_api_gateway_tenants.id
  http_method   = aws_api_gateway_method.admin_api_gateway_tenants_options.http_method
  status_code   = "200"
  
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin"  = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Headers" = true
  }
}

resource "aws_api_gateway_integration_response" "admin_api_gateway_tenants_options_integration_response" {
  rest_api_id   = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id   = aws_api_gateway_resource.admin_api_gateway_tenants.id
  http_method   = aws_api_gateway_method.admin_api_gateway_tenants_options.http_method
  status_code   = aws_api_gateway_method_response.admin_api_gateway_tenants_options_response.status_code
  
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
    "method.response.header.Access-Control-Allow-Methods" = "'DELETE,GET,HEAD,OPTIONS,PATCH,POST,PUT'"
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,Authorization,X-Amz-Date,X-Api-Key,X-Amz-Security-Token'"
  }
}

# GET /tenant/{tenantid}
resource "aws_api_gateway_method" "admin_api_gateway_get_tenant" {
  rest_api_id   = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id   = aws_api_gateway_resource.admin_api_gateway_tenant_id.id
  http_method   = "GET"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.admin_api_gateway_authorizer.id
}

resource "aws_api_gateway_method_response" "admin_api_gateway_get_tenant_response" {
  rest_api_id   = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id   = aws_api_gateway_resource.admin_api_gateway_tenant_id.id
  http_method   = aws_api_gateway_method.admin_api_gateway_get_tenant.http_method
  status_code   = "200"
  
  response_models = {
    "application/json" = "Empty"
  }
  
}

resource "aws_api_gateway_integration" "admin_api_gateway_get_tenant_integration" {
  rest_api_id             = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id             = aws_api_gateway_resource.admin_api_gateway_tenant_id.id
  http_method             = aws_api_gateway_method.admin_api_gateway_get_tenant.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.get_tenant_function_invocation_arn
}

# POST /user
resource "aws_api_gateway_method" "admin_api_gateway_create_user_post" {
  rest_api_id   = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id   = aws_api_gateway_resource.admin_api_gateway_user.id
  http_method   = "POST"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.admin_api_gateway_authorizer.id
}

resource "aws_api_gateway_method_response" "admin_api_gateway_create_user_post_response" {
  rest_api_id   = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id   = aws_api_gateway_resource.admin_api_gateway_user.id
  http_method   = aws_api_gateway_method.admin_api_gateway_create_user_post.http_method
  status_code   = "200"
  
  response_models = {
    "application/json" = "Empty"
  }
  
}

resource "aws_api_gateway_integration" "admin_api_gateway_create_user_integration" {
  rest_api_id             = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id             = aws_api_gateway_resource.admin_api_gateway_user.id
  http_method             = aws_api_gateway_method.admin_api_gateway_create_user_post.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.create_user_function_invocation_arn
}

# GET /users
resource "aws_api_gateway_method" "admin_api_gateway_get_users" {
  rest_api_id   = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id   = aws_api_gateway_resource.admin_api_gateway_users.id
  http_method   = "GET"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.admin_api_gateway_authorizer.id
}

resource "aws_api_gateway_method_response" "admin_api_gateway_get_users_response" {
  rest_api_id   = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id   = aws_api_gateway_resource.admin_api_gateway_users.id
  http_method   = aws_api_gateway_method.admin_api_gateway_get_users.http_method
  status_code   = "200"
  
  response_models = {
    "application/json" = "Empty"
  }
  
}

resource "aws_api_gateway_integration" "admin_api_gateway_get_users_integration" {
  rest_api_id             = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id             = aws_api_gateway_resource.admin_api_gateway_users.id
  http_method             = aws_api_gateway_method.admin_api_gateway_get_users.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.get_users_function_invocation_arn
}

# OPTIONS /users (CORS)
resource "aws_api_gateway_method" "admin_api_gateway_users_options" {
  rest_api_id   = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id   = aws_api_gateway_resource.admin_api_gateway_users.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "admin_api_gateway_users_options_integration" {
  rest_api_id             = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id             = aws_api_gateway_resource.admin_api_gateway_users.id
  http_method             = aws_api_gateway_method.admin_api_gateway_users_options.http_method
  type                    = "MOCK"
  request_templates = {
    "application/json" = "{\"statusCode\": 200}"
  }
  passthrough_behavior = "WHEN_NO_MATCH"
}

resource "aws_api_gateway_method_response" "admin_api_gateway_users_options_response" {
  rest_api_id   = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id   = aws_api_gateway_resource.admin_api_gateway_users.id
  http_method   = aws_api_gateway_method.admin_api_gateway_users_options.http_method
  status_code   = "200"
  
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin"  = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Headers" = true
  }
}

resource "aws_api_gateway_integration_response" "admin_api_gateway_users_options_integration_response" {
  rest_api_id   = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id   = aws_api_gateway_resource.admin_api_gateway_users.id
  http_method   = aws_api_gateway_method.admin_api_gateway_users_options.http_method
  status_code   = aws_api_gateway_method_response.admin_api_gateway_users_options_response.status_code
  
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
    "method.response.header.Access-Control-Allow-Methods" = "'DELETE,GET,HEAD,OPTIONS,PATCH,POST,PUT'"
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,Authorization,X-Amz-Date,X-Api-Key,X-Amz-Security-Token'"
  }
}

# PUT /users/disable/{tenantid}
resource "aws_api_gateway_method" "admin_api_gateway_disable_users_put" {
  rest_api_id   = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id   = aws_api_gateway_resource.admin_api_gateway_users_disable_tenantid.id
  http_method   = "PUT"
  authorization = "AWS_IAM"
}


resource "aws_api_gateway_integration" "admin_api_gateway_disable_users_put_integration" {
  rest_api_id             = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id             = aws_api_gateway_resource.admin_api_gateway_users_disable_tenantid.id
  http_method             = aws_api_gateway_method.admin_api_gateway_disable_users_put.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = var.disable_users_by_tenant_function_invocation_arn

  request_parameters = {
    "integration.request.header.X-Amz-Invocation-Type" = "'Event'"
  }
  request_templates = {
    "application/json" = "{\"tenantid\": \"$input.params('tenantid')\" }"
  }
}


resource "aws_api_gateway_method_response" "admin_api_gateway_disable_users_put_response" {
  rest_api_id   = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id   = aws_api_gateway_resource.admin_api_gateway_users_disable_tenantid.id
  http_method   = aws_api_gateway_method.admin_api_gateway_disable_users_put.http_method
  status_code   = "200"
  
  response_models = {
    "application/json" = "Empty"
  }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin"  = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Headers" = true
  }
}

resource "aws_api_gateway_integration_response" "admin_api_gateway_disable_users_put_integration_response" {
  rest_api_id   = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id   = aws_api_gateway_resource.admin_api_gateway_users_disable_tenantid.id
  http_method   = aws_api_gateway_method.admin_api_gateway_disable_users_put.http_method
  status_code   = aws_api_gateway_method_response.admin_api_gateway_disable_users_put_response.status_code
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
    "method.response.header.Access-Control-Allow-Methods" = "'DELETE,GET,HEAD,OPTIONS,PATCH,POST,PUT'"
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,Authorization,X-Amz-Date,X-Api-Key,X-Amz-Security-Token'"
  }
  depends_on = [ aws_api_gateway_integration.admin_api_gateway_disable_users_put_integration ]
}

# OPTIONS /users/disable/{tenantid} (CORS)
resource "aws_api_gateway_method" "admin_api_gateway_disable_users_put_options" {
  rest_api_id   = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id   = aws_api_gateway_resource.admin_api_gateway_users_disable_tenantid.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "admin_api_gateway_disable_users_put_options_integration" {
  rest_api_id             = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id             = aws_api_gateway_resource.admin_api_gateway_users_disable_tenantid.id
  http_method             = aws_api_gateway_method.admin_api_gateway_disable_users_put_options.http_method
  type                    = "MOCK"
  request_templates = {
    "application/json" = "{\"statusCode\": 200}"
  }
  passthrough_behavior = "WHEN_NO_MATCH"
}

resource "aws_api_gateway_method_response" "admin_api_gateway_disable_users_put_options_response" {
  rest_api_id   = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id   = aws_api_gateway_resource.admin_api_gateway_users_disable_tenantid.id
  http_method   = aws_api_gateway_method.admin_api_gateway_disable_users_put_options.http_method
  status_code   = "200"
  
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin"  = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Headers" = true
  }
}

resource "aws_api_gateway_integration_response" "admin_api_gateway_disable_users_put_options_integration_response" {
  rest_api_id   = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id   = aws_api_gateway_resource.admin_api_gateway_users_disable_tenantid.id
  http_method   = aws_api_gateway_method.admin_api_gateway_disable_users_put_options.http_method
  status_code   = aws_api_gateway_method_response.admin_api_gateway_disable_users_put_options_response.status_code
  
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
    "method.response.header.Access-Control-Allow-Methods" = "'DELETE,GET,HEAD,OPTIONS,PATCH,POST,PUT'"
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,Authorization,X-Amz-Date,X-Api-Key,X-Amz-Security-Token'"
  }
}

# PUT /users/enable/{tenantid}
resource "aws_api_gateway_method" "admin_api_gateway_enable_users_put" {
  rest_api_id   = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id   = aws_api_gateway_resource.admin_api_gateway_users_enable_tenantid.id
  http_method   = "PUT"
  authorization = "AWS_IAM"
}

resource "aws_api_gateway_integration" "admin_api_gateway_enable_users_integration" {
  rest_api_id             = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id             = aws_api_gateway_resource.admin_api_gateway_users_enable_tenantid.id
  http_method             = aws_api_gateway_method.admin_api_gateway_enable_users_put.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = var.enable_users_by_tenant_function_invocation_arn

  request_parameters = {
    "integration.request.header.X-Amz-Invocation-Type" = "'Event'"
  }
  request_templates = {
    "application/json" = "{\"tenantid\": \"$input.params('tenantid')\" }"
  }
}

resource "aws_api_gateway_method_response" "admin_api_gateway_enable_users_put_response" {
  rest_api_id   = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id   = aws_api_gateway_resource.admin_api_gateway_users_enable_tenantid.id
  http_method   = aws_api_gateway_method.admin_api_gateway_enable_users_put.http_method
  status_code   = "200"
  
  response_models = {
    "application/json" = "Empty"
  }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin"  = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Headers" = true
  }
}

resource "aws_api_gateway_integration_response" "admin_api_gateway_enable_users_integration_response" {
  rest_api_id   = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id   = aws_api_gateway_resource.admin_api_gateway_users_enable_tenantid.id
  http_method   = aws_api_gateway_method.admin_api_gateway_enable_users_put.http_method
  status_code   = aws_api_gateway_method_response.admin_api_gateway_enable_users_put_response.status_code
  
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
    "method.response.header.Access-Control-Allow-Methods" = "'DELETE,GET,HEAD,OPTIONS,PATCH,POST,PUT'"
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,Authorization,X-Amz-Date,X-Api-Key,X-Amz-Security-Token'"
  }

  depends_on = [ aws_api_gateway_integration.admin_api_gateway_enable_users_integration ]
}

# OPTIONS /users/enable/{tenantid} (CORS)
resource "aws_api_gateway_method" "admin_api_gateway_enable_users_put_options" {
  rest_api_id   = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id   = aws_api_gateway_resource.admin_api_gateway_users_enable_tenantid.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "admin_api_gateway_enable_users_put_options_integration" {
  rest_api_id             = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id             = aws_api_gateway_resource.admin_api_gateway_users_enable_tenantid.id
  http_method             = aws_api_gateway_method.admin_api_gateway_enable_users_put_options.http_method
  type                    = "MOCK"
  request_templates = {
    "application/json" = "{\"statusCode\": 200}"
  }
  passthrough_behavior = "WHEN_NO_MATCH"
}

resource "aws_api_gateway_method_response" "admin_api_gateway_enable_users_put_options_response" {
  rest_api_id   = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id   = aws_api_gateway_resource.admin_api_gateway_users_enable_tenantid.id
  http_method   = aws_api_gateway_method.admin_api_gateway_enable_users_put_options.http_method
  status_code   = "200"
  
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin"  = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Headers" = true
  }
}

resource "aws_api_gateway_integration_response" "admin_api_gateway_enable_users_put_options_integration_response" {
  rest_api_id   = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id   = aws_api_gateway_resource.admin_api_gateway_users_enable_tenantid.id
  http_method   = aws_api_gateway_method.admin_api_gateway_enable_users_put_options.http_method
  status_code   = aws_api_gateway_method_response.admin_api_gateway_enable_users_put_options_response.status_code
  
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
    "method.response.header.Access-Control-Allow-Methods" = "'DELETE,GET,HEAD,OPTIONS,PATCH,POST,PUT'"
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,Authorization,X-Amz-Date,X-Api-Key,X-Amz-Security-Token'"
  }
}


# POST /tenant
resource "aws_api_gateway_method" "admin_api_gateway_create_tenant_post" {
  rest_api_id      = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id      = aws_api_gateway_resource.admin_api_gateway_tenant.id
  http_method      = "POST"
  authorization    = "AWS_IAM"
}

resource "aws_api_gateway_method_response" "admin_api_gateway_create_tenant_post_response" {
  rest_api_id   = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id   = aws_api_gateway_resource.admin_api_gateway_tenant.id
  http_method   = aws_api_gateway_method.admin_api_gateway_create_tenant_post.http_method
  status_code   = "200"
  
  response_models = {
    "application/json" = "Empty"
  }
  
}

resource "aws_api_gateway_integration" "admin_api_gateway_create_tenant_integration" {
  rest_api_id             = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id             = aws_api_gateway_resource.admin_api_gateway_tenant.id
  http_method             = aws_api_gateway_method.admin_api_gateway_create_tenant_post.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.create_tenant_function_invocation_arn
}

# OPTIONS /tenant (CORS)
resource "aws_api_gateway_method" "admin_api_gateway_tenant_options" {
  rest_api_id   = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id   = aws_api_gateway_resource.admin_api_gateway_tenant.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "admin_api_gateway_tenant_options_integration" {
  rest_api_id             = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id             = aws_api_gateway_resource.admin_api_gateway_tenant.id
  http_method             = aws_api_gateway_method.admin_api_gateway_tenant_options.http_method
  type                    = "MOCK"
  request_templates = {
    "application/json" = "{\"statusCode\": 200}"
  }
  passthrough_behavior = "WHEN_NO_MATCH"
}

resource "aws_api_gateway_method_response" "admin_api_gateway_tenant_options_response" {
  rest_api_id   = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id   = aws_api_gateway_resource.admin_api_gateway_tenant.id
  http_method   = aws_api_gateway_method.admin_api_gateway_tenant_options.http_method
  status_code   = "200"
  
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin"  = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Headers" = true
  }
}

resource "aws_api_gateway_integration_response" "admin_api_gateway_tenant_options_integration_response" {
  rest_api_id   = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id   = aws_api_gateway_resource.admin_api_gateway_tenant.id
  http_method   = aws_api_gateway_method.admin_api_gateway_tenant_options.http_method
  status_code   = aws_api_gateway_method_response.admin_api_gateway_tenant_options_response.status_code
  
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
    "method.response.header.Access-Control-Allow-Methods" = "'DELETE,GET,HEAD,OPTIONS,PATCH,POST,PUT'"
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,Authorization,X-Amz-Date,X-Api-Key,X-Amz-Security-Token'"
  }
}

# PUT /tenant/{tenantid} - Update tenant
resource "aws_api_gateway_method" "admin_api_gateway_update_tenant_put" {
  rest_api_id   = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id   = aws_api_gateway_resource.admin_api_gateway_tenant_id.id
  http_method   = "PUT"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.admin_api_gateway_authorizer.id
}

resource "aws_api_gateway_method_response" "admin_api_gateway_update_tenant_put_response" {
  rest_api_id   = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id   = aws_api_gateway_resource.admin_api_gateway_tenant_id.id
  http_method   = aws_api_gateway_method.admin_api_gateway_update_tenant_put.http_method
  status_code   = "200"
  
  response_models = {
    "application/json" = "Empty"
  }
  
}

resource "aws_api_gateway_integration" "admin_api_gateway_update_tenant_integration" {
  rest_api_id             = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id             = aws_api_gateway_resource.admin_api_gateway_tenant_id.id
  http_method             = aws_api_gateway_method.admin_api_gateway_update_tenant_put.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.update_tenant_function_invocation_arn
}

# DELETE /tenant/{tenantid} - Deactivate tenant
resource "aws_api_gateway_method" "admin_api_gateway_deactivate_tenant_delete" {
  rest_api_id   = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id   = aws_api_gateway_resource.admin_api_gateway_tenant_id.id
  http_method   = "DELETE"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.admin_api_gateway_authorizer.id
}

resource "aws_api_gateway_method_response" "admin_api_gateway_deactivate_tenant_delete_response" {
  rest_api_id   = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id   = aws_api_gateway_resource.admin_api_gateway_tenant_id.id
  http_method   = aws_api_gateway_method.admin_api_gateway_deactivate_tenant_delete.http_method
  status_code   = "200"
  
  response_models = {
    "application/json" = "Empty"
  }
  
}

resource "aws_api_gateway_integration" "admin_api_gateway_deactivate_tenant_integration" {
  rest_api_id             = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id             = aws_api_gateway_resource.admin_api_gateway_tenant_id.id
  http_method             = aws_api_gateway_method.admin_api_gateway_deactivate_tenant_delete.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.deactivate_tenant_function_invocation_arn
}

# OPTIONS /tenant/{tenantid} (CORS)
resource "aws_api_gateway_method" "admin_api_gateway_tenant_id_options" {
  rest_api_id   = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id   = aws_api_gateway_resource.admin_api_gateway_tenant_id.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "admin_api_gateway_tenant_id_options_integration" {
  rest_api_id             = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id             = aws_api_gateway_resource.admin_api_gateway_tenant_id.id
  http_method             = aws_api_gateway_method.admin_api_gateway_tenant_id_options.http_method
  type                    = "MOCK"
  request_templates = {
    "application/json" = "{\"statusCode\": 200}"
  }
  passthrough_behavior = "WHEN_NO_MATCH"
}

resource "aws_api_gateway_method_response" "admin_api_gateway_tenant_id_options_response" {
  rest_api_id   = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id   = aws_api_gateway_resource.admin_api_gateway_tenant_id.id
  http_method   = aws_api_gateway_method.admin_api_gateway_tenant_id_options.http_method
  status_code   = "200"
  
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin"  = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Headers" = true
  }
}

resource "aws_api_gateway_integration_response" "admin_api_gateway_tenant_id_options_integration_response" {
  rest_api_id   = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id   = aws_api_gateway_resource.admin_api_gateway_tenant_id.id
  http_method   = aws_api_gateway_method.admin_api_gateway_tenant_id_options.http_method
  status_code   = aws_api_gateway_method_response.admin_api_gateway_tenant_id_options_response.status_code
  
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
    "method.response.header.Access-Control-Allow-Methods" = "'DELETE,GET,HEAD,OPTIONS,PATCH,POST,PUT'"
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,Authorization,X-Amz-Date,X-Api-Key,X-Amz-Security-Token'"
  }
}

# GET /user/{username} - Get user
resource "aws_api_gateway_method" "admin_api_gateway_get_user_get" {
  rest_api_id   = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id   = aws_api_gateway_resource.admin_api_gateway_user_username.id
  http_method   = "GET"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.admin_api_gateway_authorizer.id
}

resource "aws_api_gateway_method_response" "admin_api_gateway_get_user_get_response" {
  rest_api_id   = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id   = aws_api_gateway_resource.admin_api_gateway_user_username.id
  http_method   = aws_api_gateway_method.admin_api_gateway_get_user_get.http_method
  status_code   = "200"
  
  response_models = {
    "application/json" = "Empty"
  }
  
}

resource "aws_api_gateway_integration" "admin_api_gateway_get_user_integration" {
  rest_api_id             = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id             = aws_api_gateway_resource.admin_api_gateway_user_username.id
  http_method             = aws_api_gateway_method.admin_api_gateway_get_user_get.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.get_user_function_invocation_arn
}

# PUT /user/{username} - Update user
resource "aws_api_gateway_method" "admin_api_gateway_update_user_put" {
  rest_api_id   = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id   = aws_api_gateway_resource.admin_api_gateway_user_username.id
  http_method   = "PUT"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.admin_api_gateway_authorizer.id
}

resource "aws_api_gateway_method_response" "admin_api_gateway_update_user_put_response" {
  rest_api_id   = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id   = aws_api_gateway_resource.admin_api_gateway_user_username.id
  http_method   = aws_api_gateway_method.admin_api_gateway_update_user_put.http_method
  status_code   = "200"
  
  response_models = {
    "application/json" = "Empty"
  }
  
}

resource "aws_api_gateway_integration" "admin_api_gateway_update_user_integration" {
  rest_api_id             = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id             = aws_api_gateway_resource.admin_api_gateway_user_username.id
  http_method             = aws_api_gateway_method.admin_api_gateway_update_user_put.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.update_user_function_invocation_arn
}

# DELETE /user/{username} - Disable user
resource "aws_api_gateway_method" "admin_api_gateway_disable_user_delete" {
  rest_api_id   = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id   = aws_api_gateway_resource.admin_api_gateway_user_username.id
  http_method   = "DELETE"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.admin_api_gateway_authorizer.id
}

resource "aws_api_gateway_method_response" "admin_api_gateway_disable_user_delete_response" {
  rest_api_id   = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id   = aws_api_gateway_resource.admin_api_gateway_user_username.id
  http_method   = aws_api_gateway_method.admin_api_gateway_disable_user_delete.http_method
  status_code   = "200"
  
  response_models = {
    "application/json" = "Empty"
  }
  
}

resource "aws_api_gateway_integration" "admin_api_gateway_disable_user_integration" {
  rest_api_id             = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id             = aws_api_gateway_resource.admin_api_gateway_user_username.id
  http_method             = aws_api_gateway_method.admin_api_gateway_disable_user_delete.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.disable_user_function_invocation_arn
}

# OPTIONS /user(CORS)
resource "aws_api_gateway_method" "admin_api_gateway_user_options" {
  rest_api_id   = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id   = aws_api_gateway_resource.admin_api_gateway_user.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "admin_api_gateway_user_options_integration" {
  rest_api_id             = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id             = aws_api_gateway_resource.admin_api_gateway_user.id
  http_method             = aws_api_gateway_method.admin_api_gateway_user_options.http_method
  type                    = "MOCK"
  request_templates = {
    "application/json" = "{\"statusCode\": 200}"
  }
  passthrough_behavior = "WHEN_NO_MATCH"
}

resource "aws_api_gateway_method_response" "admin_api_gateway_user_options_response" {
  rest_api_id   = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id   = aws_api_gateway_resource.admin_api_gateway_user.id
  http_method   = aws_api_gateway_method.admin_api_gateway_user_options.http_method
  status_code   = "200"
  
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin"  = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Headers" = true
  }
}

resource "aws_api_gateway_integration_response" "admin_api_gateway_user_options_integration_response" {
  rest_api_id   = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id   = aws_api_gateway_resource.admin_api_gateway_user.id
  http_method   = aws_api_gateway_method.admin_api_gateway_user_options.http_method
  status_code   = aws_api_gateway_method_response.admin_api_gateway_user_options_response.status_code
  
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
    "method.response.header.Access-Control-Allow-Methods" = "'DELETE,GET,HEAD,OPTIONS,PATCH,POST,PUT'"
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,Authorization,X-Amz-Date,X-Api-Key,X-Amz-Security-Token'"
  }
}

# POST /user/tenant-admin - Create tenant admin user
resource "aws_api_gateway_method" "admin_api_gateway_create_tenant_admin_post" {
  rest_api_id   = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id   = aws_api_gateway_resource.admin_api_gateway_user_tenant_admin.id
  http_method   = "POST"
  authorization = "AWS_IAM"
}

resource "aws_api_gateway_method_response" "admin_api_gateway_create_tenant_admin_post_response" {
  rest_api_id   = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id   = aws_api_gateway_resource.admin_api_gateway_user_tenant_admin.id
  http_method   = aws_api_gateway_method.admin_api_gateway_create_tenant_admin_post.http_method
  status_code   = "200"
  
  response_models = {
    "application/json" = "Empty"
  }
  
}

resource "aws_api_gateway_integration" "admin_api_gateway_create_tenant_admin_integration" {
  rest_api_id             = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id             = aws_api_gateway_resource.admin_api_gateway_user_tenant_admin.id
  http_method             = aws_api_gateway_method.admin_api_gateway_create_tenant_admin_post.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.create_tenant_admin_user_function_invocation_arn
}

# OPTIONS /user/tenant-admin (CORS)
resource "aws_api_gateway_method" "admin_api_gateway_user_tenant_admin_options" {
  rest_api_id   = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id   = aws_api_gateway_resource.admin_api_gateway_user_tenant_admin.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "admin_api_gateway_user_tenant_admin_options_integration" {
  rest_api_id             = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id             = aws_api_gateway_resource.admin_api_gateway_user_tenant_admin.id
  http_method             = aws_api_gateway_method.admin_api_gateway_user_tenant_admin_options.http_method
  type                    = "MOCK"
  request_templates = {
    "application/json" = "{\"statusCode\": 200}"
  }
  passthrough_behavior = "WHEN_NO_MATCH"
}

resource "aws_api_gateway_method_response" "admin_api_gateway_user_tenant_admin_options_response" {
  rest_api_id   = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id   = aws_api_gateway_resource.admin_api_gateway_user_tenant_admin.id
  http_method   = aws_api_gateway_method.admin_api_gateway_user_tenant_admin_options.http_method
  status_code   = "200"
  
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin"  = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Headers" = true
  }
}

resource "aws_api_gateway_integration_response" "admin_api_gateway_user_tenant_admin_options_integration_response" {
  rest_api_id   = aws_api_gateway_rest_api.admin_api_gateway.id
  resource_id   = aws_api_gateway_resource.admin_api_gateway_user_tenant_admin.id
  http_method   = aws_api_gateway_method.admin_api_gateway_user_tenant_admin_options.http_method
  status_code   = aws_api_gateway_method_response.admin_api_gateway_user_tenant_admin_options_response.status_code
  
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
    "method.response.header.Access-Control-Allow-Methods" = "'DELETE,GET,HEAD,OPTIONS,PATCH,POST,PUT'"
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,Authorization,X-Amz-Date,X-Api-Key,X-Amz-Security-Token'"
  }
}