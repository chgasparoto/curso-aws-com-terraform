output "instance_arn" {
  value = "${aws_instance.web.arn}"
}

output "instance_public_ip" {
  value = "${aws_instance.web.public_ip}"
}

output "instance_dns" {
  value = "${aws_instance.web.public_dns}"
}

output "instance_private_ip" {
  value     = "${aws_instance.web.private_ip}"
  sensitive = true
}
