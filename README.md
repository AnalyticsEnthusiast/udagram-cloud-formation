### Project Title - Deploy a high-availability web app using CloudFormation

#### Design

Launch configuration - 4 servers, two private subnets across two availability zones

two vCPUs and at least 4GB of RAM - "t2.medium"

Operating system will be Ubuntu 18 AMI

Minimum of 10GB disk on each instance


#### Security Groups and Roles

Requires permission to pull files from S3 give IAM role to instance


In order:

udagram-testing.yml (parent stack)
network.yml (Creates network resources such as vpcs, subnets and route tables)
load-balancer.yml (Creates load balancer)
web-servers.yml (Creates ec2 instances with launch config)
databases.yml (Creates postgres database instance for backend Udagram)
variables.yml (Writes parameters to ssm for further reference)

variables.yml > network.yml > servers.yml > databases.yml

Use ssm to store parameters
EnvironmentName
EnvironmentType
InstanceSize

Ubuntu Version from SSM:
/aws/service/canonical/ubuntu/server/18.04/stable/current/amd64/hvm/ebs-gp2/ami-id





