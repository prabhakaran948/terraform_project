resource "aws_cloudwatch_event_rule" "non_complaint_resource" {
  name        = "${var.usecase-prefix}-non-complaint-resource"
  description = "run weekly once for find non_complaint_resource"

 schedule_expression ="cron(30 9 ? * mon *)"
}

resource "aws_cloudwatch_event_target" "non_complaint_resource_rule" {
  rule = aws_cloudwatch_event_rule.non_complaint_resource.name
  target_id = "sendnon_complaint_resource"
  arn = aws_lambda_function.lambda-notification.arn
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda-notification.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.non_complaint_resource.arn
}