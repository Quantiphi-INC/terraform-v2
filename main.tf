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

variable "region" {
  type = string
}
variable "access_key" {
  type = string
}
variable "secret_key" {
  type = string
}

provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

# Files upload for lambda_function_1
data "archive_file" "lambda_function_1_file" {
  type        = "zip"
  source_dir  = "./src/lambda/lambda_function_1"
  output_path = "./src/lambda/lambda_function_1/lambda_function_1.zip"
}


module "lambda_function_1" {
  source = "terraform-aws-modules/lambda/aws"

  function_name          = "example_lambda_1"
  local_existing_package = data.archive_file.lambda_function_1_file.output_path
  handler                = "lambda_function_1.handler"
  runtime                = "nodejs18.x"
  create_package         = false
  lambda_role            = module.lambda_role.iam_role_arn
}


# Files upload for lambda_function_2
data "archive_file" "lambda_function_2_file" {
  type        = "zip"
  source_dir  = "./src/lambda/lambda_function_2"
  output_path = "./src/lambda/lambda_function_2/lambda_function_2.zip"
}


module "lambda_function_2" {
  source = "terraform-aws-modules/lambda/aws"

  function_name          = "example_lambda_2"
  local_existing_package = data.archive_file.lambda_function_2_file.output_path
  handler                = "lambda_function_2.handler"
  runtime                = "nodejs18.x"
  create_package         = false
  lambda_role            = module.lambda_role.iam_role_arn
}


module "lambda_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "5.5.2"
  trusted_role_services = [
    "lambda.amazonaws.com"
  ]
  create_role       = true
  role_name         = "example_lambda_execution_role"
  role_requires_mfa = false
  custom_role_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  ]

}
