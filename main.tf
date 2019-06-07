module "lambda_request" {
  source = "./modules/request-lambda"
  DYNAMO_TABLE_ARN = "${module.dynamo_table.DYNAMO_TABLE_ARN}"
}

module "api-gateway" {
  source = "./modules/api-gateway"
  LAMBDA_INVOKE_ARN = "${module.lambda_request.LAMBDA_INVOKE_ARN}"
  LAMBDA_ARN = "${module.lambda_request.LAMBDA_ARN}"
}

module "dynamo_table" {
  source = "./modules/dynamodb"
}

module "sns-lambda" {
  source = "./modules/sns-lambda"
  DYNAMODB_STREAM_ARN = "${module.dynamo_table.STREAM_ARN}"
  TOPIC_ARN = "${module.sns.SNS_ARN}"
}

module "sns" {
  source = "./modules/sns"
}