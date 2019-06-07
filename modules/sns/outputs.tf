output "SNS_ARN" {
  value = "${aws_sns_topic.dynamo_sns.arn}"
}