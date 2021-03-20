locals {
  subnet_ids = { for k, v in aws_subnet.this : v.tags.Name => v.id }

  common_tags = {
    Project   = "Curso AWS com Terraform"
    CreatedAt = "2020-03-17"
    ManagedBy = "Terraform"
    Owner     = "Cleber Gasparoto"
    Service   = "Auto Scaling App"
  }
}
