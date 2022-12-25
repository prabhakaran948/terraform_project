data "archive_file" "lambda-notification" {
    type = "zip"
    source_dir = "src"
    output_path = "src.zip"
}

resource "aws_lambda_function" "lambda-notification" {
  filename      = data.archive_file.lambda-notification.output_path
  function_name = "${var.usecase-prefix}-config-notification-lambda"
  role          = aws_iam_role.config_lambda_role.arn
  handler       = "cofig-role.lambda_handler"
  timeout       = 900
  source_code_hash = filebase64sha256(data.archive_file.lambda-notification.output_path)
  runtime = "python3.8"
}