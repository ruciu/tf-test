resource "aws_api_gateway_rest_api" "gateway" {
  name        = "TaskGateway"
  description = "Task API Gateway"
}

resource "aws_api_gateway_resource" "resource" {
  rest_api_id = "${aws_api_gateway_rest_api.gateway.id}"
  parent_id   = "${aws_api_gateway_rest_api.gateway.root_resource_id}"
  path_part   = "email"
}

resource "aws_api_gateway_method" "method" {
  rest_api_id   = "${aws_api_gateway_rest_api.gateway.id}"
  resource_id   = "${aws_api_gateway_resource.resource.id}"
  http_method   = "POST"
  authorization = "NONE"
  request_models {
    "application/json" = "${aws_api_gateway_model.email_model.name}"
  }
}

resource "aws_api_gateway_model" "email_model" {
  rest_api_id  = "${aws_api_gateway_rest_api.gateway.id}"
  name         = "email"
  description  = "Email model"
  content_type = "application/json"

  schema = <<EOF
{
  "$schema": "http://json-schema.org/draft-04/schema#",
  "description": "",
  "type": "object",
  "properties": {
    "name": {
      "type": "string",
      "minLength": 1
    },
    "email": {
      "type": "string",
      "minLength": 1
    },
    "message": {
      "type": "string",
      "minLength": 1
    }
  },
  "required": [
    "name",
    "email",
    "message"
  ]
}
EOF
}

resource "aws_api_gateway_integration" "lambda" {
  rest_api_id = "${aws_api_gateway_rest_api.gateway.id}"
  resource_id = "${aws_api_gateway_method.method.resource_id}"
  http_method = "${aws_api_gateway_method.method.http_method}"

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "${var.LAMBDA_INVOKE_ARN}"
}

resource "aws_api_gateway_deployment" "deployment" {
  depends_on = [
    "aws_api_gateway_integration.lambda",
  ]

  rest_api_id = "${aws_api_gateway_rest_api.gateway.id}"
  stage_name  = "test"
}