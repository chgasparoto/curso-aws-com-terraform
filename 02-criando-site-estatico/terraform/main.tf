provider "aws" {
  region = "${var.region}"
}

data "template_file" "policy" {
  template = "${file("templates/policy.json")}"

  vars {
    bucket_name = "${var.domain}"
  }
}
