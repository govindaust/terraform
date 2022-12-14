provider "aws" {
  region     = "ap-south-1"
  access_key = "AKIAZVWLFKZUGGAQM3O3"
  secret_key = "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"
}

resource "aws_vpc" "dev-vpc" {
  cidr_block = "10.0.0.0/16"
  
  tags = {
    Name: "dev"
  }
}

resource "aws_subnet" "dev-subnet-1" {
  vpc_id     = aws_vpc.dev-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1a" 
  
  tags = {
    Name: "subnet-1-dev"
   } 
}
data "aws_vpc" "existing_vpc" {
     default = true
}
resource "aws_subnet" "dev-subnet-2" {
  vpc_id     = data.aws_vpc.existing_vpc.id
  cidr_block = "172.31.48.0/20"
  availability_zone = "ap-south-1a"

  tags = {
    Name: "subnet-2-dev"
   } 
}
output "dev-vpc-id" {
  
  value       = aws_vpc.dev-vpc.id
  
}
output "dev-subnet-1-id" {
  
  value   = aws_subnet.dev-subnet-1.id 
  
}
