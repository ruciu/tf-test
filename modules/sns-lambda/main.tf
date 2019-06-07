resource "aws_lambda_event_source_mapping" "dynamo_source" {
  event_source_arn  = "${var.DYNAMODB_STREAM_ARN}"
  function_name     = "${aws_lambda_function.lambda.arn}"
  starting_position = "LATEST"
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "${path.module}/function"
  output_path = "${path.module}/sns-lambda.zip"
}

resource "aws_lambda_function" "lambda" {
  filename         = "${data.archive_file.lambda_zip.output_path}"
  source_code_hash = "${data.archive_file.lambda_zip.output_base64sha256}"
  description      = "Handles HTTP Request"
  function_name    = "sns-lambda"
  role             = "${aws_iam_role.sns_lambda_role.arn}"
  handler          = "index.handler"
  runtime          = "nodejs8.10"
  timeout          = "10"
  memory_size      = "128"

  environment {
    variables = {
      TOPIC_ARN = "${var.TOPIC_ARN}"
    }
  }
}