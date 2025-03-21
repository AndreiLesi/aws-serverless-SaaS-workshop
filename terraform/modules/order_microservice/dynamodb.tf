  module "order_table" {
  source  = "terraform-aws-modules/dynamodb-table/aws"
  version = "~> 4.0.0"

  name     = "Order-pooled"
  hash_key = "shardId"
  range_key = "orderId"
  billing_mode = "PROVISIONED"
  
  read_capacity  = 5
  write_capacity = 5

  attributes = [
    {
      name = "shardId"
      type = "S"
    },
    {
      name = "orderId"
      type = "S"
    }
  ]
}