variable "github_owner" {
  type = string
}

variable "github_token" {
  type      = string
  sensitive = true
}

variable "jenkins_url" {
  type = string
}

variable "repositories" {
  type = list(string)
}