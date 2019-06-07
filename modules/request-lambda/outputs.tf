output "LAMBDA_INVOKE_ARN" {
  value = "${aws_lambda_function.lambda.invoke_arn}"
}

output "LAMBDA_ARN" {
  value = "${aws_lambda_function.lambda.arn}"
}