variable "environment_name" {
  type = null
}

variable "networks" {
  type = map(object({
    network_number    = number
    availability_zone = string
    tags              = map(string)
  }))
}

module "subnets" {
  source = "./subnets"

  parent_vpc_id = "vpc-abcd1234"
  networks = {
    production_a = {
      network_number    = 1
      availability_zone = "us-east-1a"
    }
    production_b = {
      network_number    = 2
      availability_zone = "us-east-1b"
    }
    staging_a = {
      network_number    = 1
      availability_zone = "us-east-1a"
    }
  }
}

output "vpc" {
  value = aws_vpc.example
}

locals {
  lb_config = <<EOT
%{ for instance in opc_compute_instance.example ~}
server ${instance.label} ${instance.ip_address}:8080
%{ endfor }
EOT
}

# server example0 192.168.2.12:8080
# server example1 192.168.2.65:8080
# server example2 192.168.2.23:8080
