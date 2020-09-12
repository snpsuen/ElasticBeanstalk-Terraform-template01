# ElasticBeanstalk-Terraform-template01
This is a Terraform tempate for deploying a docker application on Elastic Beanstalk. <br>
<p>
Given a docker specification json for AWS, the root module is applied to create an AWS Elastc Beanstalk application version resource based on the json, which is zipped and stored on S3. <br>
In the process, child modules provided by Cloud Posse, e.g. https://github.com/cloudposse/terraform-aws-elastic-beanstalk-environment, are called to create the ELastic Beanstalk application enviroment, VPC, subnets and other relevant resources. <br>
<p>
To use or test the template, git clone the repo https://github.com/snpsuen/ElasticBeanstalk-Terraform-template01.git on a host where Terraform and AWS CLI are installed. <br>
1. Edit Dockerrun.aws.json in the base directory by specifying what docker image to deploy on EB. <br>
2. zip ebdemo01_node-app01.zip Dockerrun.aws.json <br>
3. aws s3 cp ebdemo01_node-app01.zip "s3://$EBS_BUCKET/ebdemo01_node-app01.zip" <br>
