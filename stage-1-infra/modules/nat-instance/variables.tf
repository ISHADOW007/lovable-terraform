variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnet_id" {
  description = "Public subnet where NAT instance will be launched"
  type        = string
}

variable "private_route_table_id" {
  description = "Private route table ID"
  type        = string
}

variable "key_name" {
  description = "EC2 Key Pair"
  type        = string
}

variable "instance_type" {
  description = "NAT Instance type"
  type        = string
  default     = "t3.micro"
}

variable "common_tags" {
  description = "Common tags"
  type        = map(string)
}


variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
}