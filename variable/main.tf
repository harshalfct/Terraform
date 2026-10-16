provider "aws" {
  region = "ap-south-1"
}
## Resource for EC2 instance using the variables defined in same file
# resource "aws_instance" "web-server" {
#   ami           = var.ami
#   instance_type = var.instance_type
#   key_name      = var.key_name
#   vpc_security_group_ids = [var.  web-server-sg]

#   tags = {
#     Name = "web-server"
#   }
  
# }

#variable for ami
# variable "ami" {
#   description = "The AMI ID to use for the instance"
#   type        = string
#   default     = "ami-0c55b159cbfafe1f0"
# }
# #variable for Instance type
# variable "instance_type" {
#   description = "The instance type to use for the instance"
#   type        = string
#   default     = "t3.micro"
# }
# #variable for Key pair name
# variable "key_name" {
#   description = "The name of the key pair to use for the instance"
#   type        = string
#   default     = "my-key-pair"
# }
# #variable for Security group ID
# variable "web-server-sg" {
#   description = "The ID of the security group to associate with the instance"
#   type        = string
#   default     = "sg-0c9f8e8e8e8e8e8e8"
# }
# # resource for security group
# resource "aws_security_group" "web-server-sg" {
#   name        = "web-server-sg"
#   description = "Security group for web server"
  
#   ingress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

#===================================================================================================#
# Resource for EC2 instance using the variables defined in variable.tf
resource "aws_instance" "web-server" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  vpc_security_group_ids = [aws_security_group.web-server-sg.id]

  tags = {
    Name = "web-server"
  }
}