############################################################
# SonarQube Hostname
############################################################

variable "hostname" {

  description = "SonarQube Hostname"

  type = string

}

############################################################
# ACM Certificate
############################################################

variable "certificate_arn" {

  description = "ACM Certificate ARN"

  type = string

}

############################################################
# PostgreSQL
############################################################

variable "jdbc_url" {

  description = "PostgreSQL JDBC URL"

  type = string

}

variable "jdbc_username" {

  description = "PostgreSQL Username"

  type = string

}

variable "jdbc_password" {

  description = "PostgreSQL Password"

  type = string

  sensitive = true

}

variable "namespace" {
  type    = string
  default = "sonarqube"
}