############################
# Amazon Linux 2 AMI
############################

data "aws_ami" "amazon_linux" {

  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

############################
# NAT Security Group
############################

resource "aws_security_group" "nat" {

  name        = "nat-instance-sg"
  description = "Security Group for NAT Instance"

  vpc_id = var.vpc_id

  # SSH
  ingress {

    description = "SSH"

    from_port = 22
    to_port   = 22

    protocol = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  # Traffic from VPC
  ingress {

    description = "Traffic from VPC"

    from_port = 0
    to_port   = 0

    protocol = "-1"

    cidr_blocks = [var.vpc_cidr]
  }

  # Internet access
  egress {

    from_port = 0
    to_port   = 0

    protocol = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.common_tags,
    {
      Name = "nat-instance-sg"
    }
  )
}

############################
# NAT Instance
############################

resource "aws_instance" "nat" {

  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet_id
  key_name               = var.key_name

  associate_public_ip_address = true
  source_dest_check           = false

  vpc_security_group_ids = [
    aws_security_group.nat.id
  ]

  metadata_options {
    http_tokens = "required"
  }

  user_data = <<-EOF
#!/bin/bash

yum update -y

sysctl -w net.ipv4.ip_forward=1

echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf

sysctl -p

yum install -y iptables-services

iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

service iptables save

systemctl enable iptables

systemctl restart iptables
EOF

  tags = merge(
    var.common_tags,
    {
      Name = "nat-instance"
    }
  )
}

############################
# Elastic IP
############################

resource "aws_eip" "nat" {

  domain = "vpc"

  instance = aws_instance.nat.id

  tags = merge(
    var.common_tags,
    {
      Name = "nat-instance-eip"
    }
  )
}

############################
# Private Route
############################

resource "aws_route" "private_internet" {

  route_table_id = var.private_route_table_id

  destination_cidr_block = "0.0.0.0/0"

  network_interface_id = aws_instance.nat.primary_network_interface_id
}