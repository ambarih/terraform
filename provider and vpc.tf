provider "aws" {
  region = "us-east-1"
  # access_key = "AKIAYG6JZQHHSMUTW7CY"
  # secret_key = "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"
}

resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = "true" #gives you an internal domain name
  enable_dns_hostnames = "true" #gives you an internal host name
  instance_tenancy     = "default"
  tags = {
    Name        = "main-vpc"
    Project     = "Jarvis"
    Environment = "Test"
    Owner       = "agangulappa@altimetrik.com"
    Application = "Web"

  }
}

output "vpc_id" {
  value       = aws_vpc.main.id
  description = "VPC id"
  sensitive   = false
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name        = "main"
    Project     = "Jarvis"
    Environment = "Test"
    Owner       = "agangulappa@altimetrik.com"
    Application = "Web"
  }

}