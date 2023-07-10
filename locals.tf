locals {
  availability_zones = ["eu-west-1a", "eu-west-1b"]

  vpc_cidr             = "172.16.0.0/16"
  public_subnet_cidrs  = ["172.16.0.0/24", "172.16.1.0/24"]
  private_subnet_cidrs = ["172.16.3.0/24", "172.16.4.0/24"]
}

