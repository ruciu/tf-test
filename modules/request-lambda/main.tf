data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "${path.module}/function"
  output_path = "${path.module}/request-lambda.zip"
}

resource "aws_lambda_function" "lambda" {
  filename         = "${data.archive_file.lambda_zip.output_path}"
  source_code_hash = "${data.archive_file.lambda_zip.output_base64sha256}"
  description      = "Handles HTTP Request"
  function_name    = "request-lambda"
  role             = "${aws_iam_role.lambda_exec.arn}"
  handler          = "index.handler"
  runtime          = "nodejs8.10"
  timeout          = "10"
  memory_size      = "128"
}