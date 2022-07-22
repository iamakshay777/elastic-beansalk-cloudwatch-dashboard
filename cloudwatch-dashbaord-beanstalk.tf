resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "beanstalk-dashboard"

  dashboard_body = <<EOF
{
  "widgets": [
    {
      "type": "metric",
      "x": 0,
      "y": 0,
      "width": 12,
      "height": 6,
      "properties": {
        "metrics": [
          [
            "AWS/EC2",
            "CPUCreditBalance",
            "AutoScalingGroupName",
            "${aws_elastic_beanstalk_environment.beanstalkappenv.name}"
          ]
        ],
        "period": 300,
        "stat": "Average",
        "timezone":"-0530",
        "region": "us-east-1",
        "title": "EC2 Instance CPU"
      }
    },
    {
      "type": "metric",
      "x": 0,
      "y": 0,
      "width": 12,
      "height": 6,
      "properties": {
        "metrics": [
          [
            "AWS/ElasticBeanstalk",
            "EnvironmentHealth",
            "EnvironmentName",
            "${aws_elastic_beanstalk_environment.beanstalkappenv.name}"
          ]
        ],
        "period": 300,
        "stat": "Average",
        "timezone":"-0530",
        "region": "us-east-1",
        "title": "beanstalk-environemnt"
      }
    },
    {
      "type": "metric",
      "x": 20,
      "y": 0,
      "width": 12,
      "height": 6,
      "properties": {
        "metrics": [
          [
            "AWS/EC2",
            "NetworkIn",
            "InstanceId",
            "${aws_elastic_beanstalk_environment.beanstalkappenv.arn}",
             {
               "yAxis":"right",
               "label":"NetworkIn",
               "period":3600,
               "stat":"Maximum"
            }
          ]
        ],
        "period": 300,
        "stat": "Average",
        "timezone":"-0530",
        "region": "us-east-1",
        "title": "Network Input"
      }
    },
    {
      "type": "metric",
      "x": 0,
      "y": 20,
      "width": 12,
      "height": 6,
      "properties": {
        "metrics": [
          [
            "System/Linux",
            "MemoryUtilization",
            "InstanceId",
            "${aws_elastic_beanstalk_environment.beanstalkappenv.arn}"
          ],
          [
            "System/Linux",
            "MemoryUsed",
            "InstanceId",
            "${aws_elastic_beanstalk_environment.beanstalkappenv.arn}"
          ],
          [
            "System/Linux",
            "MemoryAvailable",
            "InstanceId",
            "${aws_elastic_beanstalk_environment.beanstalkappenv.arn}"
          ]
        ], 
        "view": "gauge",
        "yAxis":{
              "left":{
                      "min":0,
                      "max":1000000000
                     }
                 },
        "stat": "Maximum",
        "region": "us-east-1",
        "timezone":"-0530",
        "liveData": true,
        "title": "Memory throughput"
      }
    },
    {
      "type": "metric",
      "x": 0,
      "y": 20,
      "width": 12,
      "height": 6,
      "properties": {
        "metrics": [
          [
            "System/Linux",
            "MemoryUtilization",
            "InstanceId",
            "${aws_elastic_beanstalk_environment.beanstalkappenv.arn}"
          ],
          [
            "System/Linux",
            "MemoryUsed",
            "InstanceId",
            "${aws_elastic_beanstalk_environment.beanstalkappenv.arn}"
          ]
        ], 
        "view": "gauge",
        "yAxis":{
              "left":{
                      "min":0,
                      "max":1000000000
                     }
                 },
        "stat": "Maximum",
        "region": "us-east-1",
        "timezone":"-0530",
        "liveData": true,
        "title": "Memory instance"
      }
    },
    {
      "type": "metric",
      "x": 0,
      "y": 20,
      "width": 12,
      "height": 6,
      "properties": {
        "metrics": [
          [
             "System/Linux",
            "DiskSpaceUtilization",
            "MountPath",
            "/",
            "Instance name",
            "${aws_elastic_beanstalk_environment.beanstalkappenv.name}",
            "Filesystem",
            "/dev/xvda1"
          ],
          [
             "System/Linux",
            "DiskSpaceUsed",
            "MountPath",
            "/",
            "Instance name",
            "${aws_elastic_beanstalk_environment.beanstalkappenv.name}",
            "Filesystem",
            "/dev/xvda1"
          ]
        ], 
        "view": "gauge",
        "yAxis":{
              "left":{
                      "min":0,
                      "max":8000000000
                     }
                 },
        "stat": "Maximum",
        "region": "us-east-1",
        "timezone":"-0530",
        "liveData": true,
        "title": "Disk used status"
      }
    },
    {
      "type": "metric",
      "x": 0,
      "y": 0,
      "width": 12,
      "height": 6,
      "properties": {
        "metrics": [
          [
            "System/Linux",
            "DiskSpaceAvailable",
            "MountPath",
            "/",
            "InstanceId",
            "${aws_elastic_beanstalk_environment.beanstalkappenv.arn}",
            "Filesystem",
            "/dev/xvda1"
          ]
        ],
        "view": "gauge",
        "yAxis":{
              "left":{
                      "min":0,
                      "max":8000000000
                     }
                 },
        "period": 300,
        "stat": "Maximum",
        "timezone":"-0530",
        "liveData": true,
        "region": "us-east-1",
        "title": "Available Disk space"
      }
    }
  ]
}
EOF
}