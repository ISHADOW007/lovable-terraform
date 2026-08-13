############################################################
# AWS
############################################################

variable "aws_region" {
  type    = string
  default = "ap-south-1"
}

############################################################
# Route53
############################################################

variable "hosted_zone_id" {
  type = string
}

############################################################
# Jenkins
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
# SonarQube
############################################################

variable "sonar_token" {
  type      = string
  sensitive = true
}

variable "sonarqube_admin_password" {
  type      = string
  sensitive = true
}

variable "sonarqube_db_password" {
  type      = string
  sensitive = true
}

############################################################
# Database
############################################################

variable "db_username" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}

############################################################
# Grafana
############################################################

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