variable "aws_region" {

  type = string

  default = "ap-south-1"

}


variable "hosted_zone_id" {
  type = string
}

variable "jenkins_admin_password" {

  type = string

  sensitive = true
}