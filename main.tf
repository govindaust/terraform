provider "aws" {
  region     = "ap-south-1"
  
}
variable "cidr_blocks"{
  description = "cidr blocks for vpc and subnet"
  type = list(string)
  }
variable "environment" {
    description = "deployment environment"
  }


resource "aws_vpc" "dev-vpc" {
  cidr_block = var.cidr_blocks[0]
  
  tags = {
    Name: "dev"
  }
}

resource "aws_subnet" "dev-subnet-1" {
  vpc_id     = aws_vpc.dev-vpc.id
  cidr_block = var.cidr_blocks[1]
  availability_zone = "ap-south-1a" 
  
  tags = {
    Name: "var.environment"
   } 
}
data "aws_vpc" "existing_vpc" {
     default = true
}
resource "aws_subnet" "dev-subnet-2" {
  vpc_id     = data.aws_vpc.existing_vpc.id
  cidr_block = var.cidr_blocks[2]
  availability_zone = "ap-south-1a"

  tags = {
    Name: "subnet-2-dev"
   } 
}
output "dev-vpc-id" {
  
  value       = aws_vpc.dev-vpc.id
  
}

