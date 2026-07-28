variable "jenkins_admin_password" {
  type      = string
  sensitive = true
}

variable "certificate_arn" {
  type = string
}

variable "hostname" {
  type = string
}