# resources.tf

# /registration
resource "aws_api_gateway_resource" "admin_api_gateway_registration" {
  rest_api_id = aws_api_gateway_rest_api.admin_api_gateway.id
  parent_id   = aws_api_gateway_rest_api.admin_api_gateway.root_resource_id
  path_part   = "registration"
}

# /tenant
resource "aws_api_gateway_resource" "admin_api_gateway_tenant" {
  rest_api_id = aws_api_gateway_rest_api.admin_api_gateway.id
  parent_id   = aws_api_gateway_rest_api.admin_api_gateway.root_resource_id
  path_part   = "tenant"
}

# /tenant/activation
resource "aws_api_gateway_resource" "admin_api_gateway_tenant_activation_parent" {
  rest_api_id = aws_api_gateway_rest_api.admin_api_gateway.id
  parent_id   = aws_api_gateway_resource.admin_api_gateway_tenant.id
  path_part   = "activation"
}

# /tenant/activation/{tenantid}
resource "aws_api_gateway_resource" "admin_api_gateway_tenant_activation" {
  rest_api_id = aws_api_gateway_rest_api.admin_api_gateway.id
  parent_id   = aws_api_gateway_resource.admin_api_gateway_tenant_activation_parent.id
  path_part   = "{tenantid}"
}

# /tenants
resource "aws_api_gateway_resource" "admin_api_gateway_tenants" {
  rest_api_id = aws_api_gateway_rest_api.admin_api_gateway.id
  parent_id   = aws_api_gateway_rest_api.admin_api_gateway.root_resource_id
  path_part   = "tenants"
}

# /tenant/{tenantid}
resource "aws_api_gateway_resource" "admin_api_gateway_tenant_id" {
  rest_api_id = aws_api_gateway_rest_api.admin_api_gateway.id
  parent_id   = aws_api_gateway_resource.admin_api_gateway_tenant.id
  path_part   = "{tenantid}"
}

# /user
resource "aws_api_gateway_resource" "admin_api_gateway_user" {
  rest_api_id = aws_api_gateway_rest_api.admin_api_gateway.id
  parent_id   = aws_api_gateway_rest_api.admin_api_gateway.root_resource_id
  path_part   = "user"
}

# /user/{username}
resource "aws_api_gateway_resource" "admin_api_gateway_user_username" {
  rest_api_id = aws_api_gateway_rest_api.admin_api_gateway.id
  parent_id   = aws_api_gateway_resource.admin_api_gateway_user.id
  path_part   = "{username}"
}

# /user/tenant-admin
resource "aws_api_gateway_resource" "admin_api_gateway_user_tenant_admin" {
  rest_api_id = aws_api_gateway_rest_api.admin_api_gateway.id
  parent_id   = aws_api_gateway_resource.admin_api_gateway_user.id
  path_part   = "tenant-admin"
}

# /users
resource "aws_api_gateway_resource" "admin_api_gateway_users" {
  rest_api_id = aws_api_gateway_rest_api.admin_api_gateway.id
  parent_id   = aws_api_gateway_rest_api.admin_api_gateway.root_resource_id
  path_part   = "users"
}

# /users/disable
resource "aws_api_gateway_resource" "admin_api_gateway_users_disable" {
  rest_api_id = aws_api_gateway_rest_api.admin_api_gateway.id
  parent_id   = aws_api_gateway_resource.admin_api_gateway_users.id
  path_part   = "disable"
}

# /users/disable/{tenantid}
resource "aws_api_gateway_resource" "admin_api_gateway_users_disable_tenantid" {
  rest_api_id = aws_api_gateway_rest_api.admin_api_gateway.id
  parent_id   = aws_api_gateway_resource.admin_api_gateway_users_disable.id
  path_part   = "{tenantid}"
}

# /users/enable
resource "aws_api_gateway_resource" "admin_api_gateway_users_enable" {
  rest_api_id = aws_api_gateway_rest_api.admin_api_gateway.id
  parent_id   = aws_api_gateway_resource.admin_api_gateway_users.id
  path_part   = "enable"
}

# /users/enable/{tenantid}
resource "aws_api_gateway_resource" "admin_api_gateway_users_enable_tenantid" {
  rest_api_id = aws_api_gateway_rest_api.admin_api_gateway.id
  parent_id   = aws_api_gateway_resource.admin_api_gateway_users_enable.id
  path_part   = "{tenantid}"
}