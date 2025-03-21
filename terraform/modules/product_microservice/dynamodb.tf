  module "product_table" {
  source  = "terraform-aws-modules/dynamodb-table/aws"
  version = "~> 4.0.0"

  name     = "Product-pooled"
  hash_key = "shardId"
  range_key = "productId"
  billing_mode = "PROVISIONED"
  
  read_capacity  = 5
  write_capacity = 5

  attributes = [
    {
      name = "shardId"
      type = "S"
    },
    {
      name = "productId"
      type = "S"
    }
  ]
}