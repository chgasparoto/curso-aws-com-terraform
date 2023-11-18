# # __generated__ by Terraform
# # Please review these resources and move them into your main configuration files.

# # __generated__ by Terraform
# resource "aws_autoscaling_group" "web" {
#   availability_zones               = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
#   capacity_rebalance               = false
#   context                          = null
#   default_cooldown                 = 300
#   default_instance_warmup          = 0
#   desired_capacity                 = 1
#   desired_capacity_type            = null
#   enabled_metrics                  = []
#   force_delete                     = null
#   force_delete_warm_pool           = null
#   health_check_grace_period        = 300
#   health_check_type                = "ELB"
#   ignore_failed_scaling_activities = null
#   launch_configuration             = null
#   load_balancers                   = []
#   max_instance_lifetime            = 0
#   max_size                         = 6
#   metrics_granularity              = "1Minute"
#   min_elb_capacity                 = null
#   min_size                         = 1
#   name                             = "as1"
#   name_prefix                      = null
#   placement_group                  = null
#   protect_from_scale_in            = false
#   service_linked_role_arn          = "arn:aws:iam::871055234888:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling"
#   suspended_processes              = []
#   target_group_arns                = ["arn:aws:elasticloadbalancing:eu-central-1:871055234888:targetgroup/as1-1/a559e23ce9fec2e7"]
#   termination_policies             = []
#   vpc_zone_identifier              = ["subnet-02c1f9483a8f1be99", "subnet-038d98948d47ed450", "subnet-0e0ecf95473829cbb"]
#   wait_for_capacity_timeout        = null
#   wait_for_elb_capacity            = null
#   launch_template {
#     name    = "demo1"
#     version = "$Default"
#   }
#   traffic_source {
#     identifier = "arn:aws:elasticloadbalancing:eu-central-1:871055234888:targetgroup/as1-1/a559e23ce9fec2e7"
#     type       = "elbv2"
#   }
# }

# # __generated__ by Terraform
# resource "aws_lb_listener" "front_end" {
#   alpn_policy       = null
#   certificate_arn   = null
#   load_balancer_arn = "arn:aws:elasticloadbalancing:eu-central-1:871055234888:loadbalancer/app/as1-1/82dd181ddb9f3dbb"
#   port              = 80
#   protocol          = "HTTP"
#   ssl_policy        = null
#   tags              = {}
#   tags_all          = {}
#   default_action {
#     order            = 0
#     target_group_arn = "arn:aws:elasticloadbalancing:eu-central-1:871055234888:targetgroup/as1-1/a559e23ce9fec2e7"
#     type             = "forward"
#   }
# }

# # __generated__ by Terraform
# resource "aws_launch_template" "web" {
#   default_version                      = 1
#   description                          = "1"
#   disable_api_stop                     = false
#   disable_api_termination              = false
#   ebs_optimized                        = null
#   image_id                             = "ami-0ba27d9989b7d8c5d"
#   instance_initiated_shutdown_behavior = null
#   instance_type                        = "t4g.nano"
#   kernel_id                            = null
#   key_name                             = null
#   name                                 = "demo1"
#   name_prefix                          = null
#   ram_disk_id                          = null
#   security_group_names                 = []
#   tags                                 = {}
#   tags_all                             = {}
#   update_default_version               = null
#   user_data                            = "IyEvYmluL2Jhc2gKCiMgRW5hYmxlIGxvZ3MKZXhlYyA+ID4odGVlIC92YXIvbG9nL3VzZXItZGF0YS5sb2d8bG9nZ2VyIC10IHVzZXItZGF0YSAtcyAyPi9kZXYvY29uc29sZSkgMj4mMQoKIyBJbnN0YWxsIEdpdAplY2hvICJJbnN0YWxsaW5nIEdpdCIKeXVtIHVwZGF0ZSAteQp5dW0gaW5zdGFsbCBnaXQgLXkKCiMgSW5zdGFsbCBOb2RlSlMKZWNobyAiSW5zdGFsbGluZyBOb2RlSlMiCnRvdWNoIC5iYXNocmMKY3VybCAtby0gaHR0cHM6Ly9yYXcuZ2l0aHVidXNlcmNvbnRlbnQuY29tL252bS1zaC9udm0vdjAuMzQuMC9pbnN0YWxsLnNoIHwgYmFzaAouIC8ubnZtL252bS5zaApudm0gaW5zdGFsbCAtLWx0cwoKIyBDbG9uZSB3ZWJzaXRlIGNvZGUKZWNobyAiQ2xvbmluZyB3ZWJzaXRlIgpta2RpciAtcCAvZGVtby13ZWJzaXRlCmNkIC9kZW1vLXdlYnNpdGUKZ2l0IGNsb25lIGh0dHBzOi8vZ2l0aHViLmNvbS9hY2FkZW1pbmQvYXdzLWRlbW9zLmdpdCAuCmNkIGR5bmFtaWMtd2Vic2l0ZS1zY2FsaW5nCgojIEluc3RhbGwgZGVwZW5kZW5jaWVzCmVjaG8gIkluc3RhbGxpbmcgZGVwZW5kZW5jaWVzIgpucG0gaW5zdGFsbAoKIyBGb3J3YXJkIHBvcnQgODAgdHJhZmZpYyB0byBwb3J0IDMwMDAKZWNobyAiRm9yd2FyZGluZyA4MCAtPiAzMDAwIgppcHRhYmxlcyAtdCBuYXQgLUEgUFJFUk9VVElORyAtcCB0Y3AgLS1kcG9ydCA4MCAtaiBSRURJUkVDVCAtLXRvLXBvcnRzIDMwMDAKCiMgSW5zdGFsbCAmIHVzZSBwbTIgdG8gcnVuIE5vZGUgYXBwIGluIGJhY2tncm91bmQKZWNobyAiSW5zdGFsbGluZyAmIHN0YXJ0aW5nIHBtMiIKbnBtIGluc3RhbGwgcG0yQGxhdGVzdCAtZwpwbTIgc3RhcnQgYXBwLmpz"
#   vpc_security_group_ids               = []
#   metadata_options {
#     http_endpoint               = "enabled"
#     http_protocol_ipv6          = null
#     http_put_response_hop_limit = 2
#     http_tokens                 = "required"
#     instance_metadata_tags      = null
#   }
#   network_interfaces {
#     associate_carrier_ip_address = null
#     associate_public_ip_address  = null
#     delete_on_termination        = null
#     description                  = null
#     device_index                 = 0
#     interface_type               = null
#     ipv4_address_count           = 0
#     ipv4_addresses               = []
#     ipv4_prefix_count            = 0
#     ipv4_prefixes                = []
#     ipv6_address_count           = 0
#     ipv6_addresses               = []
#     ipv6_prefix_count            = 0
#     ipv6_prefixes                = []
#     network_card_index           = 0
#     network_interface_id         = null
#     private_ip_address           = null
#     security_groups              = ["sg-09d386b82c09dde49"]
#     subnet_id                    = null
#   }
# }

