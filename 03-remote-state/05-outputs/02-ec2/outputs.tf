output "instance" {
  value = {
    arn       = aws_instance.example.arn
    public_ip = aws_instance.example.public_ip
  }
}
