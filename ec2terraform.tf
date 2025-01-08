provider "aws" {
  region = "us-east-1"
}

# Replace this with your actual VPC ID
resource "aws_security_group" "allow_ssh_http" {
  name        = "allow_ssh_http"
  description = "Allow SSH, HTTP, HTTPS, and port 5000 access"
  vpc_id      = "vpc-07fc184c1f8b7c854"  # Replace with your VPC ID

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh_http"
  }
}

# Find a subnet in the VPC by specifying availability zone
# Find a subnet in the VPC by specifying availability zone and subnet name
data "aws_subnet" "project-subnet-public1-us-east-1a" {
  vpc_id            = "vpc-07fc184c1f8b7c854"  # Your VPC ID
  availability_zone = "us-east-1a"  # Specify the correct availability zone

  filter {
    name   = "subnet-id"
    values = ["subnet-0a6d4f9ca3850a4db"]  # Use your specific subnet ID
  }
}

# EC2 Instance Configuration  
resource "aws_instance" "ec2terraform" {
  ami                    = "ami-0e2c8caa4b6378d8c"  # Replace with your preferred AMI ID
  instance_type          = "t2.micro"
  key_name               = "docker"   # Replace with your EC2 key pair name

  # Use vpc_security_group_ids to reference the security group by ID
  vpc_security_group_ids = [aws_security_group.allow_ssh_http.id]  # Reference security group by ID
  
  subnet_id              = data.aws_subnet.project-subnet-public1-us-east-1a.id  # Reference to subnet ID

  tags = {
    Name = "Terraform EC2 Instance"
  }
}