# # __generated__ by Terraform from "arn:aws:elasticloadbalancing:eu-central-1:871055234888:loadbalancer/app/as1-1/82dd181ddb9f3dbb"
# resource "aws_lb" "bar" {
#   customer_owned_ipv4_pool                    = null
#   desync_mitigation_mode                      = "defensive"
#   dns_record_client_routing_policy            = null
#   drop_invalid_header_fields                  = false
#   enable_cross_zone_load_balancing            = true
#   enable_deletion_protection                  = false
#   enable_http2                                = true
#   enable_tls_version_and_cipher_suite_headers = false
#   enable_waf_fail_open                        = false
#   enable_xff_client_port                      = false
#   idle_timeout                                = 60
#   internal                                    = false
#   ip_address_type                             = "ipv4"
#   load_balancer_type                          = "application"
#   name                                        = "as1-1"
#   name_prefix                                 = null
#   preserve_host_header                        = false
#   security_groups                             = ["sg-04be386263ca2cff2"]
#   subnets                                     = ["subnet-02c1f9483a8f1be99", "subnet-038d98948d47ed450", "subnet-0e0ecf95473829cbb"]
#   tags                                        = {}
#   tags_all                                    = {}
#   xff_header_processing_mode                  = "append"
#   access_logs {
#     bucket  = ""
#     enabled = false
#     prefix  = null
#   }
#   subnet_mapping {
#     allocation_id        = null
#     ipv6_address         = null
#     private_ipv4_address = null
#     subnet_id            = "subnet-02c1f9483a8f1be99"
#   }
#   subnet_mapping {
#     allocation_id        = null
#     ipv6_address         = null
#     private_ipv4_address = null
#     subnet_id            = "subnet-038d98948d47ed450"
#   }
#   subnet_mapping {
#     allocation_id        = null
#     ipv6_address         = null
#     private_ipv4_address = null
#     subnet_id            = "subnet-0e0ecf95473829cbb"
#   }
# }

# # __generated__ by Terraform
# resource "aws_lb_target_group" "app_front_end" {
#   connection_termination             = null
#   deregistration_delay               = "300"
#   ip_address_type                    = "ipv4"
#   lambda_multi_value_headers_enabled = null
#   load_balancing_algorithm_type      = "round_robin"
#   load_balancing_cross_zone_enabled  = "use_load_balancer_configuration"
#   name                               = "as1-1"
#   name_prefix                        = null
#   port                               = 80
#   preserve_client_ip                 = null
#   protocol                           = "HTTP"
#   protocol_version                   = "HTTP1"
#   proxy_protocol_v2                  = null
#   slow_start                         = 0
#   tags                               = {}
#   tags_all                           = {}
#   target_type                        = "instance"
#   vpc_id                             = "vpc-03c27a7f8a56bad78"
#   health_check {
#     enabled             = true
#     healthy_threshold   = 5
#     interval            = 30
#     matcher             = "200"
#     path                = "/"
#     port                = "80"
#     protocol            = "HTTP"
#     timeout             = 5
#     unhealthy_threshold = 5
#   }
#   stickiness {
#     cookie_duration = 86400
#     cookie_name     = null
#     enabled         = false
#     type            = "lb_cookie"
#   }
#   target_failover {
#     on_deregistration = null
#     on_unhealthy      = null
#   }
#   target_health_state {
#     enable_unhealthy_connection_termination = null
#   }
# }
