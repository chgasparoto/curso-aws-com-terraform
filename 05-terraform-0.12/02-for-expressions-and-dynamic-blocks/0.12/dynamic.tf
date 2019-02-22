locals {
  standard_tags = {
    Component   = "user-service"
    Environment = "production"
  }
}

resource "aws_autoscaling_group" "example" {
  tag {
    key                 = "Name"
    value               = "example-asg-name"
    propagate_at_launch = false
  }

  dynamic "tag" {
    for_each = local.standard_tags

    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}

variable "subnets" {
  default = [
    {
      name   = "a"
      number = 1
    },
    {
      name   = "b"
      number = 2
    },
    {
      name   = "c"
      number = 3
    },
  ]
}

locals {
  base_cidr_block = "10.0.0.0/16"
}

resource "azurerm_virtual_network" "example" {
  name                = "example-network"
  resource_group_name = azurerm_resource_group.test.name
  address_space       = [local.base_cidr_block]
  location            = "West US"

  dynamic "subnet" {
    for_each = [for s in subnets: {
      name   = s.name
      prefix = cidrsubnet(local.base_cidr_block, 4, s.number)
    }]

    content {
      name           = subnet.name
      address_prefix = subnet.prefix
    }
  }
}
