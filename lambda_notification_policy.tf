data "aws_caller_identity" "current" {}

locals {
    account = data.aws_caller_identity.current.account_id 
}

data "aws_iam_policy_document" "lambda_email_notification_policy_document" {
  statement {
    sid =""
    actions = [
        "ses:*"]
    resources = ["*"]
  }  
  statement {
    sid =""
    actions = [
        "route53:*"]
    resources = ["*"]
  }  
  statement {
    sid =""
    actions = [
        "iam:*"]
    resources = ["*"]
  }  
  statement {
    sid =""
    actions = [
        "s3:*"]
    resources = ["*"]
  }  
  statement {
    sid =""
    actions = [
        "ec2:*"]
    resources = ["*"]
  }  
  statement {
    sid =""
    actions = [
        "cloudwatch:*"]
    resources = ["*"]
  }  
  statement {
    sid =""
    actions = [
        "logs:*"]
        
    resources = ["*"]
  }  
  statement {
    sid =""
    actions = [
        "config:*"]
    resources = ["*"]
  }  
}

resource "aws_iam_policy" "lambda_email_notification_policy_document" {
  name        = "${var.usecase-prefix}-lambda-notification-policy"
  description = "lambda policy for config notification"
  policy = data.aws_iam_policy_document.lambda_email_notification_policy_document.json 
}
