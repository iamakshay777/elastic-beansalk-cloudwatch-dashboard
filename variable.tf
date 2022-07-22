variable "elasticapp" {
  default = "myapp"
}
variable "beanstalkappenv" {
  default = "myenv4"
}

variable "solution_stack_name" {
  type = string
}

variable "tier" {
  type = string
}

# variable "ec2-instance-id" {
#   type=list(any)
#   default="${aws_elastic_beanstalk_environment.beanstalkappenv.instance_id}"
# }

variable "enable_stream_logs" {
  type        = bool
  default     = true
  description = "Whether to create groups in CloudWatch Logs for proxy and deployment logs, and stream logs from each instance in your environment"
}

variable "health_streaming_enabled" {
  type        = bool
  default     = true
  description = "For environments with enhanced health reporting enabled, whether to create a group in CloudWatch Logs for environment health and archive Elastic Beanstalk environment health data. For information about enabling enhanced health, see aws:elasticbeanstalk:healthreporting:system."
}

variable "minsize" {}
variable "maxsize" {}
 
 variable "loadbalancer_type" {
  type        = string
  default     = "classic"
  description = "Load Balancer type, e.g. 'application' or 'classic'"
}

#key-pair
# variable "keypair" {
#   type        = string
#   description = "Name of SSH key that will be deployed on Elastic Beanstalk and DataPipeline instance. The key should be present in AWS"
# #   default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCaDLncV9WMa7Y43cEpKqHQpWmwTvNnMPk26trL+A4pSTbwZ8PkihoZK52wN/OCo8b5RW12zO5reHI4Yo2vowtUv7RuiW6XPG3NagQYLSBACpTvLH2OpAFrKOpK3y2hLnuvxtND3XzX9TLiFjgzFIFLHO0/jHCZGYZ5mxnkAq97dIiGHWLRXH0/Z7CrWKy02aEoJ+PzeZy8S9CSfRqYNtRRD3MwGhR5oJg9nQzamapZEdLAUA3ylZGFrUgeuWrN3NsHVGa7zEGloxViugr9jrLPjUqRrgMuyDdWS6Xh+AGjhOGKmxN92ki70z3Y+EX6dcvOLBPyBblmvZgMS4R00k3NY4GjNFd74VapEwUzc8m6B3aq45vAfy6ohX197EWO9bYw8XZlFKbnk+ddIgBp0Dy8/9+qr45ogpIFi9VNGmlr5puTTO8Z2KSoQ8+pnCXPI94NC5kChd1rXV6o7v4zGdUi5DXmLd5HucImrBU3kgHcgp9CIon3BbiYGqXxUjopGrs= akshay_saini"
# }

variable "ssh_source_restriction" {
  type        = string
  default     = "0.0.0.0/0"
  description = "Used to lock down SSH access to the EC2 instances"
}

variable "ssh_listener_enabled" {
  type        = bool
  default     = false
  description = "Enable SSH port"
}

variable "ssh_listener_port" {
  type        = number
  default     = 22
  description = "SSH port"
}

variable "vpc_id" {}
variable "public_subnets" {}
variable "elb_public_subnets" {}

#subnet create
# resource "aws_vpc_ipv4_cidr_block_association" "secondary_cidr" {
#   vpc_id     = var.vpc_id
#   cidr_block = "172.31.182.0/25"
# }

# resource "aws_subnet" "in_secondary_cidr" {
#   vpc_id     = aws_vpc_ipv4_cidr_block_association.secondary_cidr.vpc_id
#   cidr_block = "172.31.90.0/24"
# }

variable "Instance_type" {}

locals {
  tags = {
    created_by = "akshay-terraform"
  }
}

# locals {
#   enabled   = module.this.enabled
#   partition = join("", data.aws_partition.current.*.partition)
# }

# data "aws_partition" "current" {
#   count = local.enabled ? 1 : 0
# }

# variable "security_group_enabled" {
#   type        = bool
#   description = "Whether to create Security Group."
#   default     = true
# }

