/**
 * User Authentication Module
 * 
 * This module creates the Cognito User Pools and related resources for user authentication.
 * It implements two separate user pools:
 * 1. PooledTenant-ServerlessSaaSUserPool - For tenant users
 * 2. OperationUsers-ServerlessSaaSUserPool - For system administrators
 *
 * Resources to be created:
 * - Cognito User Pools
 * - User Pool Clients
 * - User Pool Domains
 * - User Groups
 * - Initial admin user
 */

# Tenant User Pool for multi-tenant application users
resource "aws_cognito_user_pool" "tenant_user_pool" {
  name = "PooledTenant-ServerlessSaaSUserPool"

  alias_attributes = ["email"]
  auto_verified_attributes = ["email"]

  account_recovery_setting {
    recovery_mechanism {
      name = "verified_email"
      priority = 1
    }
  }

  admin_create_user_config {
    invite_message_template {
      email_message = "Thank you for signing up.\nYour username is {username} and your temporary password is {####}."
      email_subject = "Your temporary password for the tenant UI application"
      sms_message = "Your username is {username} and temporary password is {####}."
    }
  }

  # Custom attributes for tenant management
  schema {
    name                = "email"
    attribute_data_type = "String"
    required            = true
    mutable             = true
    string_attribute_constraints {
      min_length = 1
      max_length = 256
    }
  }
   
   schema {
      name                = "tenantId"
      attribute_data_type = "String"
      mutable             = true
      required            = false
      string_attribute_constraints {
        min_length = 1
        max_length = 256
      }
    }

    schema {
      name                = "userRole"
      attribute_data_type = "String"
      mutable             = true
      required            = false
      string_attribute_constraints {
        min_length = 1
        max_length = 256
      }
    }
}

resource "aws_cognito_user_pool_client" "tenant_user_pool_client" {
  name                                 = "ServerlessSaaSClient"
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = ["code", "implicit"]
  allowed_oauth_scopes                 = ["email", "openid", "profile"]
  callback_urls                        = [var.tenant_callback_url]
  default_redirect_uri                 = var.tenant_callback_url
  supported_identity_providers         = ["COGNITO"]
  write_attributes = ["email", "custom:tenantId", "custom:userRole"]

  user_pool_id = aws_cognito_user_pool.tenant_user_pool.id
}

resource "aws_cognito_user_pool_domain" "tenant_user_pool_domain" {
  domain       = "pooledtenant-serverlesssas-${data.aws_caller_identity.current.account_id}"
  user_pool_id = aws_cognito_user_pool.tenant_user_pool.id
}



# Operations User Pool for system administrators
resource "aws_cognito_user_pool" "operations_user_pool" {
  name = "OperationUsers-ServerlessSaaSUserPool"

  alias_attributes = ["email"]
  auto_verified_attributes = ["email"]

  account_recovery_setting {
    recovery_mechanism {
      name = "verified_email"
      priority = 1
    }
  }

  admin_create_user_config {
    invite_message_template {
      email_message = "Login to the operations UI application at ${var.admin_callback_url}/ using username {username} and temporary password {####}"
      email_subject = "Your temporary password for the admin UI application"
      sms_message = "Your username is {username} and temporary password is {####}."
    }
  }

  # Custom attributes for operations management
  schema {
    name                = "email"
    attribute_data_type = "String"
    required            = true
    mutable             = true
    string_attribute_constraints {
      min_length = 1
      max_length = 256
    }
    }
   
   schema {
      name                = "tenantId"
      attribute_data_type = "String"
      mutable             = true
      required            = false
      string_attribute_constraints {
        min_length = 1
        max_length = 256
      }
    }

    schema {
      name                = "userRole"
      attribute_data_type = "String"
      mutable             = true
      required            = false
      string_attribute_constraints {
        min_length = 1
        max_length = 256
      }
    }
}

# Operations User Pool Client
resource "aws_cognito_user_pool_client" "operations_user_pool_client" {
  name                                 = "ServerlessSaaSOperationUsersPoolClient"
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = ["code", "implicit"]
  allowed_oauth_scopes                 = ["email", "openid", "profile"]
  callback_urls                        = [var.admin_callback_url]
  logout_urls                          = [var.admin_callback_url]
  supported_identity_providers         = ["COGNITO"]
  write_attributes = ["email", "custom:tenantId", "custom:userRole"]

  user_pool_id = aws_cognito_user_pool.operations_user_pool.id
}

# Operations User Pool Domain
resource "aws_cognito_user_pool_domain" "operations_user_pool_domain" {
  domain       = "operationusers-serverlesssas-${data.aws_caller_identity.current.account_id}"
  user_pool_id = aws_cognito_user_pool.operations_user_pool.id
}

# Operations User Group
resource "aws_cognito_user_group" "operations_system_admins" {
  name         = "SystemAdmins"
  description  = "System administrators group"
  precedence   = 0
  user_pool_id = aws_cognito_user_pool.operations_user_pool.id
}

# Operations User Pool User
resource "aws_cognito_user" "operations_admin_user" {
  username  = "admin"
  desired_delivery_mediums = ["EMAIL"]
  force_alias_creation = true
  attributes = {
    email = var.admin_email
    "tenantId" = "systems_admins"
    "userRole" = var.admin_user_role_name
  }
  
  user_pool_id = aws_cognito_user_pool.operations_user_pool.id
}

# Operations User Pool User Group Membership
resource "aws_cognito_user_in_group" "operations_system_admins" {
  user_pool_id = aws_cognito_user_pool.operations_user_pool.id
  username = aws_cognito_user.operations_admin_user.username
  group_name = aws_cognito_user_group.operations_system_admins.name
}
