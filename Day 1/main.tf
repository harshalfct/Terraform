provider "aws" {
  region = "ap-southe-1"  
}

resource "aws_instance" "tf-server" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t3.micro"
  key_name      = "my-key-pair"
  vpc_security_group_ids = [aws_security_group.tf-server-sg.id]

  tags = {
    Name = "tf-server"
  }
}

# Define a security group for the instance
resource "aws_security_group" "tf-server-sg" {
  name        = "tf-server-sg"
  description = "Allow SSH and HTTP traffic"
  vpc_id      = "vpc-0123456789abcdef0"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#count
resource "aws_instance" "tf-server" {
  count         = 2
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t3.micro"
  key_name      = "my-key-pair"
  vpc_security_group_ids = [aws_security_group.tf-server-sg.id]

  tags = {
    Name = "tf-server-${count.index + 1}"
  }
}

# for_each
resource "aws_instance" "tf-server" {
  for_each      = toset(["server1", "server2"])
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t3.micro"
  key_name      = "my-key-pair"
  vpc_security_group_ids = [aws_security_group.tf-server-sg.id]

  tags = {
    Name = each.key
  }
}

#for_map create same instace with same AMI
resource "aws_instance" "tf-server" {
  for_each      = {
    server1 = "ami-0c55b159cbfafe1f0"
    server2 = "ami-0c55b159cbfafe1f0"
  } 
    ami           = each.value
    instance_type = "t3.micro"
    key_name      = "my-key-pair"
    vpc_security_group_ids = [aws_security_group.tf-server-sg.id]


    tags = {
        Name = each.key
        }
}

#for_map create different instance with different AMI
resource "aws_instance" "tf-server" {
  for_each      = {
    server1 = "ami-0c55b159cbfafe1f0"
    server2 = "ami-0d5d9d301c853a04a"
  }
    ami           = each.value
    instance_type = "t3.micro"
    key_name      = "my-key-pair"
    vpc_security_group_ids = [aws_security_group.tf-server-sg.id]

    tags = {
        Name = each.key
        }
}

#for_map create different instance with different AMI and different instance type

# resource "aws_instance" "tfserver" {
#     for_each = tomap({
#         db = ["t3.small", "ami-01a00762f46d584a1"]
#         web = ["t3.micro", "ami-0cd4165aeb4c1a32d"]
#     })
#     ami = each.value[1]
#     instance_type = each.value[0]
#     key_name = "docker_host"
#     vpc_security_group_ids = [ aws_security_group.demotf-sg.id ]
#     tags = {
#       Name = each.key
#     }
# }

resource "aws_instance" "tf-server" {
  for_each      = {
    DB = {
      ami           = "ami-0c55b159cbfafe1f0"
      instance_type = "t3.micro"
    }
    Web = {
      ami           = "ami-0d5d9d301c853a04a"
      instance_type = "t3.small"
    }
  }
  ami           = each.value.ami
  instance_type = each.value.instance_type
  key_name      = "my-key-pair"
  vpc_security_group_ids = [aws_security_group.tf-server-sg.id]

  tags = {
    Name = each.key
  }
}

