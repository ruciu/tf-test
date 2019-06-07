resource "aws_dynamodb_table" "dynamodb-table" {
  name = "Email"
  billing_mode = "PROVISIONED"
  read_capacity = 1
  write_capacity = 1
  hash_key = "Name"
  range_key = "Email"

  attribute = [
    {
      name = "Name"
      type = "S"
    },
    {
      name = "Email"
      type = "S"
    }
  ]

  stream_enabled = true
  stream_view_type = "NEW_IMAGE"
}