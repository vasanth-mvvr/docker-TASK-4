terraform {
  required_providers {
    aws ={
        source = "hashicorp/aws"
        version = "6.7.0"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
  backend "s3" {
    bucket = "reddym-remote-state"
    key = "docker-terraform"
    region = "us-east-1"
    dynamodb_table = "dynomodb-remote-state-lock"
  }
}

provider "aws" {
  region = "us-east-1"
}

provider "docker" {
  
}