resource "aws_ecr_repository" "this" {
  name = "${local.app_name}-repository"
}

resource "null_resource" "docker" {
  triggers = {
    time = local.file_hash
  }

  provisioner "local-exec" {
    working_dir = var.app_folder
    command     = "$(aws ecr get-login-password --no-include-email --region ${var.aws_region} --profile ${var.aws_profile})"
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
