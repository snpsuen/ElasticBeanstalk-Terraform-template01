provider "aws" {
  shared_credentials_file = "$HOME/.aws/credentials"
  profile                 = "default"
  region                  = var.aws_region
}

resource "aws_s3_bucket" default {
  bucket = "${var.name}.applicationversion.bucket"
}

resource "aws_s3_bucket_object" default {
  bucket = aws_s3_bucket.default.id
  key    = "beanstalk/ebdemo01_node-app01.zip"
  source = "ebdemo01_node-app01.zip"
}

resource "aws_elastic_beanstalk_application_version" default {
  name        = "${var.name}_node-app01"
  application = module.elastic_beanstalk_application.name
  description = "application version created by terraform"
  bucket      = "aws_s3_bucket.${var.name}.id"
  key         = "aws_s3_bucket_object.${var.name}.id"
}

module "vpc" {
  source     = "./modules/vpc/"
  namespace  = var.namespace
  stage      = var.stage
  name       = var.name
  attributes = var.attributes
  tags       = var.tags
  delimiter  = var.delimiter
  cidr_block = "172.16.0.0/16"
}

module "subnets" {
  source               = "./modules/subnets/"
  availability_zones   = var.availability_zones
  namespace            = var.namespace
  stage                = var.stage
  name                 = var.name
  attributes           = var.attributes
  tags                 = var.tags
  delimiter            = var.delimiter
  vpc_id               = module.vpc.vpc_id
  igw_id               = module.vpc.igw_id
  cidr_block           = module.vpc.vpc_cidr_block
  nat_gateway_enabled  = true
  nat_instance_enabled = false
}

module "elastic_beanstalk_application" {
  source      = "./modules/eba/"
  namespace   = var.namespace
  stage       = var.stage
  name        = var.name
  attributes  = var.attributes
  tags        = var.tags
  delimiter   = var.delimiter
  description = "Elastic Beanstalk Application Demo01"
}

module "elastic_beanstalk_environment" {
  source                     = "./modules/ebe"
  namespace                  = var.namespace
  stage                      = var.stage
  name                       = var.name
  attributes                 = var.attributes
  tags                       = var.tags
  delimiter                  = var.delimiter
  description                = var.description
  region                     = var.region
  availability_zone_selector = var.availability_zone_selector
  dns_zone_id                = var.dns_zone_id

  wait_for_ready_timeout             = var.wait_for_ready_timeout
  elastic_beanstalk_application_name = module.elastic_beanstalk_application.elastic_beanstalk_application_name
  environment_type                   = var.environment_type
  loadbalancer_type                  = var.loadbalancer_type
  elb_scheme                         = var.elb_scheme
  tier                               = var.tier
  version_label                      = var.version_label
  force_destroy                      = var.force_destroy

  instance_type    = var.instance_type
  root_volume_size = var.root_volume_size
  root_volume_type = var.root_volume_type

  autoscale_min             = var.autoscale_min
  autoscale_max             = var.autoscale_max
  autoscale_measure_name    = var.autoscale_measure_name
  autoscale_statistic       = var.autoscale_statistic
  autoscale_unit            = var.autoscale_unit
  autoscale_lower_bound     = var.autoscale_lower_bound
  autoscale_lower_increment = var.autoscale_lower_increment
  autoscale_upper_bound     = var.autoscale_upper_bound
  autoscale_upper_increment = var.autoscale_upper_increment

  vpc_id                  = module.vpc.vpc_id
  loadbalancer_subnets    = module.subnets.public_subnet_ids
  application_subnets     = module.subnets.private_subnet_ids
  allowed_security_groups = [module.vpc.vpc_default_security_group_id]

  rolling_update_enabled  = var.rolling_update_enabled
  rolling_update_type     = var.rolling_update_type
  updating_min_in_service = var.updating_min_in_service
  updating_max_batch      = var.updating_max_batch

  healthcheck_url  = var.healthcheck_url
  application_port = var.application_port

  // https://docs.aws.amazon.com/elasticbeanstalk/latest/platforms/platforms-supported.html
  // https://docs.aws.amazon.com/elasticbeanstalk/latest/platforms/platforms-supported.html#platforms-supported.docker
  solution_stack_name = var.solution_stack_name

  additional_settings = var.additional_settings
  env_vars            = var.env_vars
}
