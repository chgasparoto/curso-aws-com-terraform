resource "aws_cloudwatch_log_group" "api_gw_logs" {
  count = var.create_logs_for_apigw ? 1 : 0

  name              = "API-Gateway-Execution-Logs_${aws_api_gateway_rest_api.this.id}/${var.environment}"
  retention_in_days = 3
}
