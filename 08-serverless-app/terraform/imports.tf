# import {
#   to = aws_cognito_user_pool.this
#   id = "eu-central-1_rdyo9eLx4"
# }

# import {
#   to = aws_cognito_user_pool_client.this
#   id = "eu-central-1_rdyo9eLx4/4n7mt9s35larcagn0lq7pedto"
# }

# import {
#   to = aws_cognito_user_pool_domain.this
#   id = "api-todos"
# }

# import {
#   to = aws_cloudwatch_log_group.api_gw_logs
#   id = "API-Gateway-Execution-Logs_5uahgm4dih/dev"
# }

# import {
#   to = aws_api_gateway_stage.this
#   id = "${aws_api_gateway_rest_api.this.id}/${var.environment}"
# }

# import {
#   to = aws_api_gateway_method.cors
#   id = "bpti902xb9/g5u9cb/OPTIONS"
# }

# import {
#   to = aws_api_gateway_integration.cors
#   id = "bpti902xb9/g5u9cb/OPTIONS"
# }

# import {
#   to = aws_api_gateway_method_response.cors
#   id = "bpti902xb9/g5u9cb/OPTIONS/200"
# }

# import {
#   to = aws_api_gateway_integration_response.cors
#   id = "bpti902xb9/g5u9cb/OPTIONS/200"
# }

# import {
#   to = aws_api_gateway_gateway_response.cors_4xx
#   id = "bpti902xb9/DEFAULT_4XX"
# }

# import {
#   to = aws_api_gateway_gateway_response.cors_5xx
#   id = "bpti902xb9/DEFAULT_5XX"
# }

# import {
#   to = aws_iam_role.developer
#   id = "api-gateway-send-logs-to-cw"
# }
