############################################################
# General
############################################################

variable "name" {

  description = "RDS Instance Name"

  type = string

}

############################################################
# VPC
############################################################

variable "vpc_id" {

  description = "VPC ID"

  type = string

}

variable "private_subnet_ids" {

  description = "Private Subnets"

  type = list(string)

}

variable "eks_node_security_group_id" {

  description = "EKS Node Security Group"

  type = string

}

############################################################
# Database
############################################################

variable "database_name" {

  description = "Database Name"

  type = string

}

variable "username" {

  description = "Database Username"

  type = string

}

variable "password" {

  description = "Database Password"

  type = string

  sensitive = true

}

############################################################
# Instance
############################################################

variable "instance_class" {

  description = "RDS Instance Class"

  type = string

  default = "db.t4g.micro"

}

variable "allocated_storage" {

  description = "Allocated Storage"

  type = number

  default = 20

}

############################################################
# High Availability
############################################################

variable "multi_az" {

  description = "Enable Multi AZ"

  type = bool

  default = false

}