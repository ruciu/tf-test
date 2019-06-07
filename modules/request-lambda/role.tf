resource "aws_iam_role" "lambda_exec" {
  name = "lambda_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "allow-dynamo" {
  name = "allow-dybani-policy"
  role = "${aws_iam_role.lambda_exec.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [{
      "Sid": "SpecificTable",
      "Effect": "Allow",
      "Action": [
        "dynamodb:PutItem"
      ],
      "Resource": [
        "${var.DYNAMO_TABLE_ARN}"
      ]
    }
  ]
}
EOF
}