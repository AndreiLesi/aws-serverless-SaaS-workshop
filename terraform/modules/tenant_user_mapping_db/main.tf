module "tenant_user_mapping_table" {
  source  = "terraform-aws-modules/dynamodb-table/aws"
  version = "~> 4.0.0"

  name     = "TenantUserMapping"
  hash_key     = "tenantId"
  range_key    = "userName"
  billing_mode = "PAY_PER_REQUEST"

  attributes = [
    {
      name = "tenantId"
      type = "S"
    },
    {
      name = "userName"
      type = "S"
    }
  ]

  global_secondary_indexes = [
    {
      name               = "UserName"
      hash_key           = "userName"
      range_key          = "tenantId"
      projection_type    = "ALL"
    }
  ]
}