# variable "security_group_description" {
#   type        = string
#   default     = "Elastic Beanstalk environment Security Group"
#   description = "The Security Group description."
# }

# variable "security_group_use_name_prefix" {
#   type        = bool
#   default     = false
#   description = "Whether to create a default Security Group with unique name beginning with the normalized prefix."
# }

# variable "security_group_rules" {
#   type = list(any)
#   default = [
#     {
#       type        = "egress"
#       from_port   = 0
#       to_port     = 65535
#       protocol    = "-1"
#       cidr_blocks = ["0.0.0.0/0"]
#       description = "Allow all outbound traffic"
#     }
#   ]
#   description = <<-EOT
#     A list of maps of Security Group rules.
#     The values of map is fully complated with `aws_security_group_rule` resource.
#     To get more info see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule .
#   EOT
# }

# # variable "security_groups" {
# #   type        = list(string)
# #   description = "A list of Security Group IDs to associate with EC2 instances."
# # }


# variable "loadbalancer_security_groups" {
#   type        = list(string)
#   default     = []
#   description = "Load balancer security groups"
# }

# variable "loadbalancer_managed_security_group" {
#   type        = string
#   default     = ""
#   description = "Load balancer managed security group"
# }
# variable "create_security_group" {
#   type        = bool
#   default     = true
#   description = "Set `true` to create and configure a Security Group for the cluster."
# }

# variable "associated_security_group_ids" {
#   type        = list(string)
#   default     = []
#   description = <<-EOT
#     A list of IDs of Security Groups to associate the created resource with, in addition to the created security group.
#     These security groups will not be modified and, if `create_security_group` is `false`, must have rules providing the desired access.
#     EOT
# }

# variable "security_group_name" {
#   type        = list(string)
#   default     = []
#   description = <<-EOT
#     The name to assign to the created security group. Must be unique within the VPC.
#     If not provided, will be derived from the `null-label.context` passed in.
#     If `create_before_destroy` is true, will be used as a name prefix.
#     EOT
# }

# # variable "security_group_description" {
# #   type        = string
# #   default     = "Security Group for the EB environment"
# #   description = <<-EOT
# #     The description to assign to the created Security Group.
# #     Warning: Changing the description causes the security group to be replaced.
# #     EOT
# #}

# variable "security_group_create_before_destroy" {
#   type = bool

#   default     = false
#   description = <<-EOT
#     Set `true` to enable Terraform `create_before_destroy` behavior on the created security group.
#     We recommend setting this `true` on new security groups, but default it to `false` because `true`
#     will cause existing security groups to be replaced, possibly requiring the resource to be deleted and recreated.
#     Note that changing this value will always cause the security group to be replaced.
#     EOT
# }
# variable "security_group_create_timeout" {
#   type        = string
#   default     = "10m"
#   description = "How long to wait for the security group to be created."
# }

# variable "security_group_delete_timeout" {
#   type        = string
#   default     = "15m"
#   description = <<-EOT
#     How long to retry on `DependencyViolation` errors during security group deletion from
#     lingering ENIs left by certain AWS services such as Elastic Load Balancing.
#     EOT
# }

# variable "allow_all_egress" {
#   type        = bool
#   default     = true
#   description = <<-EOT
#     If `true`, the created security group will allow egress on all ports and protocols to all IP addresses.
#     If this is false and no egress rules are otherwise specified, then no egress will be allowed.
#     EOT
# }

# variable "additional_security_group_rules" {
#   type        = list(any)
#   default     = []
#   description = <<-EOT
#     A list of Security Group rule objects to add to the created security group, in addition to the ones
#     this module normally creates. (To suppress the module's rules, set `create_security_group` to false
#     and supply your own security group via `associated_security_group_ids`.)
#     The keys and values of the objects are fully compatible with the `aws_security_group_rule` resource, except
#     for `security_group_id` which will be ignored, and the optional "key" which, if provided, must be unique and known at "plan" time.
#     To get more info see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule .
#     EOT
# }
