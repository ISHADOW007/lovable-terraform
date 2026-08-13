variable "jenkins_admin_user" {
  type = string
}

variable "jenkins_admin_password" {
  type      = string
  sensitive = true
}

variable "github_username" {
  type = string
}

variable "github_token" {
  type      = string
  sensitive = true
}

variable "dockerhub_username" {
  type = string
}

variable "dockerhub_password" {
  type      = string
  sensitive = true
}

variable "smtp_username" {
  type = string
}

variable "smtp_password" {
  type      = string
  sensitive = true
}

variable "sonar_token" {
  type      = string
  sensitive = true
}

variable "sonarqube_admin_password" {
  type      = string
  sensitive = true
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "grafana_admin_user" {
  type = string
}

variable "grafana_admin_password" {
  type      = string
  sensitive = true
}


variable "gitops_username" {
  type = string
}

variable "gitops_token" {
  type      = string
  sensitive = true
}