# Using terraform-aws-modules/dynamodb-table module
module "tenant_details_table" {
  source  = "terraform-aws-modules/dynamodb-table/aws"
  version = "~> 4.0.0"

  # Explicitly set the table name to fix linting errors
  name     = "TenantDetails"
  hash_key = "tenantId"
  billing_mode = "PAY_PER_REQUEST"

  attributes = [
    {
      name = "tenantId"
      type = "S"
    },
    {
      name = "tenantName"
      type = "S"
    }
  ]

  global_secondary_indexes = [
    {
      name               = "ServerlessSaas-TenantConfig"
      hash_key           = "tenantName"
      projection_type    = "INCLUDE"
      non_key_attributes = ["userPoolId", "appClientId", "apiGatewayUrl"]
    }
  ]
}
