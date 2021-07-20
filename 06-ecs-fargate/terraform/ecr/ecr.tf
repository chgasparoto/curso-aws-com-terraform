resource "aws_ecr_repository" "this" {
  name = "${local.app_name}-repository"
}

resource "null_resource" "docker" {
  triggers = {
    time = local.file_hash
  }

  provisioner "local-exec" {
    working_dir = var.app_folder
    command     = <<EOT
      aws ecr get-login-password \
        --region ${var.aws_region} \
        ${var.aws_profile == "default" ? "" : "--profile ${var.aws_profile}"} \
      | docker login \
        --username AWS \
        --password-stdin ${var.aws_account_id}.dkr.ecr.${var.aws_region}.amazonaws.com
    EOT
  }

  provisioner "local-exec" {
    working_dir = var.app_folder
    command     = "docker build -t ${local.app_name} ."
  }

  provisioner "local-exec" {
    working_dir = var.app_folder
    command     = "docker tag ${local.app_name} ${aws_ecr_repository.this.repository_url}:${random_id.version.id}"
  }

  provisioner "local-exec" {
    working_dir = var.app_folder
    command     = "docker push ${aws_ecr_repository.this.repository_url}:${random_id.version.id}"
  }
}
