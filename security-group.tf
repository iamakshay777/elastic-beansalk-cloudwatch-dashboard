# # module "aws_security_group" {
# #   source  = "cloudposse/security-group/aws"
# #   version = "1.0.1"

# #   #enabled = var.local.enabled && var.create_security_group

# #   #security_group_name        = length(var.security_group_name) > 0 ? var.security_group_name : [module.this.id]
# #   security_group_description = var.security_group_description

# #   allow_all_egress = var.allow_all_egress

# #   rules = var.additional_security_group_rules

# #   vpc_id = var.vpc_id

# #   create_before_destroy         = var.security_group_create_before_destroy
# #   security_group_create_timeout = var.security_group_create_timeout
# #   security_group_delete_timeout = var.security_group_delete_timeout

# #   #context = module.this.context
# # }

resource "aws_security_group" "allow_tls_0" {
  name        = "allow_tls_0"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls_0"
  }
}