resource "aws_instance" "public" {
    ami                         = "ami-053b0d53c279acc90"
    associate_public_ip_address = true
    instance_type               = "t2.micro"
    key_name                    = "Terraform"
    vpc_security_group_ids      = [aws_security_group.public.id]
    
    tags = {
        Name = "${var.env_code}-public"
    }
}

resource "aws_security_group" "public" {
  name        = "${var.env_code}-public"
  description = "Allow inbound traffic"
  vpc_id      = "vpc-04d089f83f04132c6"

  ingress {
    description      = "ssh from public"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.main.cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env_code}-public"
  }
}