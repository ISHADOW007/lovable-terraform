resource "github_repository_webhook" "jenkins" {

  for_each = toset(var.repositories)

  repository = each.value

  active = true

  events = [
    "push"
  ]

  configuration {

    url = "${var.jenkins_url}/github-webhook/"

    content_type = "json"

    insecure_ssl = false
  }
}