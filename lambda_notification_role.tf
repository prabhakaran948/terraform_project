provider"aws"{
    region="us-east-1"
}

data "aws_iam_policy_document" "lambda-notification-role-trust" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers =["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "config_lambda_role" {
  name = "${var.usecase-prefix}-lambda-notification-role"
  assume_role_policy = data.aws_iam_policy_document.lambda-notification-role-trust.json
  description = "service role for config notifications"
  permissions_boundary = "arn:aws:iam::${local.account}:policy/Test-lambda-notification-policy" 
}
resource "aws_iam_role_policy_attachment" "lambda-notification-role-trust" {
  role    = aws_iam_role.config_lambda_role.name 
  policy_arn = aws_iam_policy.lambda_email_notification_policy_document.arn
}
