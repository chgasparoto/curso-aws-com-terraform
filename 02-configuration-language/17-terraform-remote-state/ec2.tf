variable "ami" {
  type        = string
  description = ""
  default     = "ami-03c3a7e4263fd998c"
}

variable "instance_type" {
  type        = string
  description = ""
  default     = "t3.micro"
}

resource "aws_instance" "web" {
  ami           = var.ami
  instance_type = var.instance_type

  tags = {
    Name = "Remote State"
    Env  = "dev"
  }
}
