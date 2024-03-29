# Files upload for lambda_function_5
data "archive_file" "lambda_function_5_file" {
  type        = "zip"
  source_dir  = "./src/lambda/lambda_function_5"
  output_path = "./src/lambda/lambda_function_5/lambda_function_1.zip"
}


module "lambda_function_5" {
  source = "terraform-aws-modules/lambda/aws"

  function_name          = "example_lambda_5"
  local_existing_package = data.archive_file.lambda_function_5_file.output_path
  handler                = "lambda_function_5.handler"
  runtime                = "nodejs18.x"
  create_package         = false
  lambda_role            = module.lambda_role.iam_role_arn
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

# Files upload for lambda_function_1
data "archive_file" "lambda_function_3_file" {
  type        = "zip"
  source_dir  = "./src/lambda/lambda_function_3"
  output_path = "./src/lambda/lambda_function_3/lambda_function_3.zip"
}


module "lambda_function_3" {
  source = "terraform-aws-modules/lambda/aws"

  function_name          = "example_lambda_3"
  local_existing_package = data.archive_file.lambda_function_3_file.output_path
  handler                = "lambda_function_3.handler"
  runtime                = "nodejs18.x"
  create_package         = false
  lambda_role            = module.lambda_role.iam_role_arn
}

# Files upload for lambda_function_4
data "archive_file" "lambda_function_4_file" {
  type        = "zip"
  source_dir  = "./src/lambda/lambda_function_4"
  output_path = "./src/lambda/lambda_function_4/lambda_function_4.zip"
}


module "lambda_function_4" {
  source = "terraform-aws-modules/lambda/aws"

  function_name          = "example_lambda_4"
  local_existing_package = data.archive_file.lambda_function_4_file.output_path
  handler                = "lambda_function_4.handler"
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


