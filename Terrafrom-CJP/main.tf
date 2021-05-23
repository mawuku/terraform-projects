# https://www.terraform.io/docs/providers/aws/guides/eks-getting-started.html
provider "aws" {
  profile     = var.profile
  region      = var.region
  max_retries = 20
  //  version     = "1.7.0"
}

module "vpc" {
  source                      = "./vpc"
  tags                        = local.tags
  associate_public_ip_address = var.associate_public_ip_address
  availability_zones          = var.availability_zones
  source_dest_check           = var.source_dest_check
  vpc_cidr                    = var.vpc_cidr
}

module "keypair" {
  source       = "./key"
  keypair_name = var.cluster_name
  keypair_path = var.secrets_path
}