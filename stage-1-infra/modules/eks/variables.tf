variable "cluster_name" {
  type = string
}

variable "cluster_role_arn" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "cluster_security_group_id" {
  type = string
}

variable "node_role_arn" {
  type = string
}

variable "worker_security_group_id" {
  type = string
}

variable "tags" {
  type = map(string)
}





variable "node_group_name" {
  type = string
}

variable "instance_types" {
  type = list(string)
}

variable "desired_size" {
  type = number
}

variable "min_size" {
  type = number
}

variable "max_size" {
  type = number
}