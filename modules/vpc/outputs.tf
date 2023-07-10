output "public_subnets_1" {
  description = "Will be used by eks module to set subnet_ids"
  value = aws_subnet.PublicSubnet1

}

output "public_subnets_2" {
  description = "Will be used by eks module to set subnet_ids"
  value = aws_subnet.PublicSubnet2

}

