# Create elastic beanstalk application
resource "aws_elastic_beanstalk_application" "elasticapp" {
  name = var.elasticapp
}
 
# Create elastic beanstalk Environment
resource "aws_elastic_beanstalk_environment" "beanstalkappenv" {
  name                = var.beanstalkappenv
  application         = aws_elastic_beanstalk_application.elasticapp.name
  solution_stack_name = var.solution_stack_name
  tier                = var.tier
  wait_for_ready_timeout = "60m" 
  #template_name = data.template_file.dashboard-script.template
#   cname_prefix        = "demo-app"
  tags                = local.tags
 
  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = var.vpc_id
  }
  #keypair
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "EC2KeyName"
    value     = aws_key_pair.cloudwatch.key_name
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     =  aws_iam_instance_profile.ec2_eb_profile.name
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "AssociatePublicIpAddress"
    value     =  "True"
  }
 
   setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = join(",", var.public_subnets)
  }
  setting {
    namespace = "aws:ec2:vpc"
    name = "ELBSubnets"
    value = join(",", var.elb_public_subnets)
  }
 setting {
    namespace = "aws:elasticbeanstalk:cloudwatch:logs:health"
    name      = "HealthStreamingEnabled"
    value     = var.health_streaming_enabled ? "true" : "false"
    resource  = ""
  }

 setting {
    namespace = "aws:elasticbeanstalk:cloudwatch:logs"
    name      = "StreamLogs"
    value     = var.enable_stream_logs ? "true" : "false"
    resource  = ""
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "MatcherHTTPCode"
    value     = "200"
  }
setting {
     namespace = "aws:elasticbeanstalk:environment:process:default"
      name      = "Protocol"
      value     = var.loadbalancer_type == "network" ? "TCP" : "HTTP"
    }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "LoadBalancerType"
    value     = "application"
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = var.Instance_type
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBScheme"
    value     = "internet facing"
  }
    setting {
    namespace = "aws:elb:loadbalancer"
    name      = "CrossZone"
    value     = "true"
  }
  setting {
    namespace = "aws:elasticbeanstalk:command"
    name      = "BatchSizeType"
    value     = "Fixed"
  }
  setting {
    namespace = "aws:elasticbeanstalk:command"
    name      = "BatchSize"
    value     = "1"
  }
   setting {
    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
    name      = "MinInstancesInService"
    value     = "1"
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MinSize"
    value     = 1
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = 2
  }
  setting {
    namespace = "aws:elasticbeanstalk:healthreporting:system"
    name      = "SystemType"
    value     = "enhanced"
  }
  # setting {
  #   namespace = "aws:autoscaling:launchconfiguration"
  #   name      = "SecurityGroups"
  #   value     = "sg-07b7ab8036f6a8072"
  #   resource  = ""
  # } 
# setting{
#       namespace = "aws:elb:loadbalancer"
#       name      = "SecurityGroups"
#       value     = join(",", sort(var.loadbalancer_security_groups))
# }
#  setting {  
#     namespace = "aws:autoscaling:launchconfiguration"
#     name      = "SecurityGroups"
#     # value     = join(",", compact(sort(concat([var.security_groups.id],var.security_groups))))
#     value      = aws_security_group.allow_tls_0.id
#     resource  = ""
#   }
# setting{
  
#       namespace = "aws:elb:loadbalancer"
#       name      = "ManagedSecurityGroup"
#       value     = var.loadbalancer_managed_security_group
# }
setting {
   
      namespace = "aws:elb:listener:${var.ssh_listener_port}"
      name      = "ListenerProtocol"
      value     = "TCP"
}
    setting {
    
      namespace = "aws:elb:listener:${var.ssh_listener_port}"
      name      = "InstancePort"
      value     = "22"
    }
    setting {
      namespace = "aws:elb:listener:${var.ssh_listener_port}"
      name      = "ListenerEnabled"
      value     = var.ssh_listener_enabled
    }
 
}

# resource "aws_vpc_ipv4_cidr_block_association" "secondary_cidr" {
#   vpc_id     = var.vpc_id
#   cidr_block = "172.31.0.0/16"
# }

# resource "aws_subnet" "in_secondary_cidr" {
#   vpc_id     = aws_vpc_ipv4_cidr_block_association.secondary_cidr.vpc_id
#   cidr_block = "172.31.90.0/24"
# }



data "template_file" "dashboard-script"{

  template = file("${path.module}/script.sh")

}
