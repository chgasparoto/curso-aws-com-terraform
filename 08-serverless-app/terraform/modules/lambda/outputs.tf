output "name" {
  value = aws_lambda_function.this.function_name
}

output "arn" {
  value = aws_lambda_function.this.arn
}

output "invoke_arn" {
  value = aws_lambda_function.this.invoke_arn
}

output "function_url" {
  value = var.create_function_url ? aws_lambda_function_url.this[0].function_url : null
}
