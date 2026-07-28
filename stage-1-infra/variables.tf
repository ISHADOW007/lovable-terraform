variable "aws_region" {
  default = "ap-south-1"
}

variable "cluster_name" {
  default = "lovable-cluster"
}

variable "vpc_name" {
  default = "lovable-vpc"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "availability_zone_1" {
  default = "ap-south-1a"
}

variable "availability_zone_2" {
  default = "ap-south-1b"
}

variable "public_subnet_1_cidr" {
  default = "10.0.1.0/24"
}

variable "public_subnet_2_cidr" {
  default = "10.0.2.0/24"
}

variable "private_subnet_1_cidr" {
  default = "10.0.11.0/24"
}

variable "private_subnet_2_cidr" {
  default = "10.0.12.0/24"
}



variable "key_name" {
  description = "EC2 Key Pair name"
  type        = string
}