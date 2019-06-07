output "DYNAMO_TABLE_ARN" {
  value = "${aws_dynamodb_table.dynamodb-table.arn}"
}

output "STREAM_ARN" {
  value = "${aws_dynamodb_table.dynamodb-table.stream_arn}"
}