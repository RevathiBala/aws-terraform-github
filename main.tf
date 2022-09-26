terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 1.0.4"
}

provider "aws" {
  profile    = "default"
  region     = var.region 
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
}

module "ec2" {
  source              = "./modules/ec2"
  ami_id              = var.ami_id
  instance_type       = var.instance_type
  tags				  = var.tags
  private_key		  = var.private_key
  security_group      = var.security_group
  key_name            = var.key_name
}