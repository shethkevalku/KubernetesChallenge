# # Create ECR repository
# resource "aws_ecr_repository" "test_service" {
#   name = "example-service-name"
# }

# # Build Docker image and push to ECR from folder: ./example-service-directory
# module "ecr_docker_build" {
#   source = "github.com/onnimonni/terraform-ecr-docker-build-module"

#   # Absolute path into the service which needs to be build
#   dockerfile_folder = "${path.module}/"

#   # Tag for the builded Docker image (Defaults to 'latest')
#   docker_image_tag = "development"
  
#   # The region which we will log into with aws-cli
#   aws_region = "eu-west-1"

#   # ECR repository where we can push
#   ecr_repository_url = "${aws_ecr_repository.test_service.repository_url}"
# }



# Stack Over flow 


# tell terraform which provider plugins are needed
# terraform {
#   required_providers {
#     docker = {
#       source  = "kreuzwerker/docker"
#       version = "3.0.2"
#     }
#     aws = {
#       source  = "hashicorp/aws"
#       version = "5.6.2"
#     }
#   }
# }

# # configure aws provider
# # provider "aws" {}

# # create ecr repo
# resource "aws_ecr_repository" "my-ecr-2repo" {
#   name = "my-ecr-2repo"
# }

# # get authorization credentials to push to ecr
# data "aws_ecr_authorization_token" "token" {}

# # configure docker provider
# provider "docker" {
#   registry_auth {
#       address = data.aws_ecr_authorization_token.token.proxy_endpoint
#       username = data.aws_ecr_authorization_token.token.user_name
#       password  = data.aws_ecr_authorization_token.token.password
#     }
# }

# # build docker image
# resource "docker_image" "my-docker-image" {
#   name = "${data.aws_ecr_authorization_token.token.proxy_endpoint}/my-ecr-2repo:latest"
#   build {
#     context  = "."
#   }
#   platform = "linux/arm64"
# }

# # push image to ecr repo
# resource "docker_registry_image" "media-handler" {
#   name = docker_image.my-docker-image.name
# }




#============================

# Chatgpt 
# resource "aws_ecr_repository" "my_repository" {
#   name = "my-repo"
# }

# data "docker_image" "my_image" {
#   build {
#     context    = "../Kubernetes/src/"
#     dockerfile = "Dockerfile"
#   }

#   registry_auth {
#     address         = aws_ecr_repository.my_repository.repository_url
#     username        = aws_ecr_repository.my_repository.registry_id
#     password        = aws_ecr_repository.my_repository.registry_auth_token
#   }

#   tags = ["latest", aws_ecr_repository.my_repository.repository_url]
# }

# resource "aws_ecr_image" "my_image" {
#   name          = aws_ecr_repository.my_repository.name
#   image_tag     = "latest"
#   image_manifest = data.docker_image.my_image.manifests.latest
#}


# # tell terraform which provider plugins are needed
# terraform {
#   required_providers {
#     docker = {
#       source  = "kreuzwerker/docker"
#       version = "2.15.0"
#     }
#     aws = {
#       source  = "hashicorp/aws"
#       #version = "~> 4.0"
#       version = "5.6.2"
#     }
#   }
# }

# # # configure aws provider
#  provider "aws" {}

# resource "aws_ecr_repository" "my_ecr_automation_repo" {
#   name = "my-ecr-automation-repo"
#   tags = {
#     Name = "My ECR Repository"
#   }
# }

# # get authorization credentials to push to ecr
# data "aws_ecr_authorization_token" "token" {}

# # configure docker provider
# provider "docker" {
#   registry_auth {
#       address = "${data.aws_caller_identity.current.account_id}.dkr.ecr.eu-west-1.amazonaws.com"
#       username = data.aws_ecr_authorization_token.token.user_name
#       password  = data.aws_ecr_authorization_token.token.password
#     }
# }

# # build docker image
# resource "docker_registry_image" "my-docker-image"{
#   name = "${data.aws_ecr_authorization_token.token.proxy_endpoint}/my_ecr_automation_repo:latest"
#   build {
#     context = "../Kubernetes/src"
#     dockerfile = "Dockerfile"
#   }
# }

# # # push image to ecr repo
# # resource "docker_registry_image" "media-handler" {
# #   name = docker_image.my-docker-image.name
# # }


# # resource "null_resource" "ecr_image" {
# #   provisioner "local-exec" {
# #   interpreter = ["/bin/bash" ,"-c"]
# #   command = "aws ecr get-login-password --region eu-west-1  | docker login --username AWS --password-stdin ${aws_ecr_repository.my_ecr_automation_repo.repository_url} && docker build -t ${aws_ecr_repository.my_ecr_automation_repo.repository_url}:latest5 . && docker push ${aws_ecr_repository.my_ecr_automation_repo.repository_url}:latest5"
# #   working_dir = "./Kubernetes/src"
# # }
# # }

# data "aws_caller_identity" "current" {}

# # resource "null_resource" "docker_packaging" {
	
# # 	  provisioner "local-exec" {
# # 	    command = <<EOF
# # 	    aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin ${data.aws_caller_identity.current.account_id}.dkr.ecr.us-east-1.amazonaws.com
# # 	    gradle build -p src
# # 	    docker build -t "${aws_ecr_repository.noiselesstech.repository_url}:latestdocker" -f src/Dockerfile .
# # 	    docker push "${aws_ecr_repository.noiselesstech.repository_url}:latestdocker"
# # 	    EOF
# # 	  }
	

# # 	  triggers = {
# # 	    "run_at" = timestamp()
# # 	  }
	

# # 	  depends_on = [
# # 	    aws_ecr_repository.noiselesstech,
# # 	  ]
# # }

# # resource "aws_ecr_repository" "noiselesstech" {
# # 	  name = "noiselesstech"
	

# # 	  image_scanning_configuration {
# # 	    scan_on_push = true
# # 	  }
# # }