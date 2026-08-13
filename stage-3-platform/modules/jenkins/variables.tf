############################################################
# Jenkins Admin
############################################################

variable "jenkins_admin_user" {
  type = string
}

variable "jenkins_admin_password" {
  type      = string
  sensitive = true
}

############################################################
# GitHub
############################################################

variable "github_username" {
  type = string
}

variable "github_token" {
  type      = string
  sensitive = true
}

############################################################
# DockerHub
############################################################

variable "dockerhub_username" {
  type = string
}

variable "dockerhub_password" {
  type      = string
  sensitive = true
}

############################################################
# SonarQube
############################################################

variable "sonar_token" {
  type      = string
  sensitive = true
}

############################################################
# SMTP
############################################################

variable "smtp_username" {
  type = string
}

variable "smtp_password" {
  type      = string
  sensitive = true
}

############################################################
# Ingress
############################################################

variable "certificate_arn" {
  type = string
}

variable "hostname" {
  type = string
}


variable "namespace" {
  type    = string
  default = "jenkins"
}

variable "gitops_username" {
  type = string
}

variable "gitops_token" {
  type      = string
  sensitive = true
}