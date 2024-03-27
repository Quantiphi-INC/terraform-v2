terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}


provider "aws" {
  region = "us-east-1"
}

data "archive_file" "example_zip" {
  type        = "zip"
  source_dir  = "${path.module}/your-lambda-function-directory"
  output_path = "${path.module}/your-lambda-function.zip"
}

resource "aws_lambda_function" "example" {
  function_name = "example_lambda"

  filename      = data.archive_file.example_zip.output_path
  source_code_hash = data.archive_file.example_zip.output_base64sha256
  handler       = "index.handler"
  runtime       = "nodejs12.x"
  role          = aws_iam_role.example.arn
}

# Files upload for lambda_function_1
data "archive_file" "lambda_function_1_file" {
  type             = "zip"
  source_dir       = "../src/lambda/lambda_function_1/lambda_function_1.js"
  output_file_mode = "0644"
  output_path      = "../src/lambda/lambda_function_1/lambda_function_1.zip"
}


module "lambda_function_1" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = "example_lambda_1"
  local_existing_package  = data.archive_file.lambda_function_1_file.output_path
  handler = "lambda_function_1.handler"
  runtime = "nodejs18.x"
  create_package         = true
  lambda_role = aws_iam_role.lambda_role.arn
}


# Files upload for lambda_function_2
data "archive_file" "lambda_function_2_file" {
  type             = "zip"
  source_dir       = "../src/lambda/lambda_function_2/lambda_function_2.js"
  output_file_mode = "0644"
  output_path      = "../src/lambda/lambda_function_2/lambda_function_2.zip"
}


module "lambda_function_2" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = "example_lambda_2"
  local_existing_package  = data.archive_file.lambda_function_2_file.output_path
  handler = "lambda_function_2.handler"
  runtime = "nodejs18.x"
  create_package         = true
  lambda_role = aws_iam_role.lambda_role.arn
}   


module "lambda_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "5.5.2"
  trusted_role_services = [
    "lambda.amazonaws.com"
  ]
  create_role       = true
  role_name         = lambda_execution_role
  role_requires_mfa = false
  custom_role_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  ]

}
