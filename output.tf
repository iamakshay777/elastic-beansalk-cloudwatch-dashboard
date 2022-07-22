output "endpoint_url" {
  description = "CNAME endpoint to the elastic beanstalk environment"
  value       = aws_elastic_beanstalk_environment.beanstalkappenv.cname
}

output "instance_id" {
  
  value = aws_elastic_beanstalk_environment.beanstalkappenv.instances
}


output "app_id" {
  value = aws_elastic_beanstalk_application.elasticapp.id
}

output "env_name" {
  value=aws_elastic_beanstalk_environment.beanstalkappenv.name
}

output "template_file" {
  value=aws_elastic_beanstalk_environment.beanstalkappenv.template_name
}

