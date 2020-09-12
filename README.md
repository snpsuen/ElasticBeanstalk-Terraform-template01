# ElasticBeanstalk-Terraform-template01
This is a Terraform tempate for deploying a docker application on Elastic Beanstalk. <br>
The root module is applied to create an AWS Elastc Beanstalk application version resource based on docker specification json that is stored as a zip files on S3. <br>
In the process, child modules provided by Cloud Posse, e.g. https://github.com/cloudposse/terraform-aws-elastic-beanstalk-environment, are called to create the ELastic Beanstalk application enviroment, VPC, subnets and other relevant resources. <br>

